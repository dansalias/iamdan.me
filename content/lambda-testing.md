+++
title = "3-line JavaScript Lambda Testing"
date = 2019-11-18
+++

tl;dr: [Import the handler, execute, check the result.](https://gist.github.com/dansalias/be26816ba0b69d2e66a7f5a9c7ef24c7#file-capitalise-spec-js-L3-L5)

Recently my backend development has been focused on serverless technologies,
specifically using [AWS Lambda](https://aws.amazon.com/lambda/).

I wanted to speed up development by testing locally, so I began exploring the
options for creating a local lambda execution environment.

Frameworks such as [Localstack](https://localstack.cloud/) and
[Serverless](https://serverless.com/) are an option, but were a little too heavy
and opinionated for what I was after.
[lambda-local](https://www.npmjs.com/package/lambda-local) showed promise, but I
found it sullied the return object with additional properties which made
assertions difficult.

I began building a solution using [`child_process.fork()`](https://nodejs.org/api/child_process.html#child_process_child_process_fork_modulepath_args_options)
but soon realised that I was completely overthinking the simple truth:

*Lambdas are just JavaScript functions.*

So, why not just treat them the same as any other function?

Let's presume we have a lambda which capitalises a provided name and returns it:

```js
const changeCase = require('change-case');

exports.handler = async function(event) {
  const result = { success: false, name: '' };
  if(event.name) {
    result.name = changeCase.titleCase(event.name);
    result.success = true;
  }
  return result;
}
```

We can add a companion capitalise.spec.js file which imports the function and
executes it directly:

```js
describe('capitalise lambda', () => {
  it('should capitalise the first letter of every word', () => {
    const handler = require('capitalise.js').handler;
    const result = handler({name: 'dan salias'});
    expect(result).toStrictEqual({name: 'Dan Salias'});
  });
});
```

Yes, the test uses the local execution environment. If this doesn’t match the
intended lambda execution environment you can use nvm to either change the node
environment for the project, or toggle the node environment for testing:

```json
{
  //...
  "scripts": {
    "test": "nvm exec 10.16.3 npx jest",
    //...
  },
  //...
  "devDependencies": {
    //...
    "jest": "^24.9.0",
  }
}
```

This essentially mimics the production lambda execution process, and provides
an easy way to use the testing tools you are already familiar with (in my case
[Jest](https://jestjs.io/)) to locally test your lambdas before deploying.

Don’t forget that your lambdas need to be packaged with all of their
dependencies (node_modules) before deploying. So you’ll what to have each
lambda in it’s own directory with it’s own package.json (and/or use [lambda
layers](https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html)
for dependency management).

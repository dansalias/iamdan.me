+++
title = "A Recipe For Creating Great Software Documentation"
date = 2020-02-29
+++

## Start With A Quick Overview

What does the product, package, service, framework, module or plugin do? No more
than a couple of sentences.

## (Optional) - Add A Why

Why does this need to exist? Why is it different from what is already available?
This is the one place where a slight sales pitch is ok, if a justification of
existence is required. This isn’t necessary when the reason for the package is
obvious (e.g. printer drivers for a new 3d printer, when none yet exist), but
is worth considering when multiple alternatives are already available (e.g. an
image manipluation library). Sales has no place beyond this point. Put it on
your homepage. Not in your documentation.

## Include Installation Instructions

Many developers want to dive in and get their hands dirty straight away.
Don’t make it difficult for them. Installation instructions should be
front-and-center, or one click away from landing on the documentation.

## Give An Easy Win

A brief code example builds user confidence and gets the ball rolling. Something
like:

```bash
# installation
npm i my-awesome-package
```

```js
// usage
import awesome from 'my-awesome-package';

const awesomeness = awesome.createAwesomeness('awesome-string');
```

## Introduce The Main Usage Patterns

Ideally one to three. For example:

- For an image manipulation library, show an example of how to resize an image.
- For a validation library, show an example response using valid data, and
  an example using invalid data.
- If this is an SDK for a WiFi-enabled coffee machine, show how to turn on/off
  the machine and make an espresso.

Aim to answer the following question:

If I want to *<crop an image | validate a string | make a cappuccino | other
basic operation>*, what might that look like?

Don't make this section exhaustive. It should fit in a desktop viewport without
scrolling. Add a smattering of links to further reading as appropriate.

## Explain Unique Concepts

Why does your documentation keep referring to “pipelines”? What is a pipeline in
the context of your software?

Explain the core concepts which a user needs to understand in order to become
an expert in using the package. How will they explain what makes the software
useful to their friends/colleagues?

Think of this as an extended glossary. Mention anything unique to this package,
and draw relevant comparisons to other prominent packages and patterns in the
ecosystem.

## Imagine The User Is Learning On-The-Fly

Assume that at this point the user/developer has already installed the package
and started using it. Your goal is to now walk them through how to continue
intergrating it into their project.

This is the time to point out any integration patterns which are unique to
this package. For example, are there differences between using the package in
development vs. production environments?

Be sure to also mention any parts of the broader ecosystem (e.g. learning
resources, a CLI, a public roadmap) which will help in using the package.

Aim to gradually increase understanding of the software’s usage patterns. It
shouldn’t take long for the user to be able to infer how to code something
as yet uncovered in your guide, purely based on the patterns explicitly
demonstrated so far.

## Give Examples

But not too many. The aim is to offer a thorough understanding of the package,
so that additional functionality can be intuitively discovered and implemented.

Expose **patterns**, not every specific use case. Ideally a single example will
impart multiple use cases for free.

Software with a broader scope, such as an eCommerce framework, may justify
extended, project-type examples (e.g. "Acme T-Shirt Store"). These can be placed
in a separate section, such as Examples/Tutorials/Cookbook.

In most cases, relying solely on an extensive step-by-step guide to producing
a sample project should be avoided. Conceptual understanding is far more
beneficial in facilitating every unique use case.

## Include A Comprehensive Reference

The ideas above shape a software guide, which should be complemented by a
detailed reference of the software’s public API. Keep the reference concise
— methods, inputs and outputs — with no more than a sentence, if at all,
explaining each.

The guide and reference complement each other and can link to each other as
appropriate. The guide is an informal document, explaining concepts and giving
examples as needed. The reference is a formal representation of the complete
API, and may even be generated directly from the source code.

## Keep The End User In Mind

Some people have arrived from search looking to install the package right away.
Others have seen it on a message board and want a better idea of how it can help
them. Others still have been using it for some time and want to quickly learn
how to achieve a specific use case.

Be sure that your documentation addresses the needs of all users. Better
documentation means fewer support queries, better software adoption, and happier
users.

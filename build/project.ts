import path from 'node:path'
import { bob, Source } from './bob'
import frontmatter from 'front-matter'
import * as handlebars from 'handlebars'
import * as marked from 'marked'
import { createDirectives as markedDirectives } from 'marked-directive'
import markedFootnote from 'marked-footnote'

const buildHTMLPage = async (
  source: Source,
  data: {
    title: string
    body: string
  }
) => handlebars.compile((await source.get('./templates/base.hbs')).data.toString())(data)

marked.use(
  markedDirectives(),
  markedFootnote(),
  {
  renderer: {
    image: (src, title, alt) => `
      <figure>
        <img src="${ src }" title="${ alt }" alt="${ alt }">
        <figcaption>${ title }</figcaption>
      </figure>
    `,
  },
})

bob.add(async (source, output) => {
  console.log('in builder function...')

  const articles = await Promise.all(
    (await source.getAll('./articles/*.md'))
      .map((file) => ({
        file,
        ...frontmatter<{
          date: string
          title: string
          hn?: string
        }>(file.data.toString())
      }))
      .sort((a, b) => new Date(b.attributes.date).valueOf() - new Date(a.attributes.date).valueOf())
      .map(async ({ attributes, body, file }) => ({
        ...attributes,
        slug: path.parse(file.filepath).name,
        date: new Date(attributes.date).toLocaleDateString(undefined, {
          year: 'numeric',
          month: 'long',
        }),
        body: await marked.parse(body),
      }))
    )

  output.write(
    './index.html',
    await buildHTMLPage(source, {
      title: 'I Am Dan',
      body: handlebars.compile((await source.get('./templates/index.hbs')).data.toString())({
        articles,
      }),
    })
  )

  articles.forEach(async (article) => output.write(
    `${ article.slug }.html`,
    await buildHTMLPage(source, {
      title: `${ article.title } | I Am Dan`,
      body: handlebars.compile((await source.get('./templates/article.hbs')).data.toString())({
        ...article,
      }),
    })
  ))

  ;(await source.getAll([
    './style.css',
    './articles/!(*.md)',
    './resume/daniel-young-résumé.pdf',
  ])).forEach(({ filepath, data }) => output.write(filepath, data))
})

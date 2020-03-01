<template>
  <div class="flex flex-col min-h-screen">
    <header class="bg-me bg-cover text-center text-white px-5 py-32">
      <h1 class="text-4xl font-semibold">Hello! I am Dan.</h1>
      <p class="mt-4 mb-8 text-xl">I'm an engineer on a mission to build better, smarter software.</p>
      <ul>
        <li
          v-for="(link, index) in socialLinks"
          :key="index"
          class="inline-block mx-4"
        >
          <a class="icon-small" :href="link.url" target="_new">
            <img :src="`images/icons/${link.icon}.svg`" class="w-8"/>
          </a>
        </li>
      </ul>
    </header>
    <main class="max-w-3xl mx-auto flex-grow p-8">
      <ul>
        <li
          v-for="(article, index) in articles"
          :key="index"
          class="relative pl-8 article"
        >
          <a
            class="hover:underline"
            :href="`https://medium.com/@dansalias/${article.slug}`"
            target="_new"
          >
            <h1 class="text-2xl mb-6 font-semibold">{{ article.title }}</h1>
          </a>
        </li>
      </ul>
    </main>
    <footer class="py-4 text-center">
      Photo credit <a href="https://www.instagram.com/wojciechbarczuk">Wojciech Barczuk</a>.
      Icons by <a href="https://fontawesome.com">Font Awesome</a>.
      Source code on <a href="https://github.com/dansalias/iamdan.me">GitHub</a>.
    </footer>
  </div>
</template>

<script>
export default {
  name: 'app',
  data: () => ({
    socialLinks: [
      {
        icon: 'linkedin',
        url: 'https://linkedin.com/in/dansalias',
      },
      {
        icon: 'github',
        url: 'https://github.com/dansalias',
      },
      {
        icon: 'medium',
        url: 'https://medium.com/@dansalias',
      },
      {
        icon: 'keybase',
        url: 'https://keybase.io/dansalias',
      },
    ],
    articles: [
      {
        title: 'A Recipe For Creating Great Software Documentation',
        slug: 'a-recipe-for-creating-great-software-documentation-6b372af3d303',
      },
      {
        title: 'Node Versions Without nvm',
        slug: 'node-versions-without-nvm-cb9cdc0566b6',
      },
      {
        title: '3-line JavaScript Lambda Testing',
        slug: '3-line-javascript-lambda-testing-5a4118c94c97',
      },
    ]
  }),
};
</script>

<style>
@import url('https://fonts.googleapis.com/css?family=Source+Sans+Pro:400,600&display=swap');

html, body {
  font-family: 'Source Sans Pro';
}

.bg-me {
  background: linear-gradient(rgba(0,0,0,0.4),rgba(0,0,0,1)), url('/images/me.jpg');
}

li.article:before {
  @apply absolute left-0 top-0 text-2xl -mt-half;
  content: '»';
}

footer a {
  @apply underline text-indigo-700;
}
</style>

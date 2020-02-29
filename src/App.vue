<template>
  <div id="app">
    <Header/>
    <section>
      <h2>I have helped build</h2>
      <ul class="portfolio">
        <PortfolioEntry v-for="(entry, index) in portfolio.entries" :key="index" :entry="entry" :imagePath="portfolio.imagePath"/>
      </ul>
    </section>
    <section>
      <h2>Get in touch</h2>
      <form action="https://formspree.io/danyoungnz@gmail.com" method="POST">
        <input type="email" name="_replyto" placeholder="Your email address">
        <input type="text" name="name" placeholder="Your name">
        <input type="text" name="_subject" placeholder="Subject">
        <textarea name="message" placeholder="Your message"></textarea>
        <input type="submit" value="Send">
      </form>
      <ul class="social-buttons">
        <li><a href="https://linkedin.com/in/dansalias"><img src="images/icons/linkedin.svg">LinkedIn</a></li>
        <li><a href="https://github.com/dansalias"><img src="images/icons/github.svg">GitHub</a></li>
        <li><a href="/daniel_young_resume_19-01.pdf"><img src="images/icons/file.svg">Résumé</a></li>
      </ul>
    </section>
    <footer>
      Portrait by <a href="https://andicrown.com">Andi Crown Photography</a>. Icons by <a href="https://fontawesome.com">Font Awesome</a>. Source code on <a href="https://github.com/d4n13ly/iamdan.me">GitHub</a>.
    </footer>
  </div>
</template>

<script>
import Header from './components/Header.vue';
import PortfolioEntry from './components/PortfolioEntry.vue';

import portfolio from './data/portfolio';

export default {
  name: 'app',
  data: () => ({
    portfolio,
  }),
  components: {
    Header,
    PortfolioEntry,
  },
};
</script>

<style lang="scss">
@import url("https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css");
@import url("https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,600");
@import 'styles/colours';
@import 'styles/defaults';
@import 'styles/typography';
@import 'styles/layout';
@import 'styles/forms';

.portfolio {
  margin: 0px auto;
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
}

.social-buttons {
  display: flex;
  margin: 48px auto 16px;
  width: 100%;
  max-width: 24rem;
  border: 1px solid $dark-grey;
  border-radius: 5px;
  overflow: hidden;
  font-size: 0.85rem;
  li {
    flex-grow: 1;
    &:not(:last-child) {
      border-right: 1px solid $dark-grey;
    }
    a {
      display: flex;
      width: 100%;
      height: 36px;
      justify-content: center;
      align-items: center;
      &:hover {
        background: $light-grey;
      }
    }
  }
  img {
    margin: 0 0.2rem 0 0;
    width: 20px;
    height: 20px;
    vertical-align: middle;
  }
}

footer {
  padding: 20px 0 0 0;
  font-size: 0.8em;
  color: $dark-grey;
  a {
    border-bottom: 1px dotted $medium-grey;
  }
}
</style>

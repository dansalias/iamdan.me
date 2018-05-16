<template>
  <div id="app">
    <Header/>
    <section>
      <h2>I have helped build</h2>
      <ul>
        <li v-for="(item, index) in portfolio" :key="index">
          {{ item.name }}
        </li>
      </ul>
    </section>
  </div>
</template>

<script>
import Header from './components/Header.vue';

import portfolio from './data/portfolio';

export default {
  name: 'app',
  data: () => ({
    portfolio,
  }),
  components: {
    Header,
  },
};
</script>

<style lang="scss">
@import url("https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css");
@import url("https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,600");
@import 'styles/typography';
</style>

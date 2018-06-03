<template>
  <li class="portfolio-entry">
    <a :style="{ background: entry.background }" :title="entry.name" :href="entry.url">
      <img :src="imagePath + entry.image"/>
    </a>
  </li>
</template>

<script>
export default {
  props: ['entry', 'imagePath'],
};
</script>

<style lang="scss">
.portfolio-entry {
    margin: 0 12px 24px;
    box-shadow: 2px 2px 8px #cccccc;
    a {
      position: relative;
      display: block;
      width: 280px;
      height: 200px;
      img {
        position: absolute;
        left: 0;
        right: 0;
        top: 0;
        bottom: 0;
        margin: auto;
        width: 80%;
      }
    }
  }
</style>

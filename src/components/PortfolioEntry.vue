<template>
  <li class="portfolio-entry" :style="{ background: entry.background }" :title="entry.name">
    <img :src="imagePath + entry.image"/>
  </li>
</template>

<script>
export default {
  props: ['entry', 'imagePath'],
};
</script>

<style lang="scss">
  .portfolio-entry {
    position: relative;
    width: 280px;
    height: 200px;
    margin: 0 12px 24px;
    box-shadow: 2px 2px 8px #cccccc;
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
</style>

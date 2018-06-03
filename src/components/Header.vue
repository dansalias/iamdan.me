<template>
  <header>
    <div id="profile-image">
      <img src="images/me.jpg">
    </div>
    <section>
      <h1>Hello! I am Dan.</h1>
      <p>I am a software developer currently based in Auckland, New&nbsp;Zealand.</p>
      <p>I specialise in Full-Stack Web Application Development, DevOps and Cloud Architecture.</p>
    </section>
  </header>
</template>

<style lang="scss">
  @import '../styles/colours';
  #profile-image {
    position: relative;
    width: 200px;
    height: 200px;
    margin: 0 auto;
    border-radius: 50%;
    border: 1px solid $dark-grey;
    overflow: hidden;
  }
</style>

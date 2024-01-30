<template>
  <div class="container">
    <!-- pageコンポーネントを呼び出すために必要(reactでいう{component}) -->
    <slot />
    <footer>&copy; proglus.jp</footer>
  </div>
</template>
<style>
.container {
  color: rgb(0, 61, 35);
}

footer {
  background-color: rgb(0, 175, 70);
  color: white;
  text-align: center;
}

html {
  font-family: "Permanent Marker", cursive;
}

img {
  max-width: 60%;
}
</style>

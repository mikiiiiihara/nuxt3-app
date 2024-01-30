<template>
  <!-- １テンプレート１要素なのはreactと同じ -->
  <div>
    <h1>Counter Page</h1>
    <hr />
    <h1>{{ count }}</h1>
    <button @click="countState.addCount()">+</button>
    <button @click="countState.minusCount()">-</button>
    <button @click="countState.reset()">reset</button>
  </div>
</template>
<script setup>
const countState = useCount();
const { count } = countState;
</script>

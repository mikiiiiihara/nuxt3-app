<template>
  <!-- １テンプレート１要素なのはreactと同じ -->
  <div>
    <h1>users/{{ $route.params.id }}を表示中</h1>
    <hr />
    <NuxtLink to="/">Top Page</NuxtLink>
  </div>
</template>

<script setup>
import { useRoute } from "vue-router";

const route = useRoute();
definePageMeta({
  validate: async (route) => {
    return /^\d+$/.test(route.params.id);
  },
});
</script>

<template>
  <NuxtLayout>
    <!-- １テンプレート１要素なのはreactと同じ -->
    <div v-if="error.statusCode === 404">
      <h1>Error!</h1>
      <p>{{ error.message }}</p>
      <hr />
    </div>
  </NuxtLayout>
</template>
<script setup>
const error = useError();
</script>

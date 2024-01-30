<template>
  <!-- １テンプレート１要素なのはreactと同じ -->
  <div>
    <h1>Fetch Page</h1>
    <hr />
    <ul>
      <li v-for="user in users" :key="user.id">
        {{ user.id }}, {{ user.name }}
      </li>
    </ul>
  </div>
</template>
<script setup>
const { data: users, error } = await useFetch(
  "https://jsonplaceholder.typicode.com/users"
);
if (error.value) {
  throw createError({ statusCode: 404, statusMessage: "Page Not Found!!" });
}
</script>

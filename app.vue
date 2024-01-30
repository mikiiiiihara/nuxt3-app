<template>
  <div>
    <!-- import文は不要 -->
    <NuxtLayout>
      <NuxtPage />
    </NuxtLayout>
  </div>
</template>
<script setup>
useHead({
  title: "Nuxt 3 Store",
  link: [
    {
      rel: "stylesheet",
      href: "https://fonts.googleapis.com/css2?family=Permanent+Marker&display=swap",
    },
  ],
});
</script>

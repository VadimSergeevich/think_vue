<template lang="pug">
q-layout(view="hHh lpR fFf")
  navbar
  q-page-container
    q-page
      router-view
</template>

<script>
  import Navbar from './staff/components/Navbar';
  export default {
    components: { Navbar },
  };
</script>

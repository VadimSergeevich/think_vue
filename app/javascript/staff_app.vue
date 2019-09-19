<template lang="pug">
q-layout(view="hHh lpR fFf")
  navbar
  q-page-container
    q-page
      dashboard
</template>

<script>
  import Navbar from './staff/components/Navbar';
  import Dashboard from './staff/components/Dashboard';
  export default {
    components: { Navbar, Dashboard },
  };
</script>

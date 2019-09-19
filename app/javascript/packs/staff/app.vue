<template lang="pug">
.container
  navbar
  dashboard
</template>

<script>
  import Navbar from './components/Navbar';
  import Dashboard from './components/Dashboard';

  export default {
    components: { Navbar, Dashboard },
  };
</script>

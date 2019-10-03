<template lang="pug">
div
  ClientForm(@clientCreated="clientCreated")
  ClientsList(:clients='clients' :loading='loading')
</template>

<script>
  import ClientForm from './Form';
  import ClientsList from './List';
  import DashboardMixin from '../../mixins/Dashboard';

  export default {
    mixins: [DashboardMixin],
    components: { ClientForm, ClientsList },
    data() {
      return {
        clients: [{}],
      };
    },
    methods: {
      clientCreated(client) {
        this.clients.unshift(client);
      },
    },
  };
</script>

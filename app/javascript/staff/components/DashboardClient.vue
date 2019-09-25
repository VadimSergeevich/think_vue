<template lang="pug">
div
  ClientForm(@addClient="addClient")
  ClientsList(:clients='clients' :loading='loading')
</template>

<script>
  import ClientForm from './ClinetForm';
  import ClientsList from './ClientsList';

  export default {
    components: { ClientForm, ClientsList },
    data() {
      return {
        loading: true,
        clients: [{}],
      };
    },
    created() {
      new this.$apiClient('/api/v1/staff/clients').get().then(json => {
        this.clients = json.data.map(i => i.attributes);
        this.loading = false;
      });
    },
    methods: {
      addClient(client) {
        this.clients.unshift(client);
      },
    },
  };
</script>

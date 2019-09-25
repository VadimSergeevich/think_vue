<template lang="pug">
div
  OrganizationForm(@addOrg="addOrg")
  OrganizationsList(:organizations='organizations' :loading='loading')
</template>
<script>
  import OrganizationForm from './OrganizationForm';
  import OrganizationsList from './OrganizationsList';

  export default {
    components: { OrganizationForm, OrganizationsList },
    data() {
      return {
        loading: true,
        organizations: [{}],
      };
    },
    created() {
      new this.$apiClient('/api/v1/staff/organizations').get().then(json => {
        this.organizations = json.data.map(i => i.attributes);
        this.loading = false;
      });
    },
    methods: {
      addOrg(org) {
        this.organizations.unshift(org);
      },
    },
  };
</script>

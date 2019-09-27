<template lang="pug">
div
  OrganizationForm(@addOrg="addOrg")
  OrganizationsList(:organizations='organizations' :loading='loading')
</template>
<script>
  import OrganizationForm from './Form';
  import OrganizationsList from './List';
  import DashboardMixin from '../../mixins/Dashboard';

  export default {
    mixins: [DashboardMixin],
    components: { OrganizationForm, OrganizationsList },
    data() {
      return {
        organizations: [{}],
      };
    },
    methods: {
      addOrg(org) {
        this.organizations.unshift(org);
      },
    },
  };
</script>

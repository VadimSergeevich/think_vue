<template lang="pug">
div
  OrganizationForm(@organizationCreated="organizationCreated")
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
      organizationCreated(org) {
        this.organizations.unshift(org);
      },
    },
  };
</script>

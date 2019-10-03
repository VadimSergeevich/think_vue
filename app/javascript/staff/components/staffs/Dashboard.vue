<template lang="pug">
div
  StaffForm(@staffCreated="staffCreated")
  StaffList(:staffs='staffs' :loading='loading')
</template>

<script>
  import StaffForm from './Form';
  import StaffList from './List';
  import DashboardMixin from '../../mixins/Dashboard';

  export default {
    mixins: [DashboardMixin],
    components: { StaffForm, StaffList },
    data() {
      return {
        staffs: [{}],
      };
    },
    methods: {
      staffCreated(staff) {
        this.staffs.unshift(staff);
      },
    },
  };
</script>

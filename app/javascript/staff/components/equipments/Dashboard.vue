<template lang="pug">
div
  EqupmentForm(@equipmentCreated="equipmentCreated")
  EqupmentsList(:equipments='equipments', :loading='loading')
</template>

<script>
  import EqupmentForm from './Form.vue';
  import EqupmentsList from './List.vue';
  import DashboardMixin from '../../mixins/Dashboard';

  export default {
    mixins: [DashboardMixin],
    components: { EqupmentForm, EqupmentsList },
    data() {
      return {
        equipments: [{}],
      };
    },
    methods: {
      equipmentCreated(equipment) {
        this.equipments.unshift(equipment);
      },
    },
  };
</script>

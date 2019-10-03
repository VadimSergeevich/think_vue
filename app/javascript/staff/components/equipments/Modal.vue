<template lang="pug">
q-dialog(ref="dialog" v-model='showDialog' @hide="changeRoute")
  q-card
    q-card-section
      EquipmentForm(:equipment="entityData" @equipmentUpdated="hide")
</template>

<script>
  import EquipmentForm from './Form';
  import ModalMixin from '../../mixins/Modal';

  export default {
    mixins: [ModalMixin],
    components: { EquipmentForm },
  };
</script>

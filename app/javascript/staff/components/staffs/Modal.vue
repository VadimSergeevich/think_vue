<template lang="pug">
q-dialog(ref="dialog" v-model='showDialog' @hide="changeRoute")
  q-card
    q-card-section
      StaffForm(:staff="entityData" @staffUpdated="hide")
</template>

<script>
  import StaffForm from './Form';
  import ModalMixin from '../../mixins/Modal';

  export default {
    mixins: [ModalMixin],
    components: { StaffForm },
  };
</script>

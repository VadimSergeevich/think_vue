<template lang="pug">
q-dialog(ref="dialog" v-model='showDialog' @hide="changeRoute")
  q-card
    q-card-section
      ClientForm(:client="entityData" @clientUpdated="hide")
</template>

<script>
  import ClientForm from './Form';
  import ModalMixin from '../../mixins/Modal';

  export default {
    mixins: [ModalMixin],
    components: { ClientForm },
  };
</script>

<template lang="pug">
q-dialog(ref="dialog" v-model='showDialog' @hide="changeRoute")
  q-card
    q-card-section
      OrganizationForm(:organization="entityData" @organizationUpdated="hide")
</template>

<script>
  import OrganizationForm from './Form';
  import ModalMixin from '../../mixins/Modal';

  export default {
    mixins: [ModalMixin],
    components: { OrganizationForm },
  };
</script>

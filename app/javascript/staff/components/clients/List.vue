<template lang="pug">
.row.q-mt-xl
  .offset-2.col-8
    q-table(
      title="Clients"
      :data="clients"
      :columns="columns"
      :loading='loading'
      row-key="id")
      template(v-slot:body-cell-action="props")
        q-td(key="key" :props="props")
          q-btn(stretch flat type="a" @click='editDialog(props.row)' label="Edit")
    div(v-if="showModal")
      router-view(name="ClientModalEdit")
</template>

<script>
  import Modal from './Modal';
  import ListMixin from '../../mixins/List';

  export default {
    props: {
      clients: Array,
    },
    mixins: [ListMixin],
    data() {
      return {
        showModal: this.$route.meta.showModal,
        columns: [
          {
            name: 'fullname',
            required: true,
            label: 'Fullname',
            align: 'left',
            field: 'fullname',
            sortable: true,
          },
          {
            name: 'email',
            align: 'center',
            label: 'Email',
            field: 'email',
          },
          { name: 'phone', label: 'Phone', field: 'phone' },
          {
            name: 'action',
            label: 'Edit',
            field: 'key',
          },
        ],
      };
    },
  };
</script>

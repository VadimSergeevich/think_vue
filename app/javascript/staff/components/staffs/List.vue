<template lang="pug">
.row.t-mt-xl
  .offset-2.col-8
    q-table(
      title="Staffs"
      :data="staffs"
      :columns="columns"
      :loading='loading'
      row-key="id")
      template(v-slot:body-cell-action="props")
        q-td(key="key" :props="props")
          q-btn(stretch flat type="a" @click='editDialog(props.row)' label="Edit")
    div(v-if="showModal")
      router-view(name="StaffModalEdit")
</template>

<script>
  import Modal from './Modal';
  import ListMixin from '../../mixins/List';

  export default {
    props: {
      staffs: Array,
    },
    mixins: [ListMixin],
    data() {
      return {
        columns: [
          {
            name: 'email',
            required: true,
            label: 'Email',
            align: 'left',
            field: 'email',
            sortable: true,
          },
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

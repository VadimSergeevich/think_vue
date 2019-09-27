<template lang="pug">
.row.q-mt-xl
  .offset-2.col-8
    q-table(
      title="Organizations"
      :data="organizations"
      :columns="columns"
      :loading='loading'
      row-key="id")
      template(v-slot:body-cell-action="props")
        q-td(key="key" :props="props")
          q-btn(stretch flat type="a" @click='editDialog(props.row)' label="Edit")
    div(v-if="showModal")
      router-view(name="OrganizationModalEdit")
</template>
<script>
  import Modal from './Modal';
  import ListMixin from '../../mixins/List';

  export default {
    props: {
      organizations: Array,
    },
    mixins: [ListMixin],
    data() {
      return {
        columns: [
          {
            name: 'name',
            required: true,
            label: 'Name',
            align: 'left',
            field: 'name',
            sortable: true,
          },
          {
            name: 'kind',
            align: 'center',
            label: 'Type',
            field: 'kind',
            sortable: true,
          },
          { name: 'inn', label: 'INN', field: 'inn' },
          { name: 'ogrn', label: 'OGRN', field: 'ogrn' },
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

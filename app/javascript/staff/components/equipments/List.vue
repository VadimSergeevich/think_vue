<template lang="pug">
.row.q-mt-xl
  .offset-2.col-8
    q-table(
      title="Equipments"
      :data="equipments"
      :columns="columns"
      :loading='loading'
      row-key="id")
      template(v-slot:body-cell-action="props")
        q-td(key="key" :props="props")
          q-btn(stretch flat type="a" @click='editDialog(props.row)' label="Edit")
      template(v-slot:body-cell-organization="props")
        q-td(key="organization" :props="props")
          | {{props.row.organization && props.row.organization.label}}
    div(v-if="showModal")
      router-view(name="EquipmentModalEdit")
</template>

<script>
  import Modal from './Modal';
  import ListMixin from '../../mixins/List';

  export default {
    props: {
      equipments: Array,
    },
    mixins: [ListMixin],
    data() {
      return {
        columns: [
          {
            name: 'title',
            required: true,
            label: 'Title',
            align: 'left',
            field: 'title',
            sortable: true,
          },
          {
            name: 'kind',
            align: 'center',
            label: 'Kind',
            field: 'kind',
          },
          { name: 'serial', label: 'Serial', field: 'serial' },
          {
            name: 'organization',
            label: 'Organization',
            field: 'organization.label',
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

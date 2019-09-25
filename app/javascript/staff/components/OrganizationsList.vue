<template lang="pug">
.row.q-mt-xl
  .offset-2.col-8
    q-table(
      title="Organizations"
      :data="organizations"
      :columns="columns"
      :loading='loading'
      row-key="id")
</template>
<script>
  export default {
    props: {
      organizations: Array,
      loading: Boolean,
    },
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
        ],
      };
    },
  };
</script>

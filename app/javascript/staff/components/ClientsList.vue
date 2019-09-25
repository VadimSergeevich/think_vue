<template lang="pug">
.row.q-mt-xl
  .offset-2.col-8
    q-table(
      title="Clients"
      :data="clients"
      :columns="columns"
      :loading='loading'
      row-key="id")
</template>

<script>
  export default {
    props: {
      clients: Array,
      loading: Boolean,
    },
    data() {
      return {
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
        ],
      };
    },
  };
</script>

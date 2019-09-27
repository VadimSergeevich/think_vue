<template lang="pug">
div
  .row
    .offset-3.col-6
      q-form.q-gutter-xs(@submit="onSubmit" ref="myForm")
        q-input(v-model="equipmentData.title" label="Title" :rules="[required]")
        q-select(v-model="equipmentData.kind" :options="kindOptions" label="Type"
        emit-value map-options)
        q-input(v-model="equipmentData.serial" label="Serial" :rules="[required]")
        q-select(use-input v-model="equipmentData.organization" :options="organizationSuggestions"
        @filter='fetchOrganization' label="Organizations" color="secondary")
          template(v-slot:selected-item="scope")
            q-chip.q-ma-xs(dense="" :tabindex="scope.tabindex" color="white" text-color="secondary")
              | {{scope.opt.label}}
        .row.justify-center
          q-btn(label="Submit" type="submit" color="primary" )
</template>

<script>
  import FormMixin from '../../mixins/Form';

  const kindOptions = [
    {
      value: 0,
      label: 'Laptop',
    },
    {
      value: 1,
      label: 'Desktop',
    },
  ];

  export default {
    mixins: [FormMixin],
    props: {
      equipment: {
        type: Object,
        default: function() {
          return {};
        },
      },
    },
    data() {
      return {
        equipmentData: {},
        kindOptions,
        organizationSuggestions: [],
      };
    },
    watch: {
      'equipmentData.organization'(newVal) {
        this.equipmentData.organization_id = newVal.value;
      },
      equipment(newVal) {
        this.equipmentData = newVal;
      },
    },
    methods: {
      fetchOrganization(val, update, abort) {
        if (val.length < 2) {
          abort();
          return;
        }
        update(() => {
          new this.$apiClient('/api/v1/staff/organizations', { name: val })
            .get()
            .then(json => {
              this.organizationSuggestions = json.data.map(c => ({
                value: c.attributes.id,
                label: c.attributes.name,
              }));
            });
        });
      },
    },
  };
</script>

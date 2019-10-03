<template lang="pug">
div
  .row
    .offset-3
    .col-6
      q-form.q-gutter-xs(@submit="onSubmit" ref='myForm')
        q-select(v-model="organizationData.name" use-input hide-selected fill-input input-debounce="300" emit-value
        :options="nameSuggestions" label="Name" @filter="fetchDadataInfo" @input="setDadataFileds")
          template(v-slot:no-option="")
            q-item
              q-item-section.text-grey
                | No results
        q-select(v-model="organizationData.kind" :options="kindOptions" label="Type"
        emit-value map-options)
        q-input(v-model="organizationData.inn" label="INN" :rules="[onlyDigitals, inn]")
        q-input(v-model="organizationData.ogrn" label="OGRN" :rules="[onlyDigitals]")

        q-select(use-input v-model="organizationData.clients" :options="clientsSuggestions"
        multiple @filter='fetchClients' label="Clients" color="secondary")
          template(v-slot:selected-item="scope")
            q-chip.q-ma-xs(dense="" :tabindex="scope.tabindex" color="white" text-color="secondary")
              | {{scope.opt.label}}
        .row.justify-center
          q-btn(label="Submit" type="submit" color="primary" )
</template>
<script>
  import dadataApiClient from '../../../utils/dadataApiClient';
  import { onlyDigitals, inn } from '../../../utils/validations';
  import FormMixin from '../../mixins/Form';

  const kindOptions = [
    {
      value: 0,
      label: 'Individual entrepreneur',
    },
    {
      value: 1,
      label: 'Legal entity',
    },
  ];

  export default {
    mixins: [FormMixin],
    props: {
      organization: {
        type: Object,
        default: function() {
          return { clients: [] };
        },
      },
    },
    watch: {
      'organizationData.clients'(newVal) {
        this.organizationData.client_ids = newVal.map(c => c.value);
      },
      organization(newVal) {
        this.organizationData = newVal;
      },
    },
    data() {
      return {
        defaultData: { clients: [] },
        organizationData: this.organization,
        nameSuggestions: [],
        clientsSuggestions: [],
        kindOptions,
        suggestions: [],
      };
    },
    methods: {
      setDadataFileds(val) {
        this.organizationData.name = val.value;
        this.organizationData.inn = val.data.inn;
        this.organizationData.ogrn = val.data.ogrn;
        if (val.data.type == 'INDIVIDUAL') {
          this.organizationData.kind = 0;
        } else if (val.data.type == 'LEGAL') {
          this.organizationData.kind = 1;
        }
      },
      fetchDadataInfo(val, update, abort) {
        if (val.length < 2) {
          abort();
          return;
        }
        update(() => {
          new dadataApiClient(val).organizations().then(json => {
            this.nameSuggestions = json.suggestions.map(s => ({
              value: s,
              label: s.value,
            }));
          });
        });
      },
      fetchClients(val, update, abort) {
        if (val.length < 2) {
          abort();
          return;
        }
        update(() => {
          new this.$apiClient('/api/v1/staff/clients', { fullname: val })
            .get()
            .then(json => {
              this.clientsSuggestions = json.data.map(c => ({
                value: c.attributes.id,
                label: c.attributes.fullname,
              }));
            });
        });
      },
      onlyDigitals,
      inn,
    },
  };
</script>

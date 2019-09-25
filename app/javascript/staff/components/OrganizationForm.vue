<template lang="pug">
div
  .row
    .offset-3
    .col-6
      q-form.q-gutter-xs(@submit="onSubmit" ref='orgForm')
        q-select(v-model="newOrg.name" use-input hide-selected fill-input input-debounce="300" emit-value
        :options="nameSuggestions" label="Name" @filter="fetchDadataInfo" @input="setDadataFileds")
          template(v-slot:no-option="")
            q-item
              q-item-section.text-grey
                | No results
        q-select(v-model="newOrg.kind" :options="kindOptions" label="Type"
        emit-value map-options)
        q-input(v-model="newOrg.inn" label="INN" :rules="[onlyDigitals, inn]")
        q-input(v-model="newOrg.ogrn" label="OGRN" :rules="[onlyDigitals]")
        .row.justify-center
          q-btn(label="Submit" type="submit" color="primary" )
</template>
<script>
  import dadataApiClient from '../../utils/dadataApiClient';
  import { onlyDigitals, inn } from '../../utils/validations';

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
    data() {
      return {
        loading: true,
        newOrg: {},
        nameSuggestions: [],
        kindOptions,
        errors: {},
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
    methods: {
      setDadataFileds(val) {
        this.newOrg.name = val.value;
        this.newOrg.inn = val.data.inn;
        this.newOrg.ogrn = val.data.ogrn;
        if (val.data.type == 'INDIVIDUAL') {
          this.newOrg.kind = 0;
        } else if (val.data.type == 'LEGAL') {
          this.newOrg.kind = 1;
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
      onSubmit() {
        new this.$apiClient('/api/v1/staff/organizations', {
          organization: this.newOrg,
        })
          .post()
          .then(json => {
            if (json.errors) {
              this.errors = json.errors;
            } else {
              this.newOrg = {};
              this.$emit('addOrg', json.data.attributes);
              this.$nextTick(() => {
                this.$refs.orgForm.resetValidation();
              });
            }
          });
      },
      onlyDigitals,
      inn,
    },
  };
</script>

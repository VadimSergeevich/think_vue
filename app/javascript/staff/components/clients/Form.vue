<template lang="pug">
.row
  .offset-3.col-6
    q-form.q-gutter-xs(@submit="onSubmit" ref="myForm")
      q-input(v-model="clientData.fullname" label="Fullname" :rules="[required, val => minLength(val, 5)]")
      q-input(v-model="clientData.email" label="Email" :rules="[required, email]"
      @blur="checkDataUniq('email')" :error='!!errors.email' :error-message='errors.email')
      q-input(v-model="clientData.phone" label="Phone" :rules="[required, onlyDigitals]"
      @blur="checkDataUniq('phone')" :error='!!errors.phone' :error-message='errors.phone')
      q-input(v-model="clientData.password" type="password" label="Password"
      :rules="[requiredPassword]" :error='!!errors.password' :error-message='errors.password')
      q-select(use-input v-model="client.organizations" :options="organizationSuggestions"
      multiple @filter='fetchOrganization' label="Organizations" color="secondary")
        template(v-slot:selected-item="scope")
          q-chip.q-ma-xs(dense="" :tabindex="scope.tabindex" color="white" text-color="secondary")
            | {{scope.opt.label}}
      .row.justify-center
        q-btn(label="Submit" type="submit" color="primary" )
</template>

<script>
  import { minLength, onlyDigitals } from '../../../utils/validations';
  import FormMixin from '../../mixins/Form';

  export default {
    mixins: [FormMixin],
    props: {
      client: {
        type: Object,
        default: function() {
          return { organizations: [] };
        },
      },
    },
    watch: {
      'clientData.organizations'(newVal) {
        this.clientData.organization_ids = newVal.map(c => c.value);
      },
      client(newVal) {
        this.clientData = newVal;
      },
    },
    data() {
      return {
        clientData: {},
        defaultData: { organization: [] },
        organizationSuggestions: [],
      };
    },
    methods: {
      checkDataUniq(type) {
        new this.$apiClient('/api/v1/staff/clients/validate', {
          client: { [type]: this.clientData[type] },
        })
          .get()
          .then(json => {
            json.errors && (this.errors = json.errors);
          });
      },
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
      minLength,
      onlyDigitals,
    },
  };
</script>

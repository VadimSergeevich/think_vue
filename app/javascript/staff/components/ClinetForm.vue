<template lang="pug">
div
  .row
    .offset-3.col-6
      q-form.q-gutter-xs(@submit="onSubmit" ref="myForm")
        q-input(v-model="newClient.fullname" label="Fullname" :rules="[required, val => minLength(val, 5)]")
        q-input(v-model="newClient.email" label="Email" :rules="[required, email]"
        @blur="checkDataUniq('email')" :error='!!errors.email' :error-message='errors.email')
        q-input(v-model="newClient.phone" label="Phone" :rules="[required, onlyDigitals]"
        @blur="checkDataUniq('phone')" :error='!!errors.phone' :error-message='errors.phone')
        .row.justify-center
          q-btn(label="Submit" type="submit" color="primary" )
</template>

<script>
  import {
    email,
    required,
    minLength,
    onlyDigitals,
  } from '../../utils/validations';

  export default {
    data() {
      return {
        newClient: {},
        errors: {},
      };
    },
    methods: {
      onSubmit() {
        new this.$apiClient('/api/v1/staff/clients', { client: this.newClient })
          .post()
          .then(json => {
            if (json.errors) {
              this.errors = json.errors;
            } else {
              this.newClient = {};
              this.$emit('addClient', json.data.attributes);
              this.$nextTick(() => {
                this.$refs.myForm.resetValidation();
              });
            }
          });
      },
      checkDataUniq(type) {
        new this.$apiClient('/api/v1/staff/clients/validate', {
          client: { [type]: this.newClient[type] },
        })
          .get()
          .then(json => {
            json.errors && (this.errors = json.errors);
          });
      },
      email,
      required,
      minLength,
      onlyDigitals,
    },
  };
</script>

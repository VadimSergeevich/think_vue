<template lang="pug">
.dashboard
  .columns
    .client-form.column.is-6.is-offset-3
      form
        .field
          p.control.has-icons-left.has-icons-right
            input.input(type="text" placeholder="Fullname"  v-model='newClient.fullname')
            span.icon.is-small.is-left
              i.fas.fa-user
          .help.is-danger {{ errors.fullname }}
        .field
          p.control.has-icons-left.has-icons-right
            input.input(type="email" placeholder="Email" v-model='newClient.email'
            @blur="checkDataUniq('email')")
            span.icon.is-small.is-left
              i.fas.fa-envelope
          .help.is-danger {{ errors.email }}
        .field
          p.control.has-icons-left
            input.input(type="phone" placeholder="Phone"  v-model='newClient.phone'
            @blur="checkDataUniq('phone')")
            span.icon.is-small.is-left
              i.fas.fa-phone
          .help.is-danger {{ errors.phone }}
        .field
          p.control
            button.button.is-success(@click='saveClient' type="button"
            :disabled="Object.keys(this.errors).length > 0")
              | Save client
  .columns
    .client-list.column.is-8.is-offset-2
      .box
        table.table.is-fullwidth
          thead
            tr
              th Fullname
              th Email
              th Phone
          tbody
            tr(v-for="client in clients" :key="client.id")
             td {{ client.fullname }}
             td {{ client.email }}
             td {{ client.phone }}
</template>

<script>
  import { validateEmail } from '../../utils/validations';
  import apiClient from '../../utils/apiClient';

  export default {
    data() {
      return {
        newClient: { email: '', phone: '', fullname: '' },
        errors: {},
        clients: [],
      };
    },
    created() {
      new apiClient('/api/v1/staff/clients').get().then(json => {
        this.clients = json.data;
      });
    },
    watch: {
      'newClient.fullname'(val) {
        val.length < 5
          ? (this.errors.fullname = 'Min 5 chars')
          : delete this.errors.fullname;
      },
      'newClient.phone'(val, oldVal) {
        if (val.length < 5) {
          this.errors.phone = 'Min 5 chars';
        } else if (!/^\d+$/.test(val)) {
          this.errors.phone = 'Only numbers';
          this.newClient.phone = oldVal;
        } else {
          delete this.errors.phone;
        }
      },
      'newClient.email'(val, oldVal) {
        if (val.length == 0) {
          this.errors.email = 'Required';
        } else if (!validateEmail(val)) {
          this.errors.email = 'Invalid format';
        } else {
          delete this.errors.email;
        }
      },
    },
    methods: {
      saveClient() {
        new apiClient('/api/v1/staff/clients', { client: this.newClient })
          .post()
          .then(json => {
            json.errors ? (this.errors = json.errors) : this.clients.push(json);
          });
      },
      checkDataUniq(type) {
        new apiClient('/api/v1/staff/clients/validate', {
          client: { [type]: this.newClient[type] },
        })
          .get()
          .then(json => {
            json.errors && (this.errors = json.errors);
          });
      },
    },
  };
</script>

<template lang="pug">
.row
  .offset-3.col-6
    q-form.q-gutter-xs(@submit="onSubmit" ref="myForm")
      q-input(v-model="staffData.email" label="Email" :rules="[required, email]")
      q-input(v-model="staffData.password" type="password" label="Password"
      :rules="[requiredPassword]" :error='!!errors.password' :error-message='errors.password')
      .row.justify-center
        q-btn(label="Submit" type="submit" color="primary" )
</template>

<script>
  import FormMixin from '../../mixins/Form';

  export default {
    props: {
      staff: {
        type: Object,
        default: function() {
          return {};
        },
      },
    },
    mixins: [FormMixin],
    data() {
      return {
        staffData: {},
      };
    },
    watch: {
      staff(newVal) {
        this.staffData = newVal;
      },
    },
  };
</script>

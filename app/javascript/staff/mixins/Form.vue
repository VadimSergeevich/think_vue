<script>
  import { email, required } from '../../utils/validations';

  export default {
    data() {
      return {
        errors: {},
      };
    },
    computed: {
      entity() {
        return this.$route.fullPath.split('/')[1].slice(0, -1);
      },
      method() {
        return this[this.entity].id ? 'patch' : 'post';
      },
      uri() {
        return this[this.entity].id
          ? `/api/v1/staff/${this.entity}s/${this[this.entity].id}`
          : `/api/v1/staff/${this.entity}s`;
      },

      emitAction() {
        return this[this.entity].id
          ? `${this.entity}Updated`
          : `${this.entity}Created`;
      },
    },
    methods: {
      onSubmit() {
        new this.$apiClient(this.uri, {
          [this.entity]: this[`${this.entity}Data`],
        })
          [this.method]()
          .then(json => {
            if (json.errors) {
              this.errors = json.errors;
            } else {
              this[`${this.entity}Data`] = this.defaultData || {};
              this.$emit(this.emitAction, json.data.attributes);
              this.$nextTick(() => {
                this.errors = {};
                !this[this.entity].id && this.$refs.myForm.resetValidation();
              });
            }
          });
      },
      requiredPassword() {
        this[this.entity].id ? true : this.required();
      },
      email,
      required,
    },
  };
</script>

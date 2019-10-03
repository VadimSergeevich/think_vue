<script>
  export default {
    data() {
      return {
        loading: true,
      };
    },
    computed: {
      entity() {
        return this.$route.fullPath.split('/')[1];
      },
    },
    created() {
      new this.$apiClient(`/api/v1/staff/${this.entity}`).get().then(json => {
        this[this.entity] = json.data.map(i => i.attributes);
        this.loading = false;
      });
    },
  };
</script>

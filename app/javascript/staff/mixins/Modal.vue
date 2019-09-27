<script>
  export default {
    data() {
      return {
        showDialog: true,
        prevRoute: null,
        entityData: {},
      };
    },
    computed: {
      entity() {
        return this.$route.fullPath.split('/')[1];
      },
    },
    created() {
      new this.$apiClient(
        `/api/v1/staff/${this.entity}/${this.$route.params.id}`,
      )
        .get()
        .then(json => {
          this.entityData = json.data.attributes;
        });
    },
    beforeRouteEnter(to, from, next) {
      next(vm => {
        vm.prevRoute = from;
      });
    },
    methods: {
      hide() {
        this.$refs.dialog.hide();
      },
      changeRoute() {
        this.prevRoute
          ? this.$router.go(-1)
          : this.$route.push({ name: 'Clients' });
      },
    },
  };
</script>

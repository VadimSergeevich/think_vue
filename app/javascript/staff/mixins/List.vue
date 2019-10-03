<script>
  export default {
    props: {
      loading: Boolean,
    },
    data() {
      return {
        showModal: this.$route.meta.showModal,
      };
    },
    computed: {
      entity() {
        const route = this.$route.fullPath.split('/')[1].slice(0, -1);
        return route.charAt(0).toUpperCase() + route.slice(1);
      },
    },
    watch: {
      '$route.meta'({ showModal }) {
        this.showModal = showModal;
      },
    },
    methods: {
      editDialog(entity) {
        const modalName = `${this.entity}ModalEdit`;
        this.$router.push({
          name: modalName,
          params: { id: entity.id },
          meta: { showModal: true },
        });
      },
    },
  };
</script>

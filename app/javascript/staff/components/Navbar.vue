<template lang="pug">
div
  q-header.bg-primary.text-white
    q-toolbar
      q-btn(dense flat round icon="fa fa-bars" @click="drawer = !drawer")
      q-avatar
        img(:src="require('staff_images/vue.png')")
      q-toolbar-title
        | ThinkVue
      q-toolbar-title
        | {{ user.email }}
      .q-gutter-sm
        q-btn(stretch flat type="a" href="staffs/edit" label="Change password")
        q-btn(stretch flat type="a" href="staffs/sign_out" label="Sign out")
  q-drawer(v-model="drawer" :width="200" :breakpoint="500" bordered content-class="bg-grey-3"
  show-if-above="")
    q-scroll-area.fit
      q-list(v-for="(menuItem, index) in menuList" :key="index")
        q-item(clickable :active="menuItem.label === 'Outbox'" v-ripple)
          q-item-section(avatar="")
            q-icon(:name="menuItem.icon")
          q-item-section
            | {{ menuItem.label }}
</template>
<script>
  const menuList = [
    {
      icon: 'fa fa-users',
      label: 'Clients',
    },
    {
      icon: 'fa fa-briefcase',
      label: 'Organizations',
    },
  ];

  export default {
    created() {
      this.$q.loading.show();
      new this.$apiClient('/api/v1/staff/me').get().then(json => {
        this.user = json.data;
        this.$q.loading.hide();
      });
    },
    data() {
      return {
        menuList,
        user: {},
        drawer: false,
      };
    },
  };
</script>

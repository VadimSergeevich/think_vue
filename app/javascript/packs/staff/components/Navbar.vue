<template lang="pug">
nav.navbar(role="navigation" aria-label="main navigation")
  .navbar-brand
    a.navbar-item(href="/")
      img(:src="vueImage" width="40" height="40")
    a.navbar-burger.burger(role="button" aria-label="menu" aria-expanded="false" data-target="navbarBasic" onclick="document.querySelector('.navbar-menu').classList.toggle('is-active');")
      span(aria-hidden="true")
      span(aria-hidden="true")
      span(aria-hidden="true")
  #navbarBasic.navbar-menu
    .navbar-start
      a.navbar-item
        | Home

    .navbar-end
      .navbar-item {{ user.email }}
      .navbar-item
        .buttons
          a.button.is-primary(href="staffs/edit")
            | Change password
          a.button.is-light(href="staffs/sign_out")
            | Sign out
</template>

<script>
  import vueImage from 'images/vue.png';
  import apiClient from '../../utils/apiClient';

  export default {
    created() {
      new apiClient('/api/v1/staff/me').get().then(json => {
        this.user = json.data;
      });
    },
    data() {
      return {
        vueImage,
        user: {},
      };
    },
  };
</script>

<style lang="sass" scoped></style>

import Vue from 'vue';
import app from './client/app.vue';
import 'bulma/bulma.sass';

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(app),
  }).$mount();
  document.body.appendChild(app.$el);
});

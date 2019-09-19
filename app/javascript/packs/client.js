import Vue from 'vue';
import app from '../client_app.vue';

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(app),
  }).$mount();
  document.body.appendChild(app.$el);
});

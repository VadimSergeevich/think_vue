import 'bulma/bulma.sass';
import '@fortawesome/fontawesome-free/js/all';
import Vue from 'vue/dist/vue.esm';
import app from './staff/app';

document.addEventListener('DOMContentLoaded', () => {
  new Vue({ el: '#staffApp', components: { app } });
});

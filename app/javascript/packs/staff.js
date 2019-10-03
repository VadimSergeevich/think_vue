import '@fortawesome/fontawesome-free/js/all';
import Vue from 'vue/dist/vue.runtime.esm';
import app from '../staff_app';
import iconSet from 'quasar/icon-set/fontawesome-v5.js';
import '@quasar/extras/fontawesome-v5/fontawesome-v5.css';
import '../staff/assets/styles/quasar.styl';
import 'quasar/dist/quasar.ie.polyfills';
import apiClient from '../utils/apiClient';
import router from '../staff/router/index';

Vue.prototype.$apiClient = apiClient;
console.log(router);
import {
  Quasar,
  QLayout,
  QHeader,
  QDrawer,
  QPageContainer,
  QPage,
  QToolbar,
  QToolbarTitle,
  QScrollArea,
  QBtn,
  QList,
  QItem,
  QItemSection,
  QIcon,
  QSpinnerGears,
  QForm,
  QInput,
  QSelect,
  QTable,
  QTh,
  QTr,
  QTd,
  QAvatar,
  QDialog,
  QCard,
  QCardSection,
  QCardActions,
  QChip,
  Loading,
  Ripple,
  ClosePopup,
  Dialog,
} from 'quasar';

Vue.use(Quasar, {
  config: {},
  components: {
    QLayout,
    QHeader,
    QDrawer,
    QPageContainer,
    QPage,
    QToolbar,
    QToolbarTitle,
    QScrollArea,
    QBtn,
    QList,
    QItem,
    QItemSection,
    QSpinnerGears,
    QForm,
    QInput,
    QSelect,
    QIcon,
    QTable,
    QTh,
    QTr,
    QTd,
    QAvatar,
    QDialog,
    QCard,
    QCardSection,
    QCardActions,
    QChip,
  },
  directives: { Ripple, ClosePopup },
  iconSet: iconSet,
  plugins: { Loading, Dialog },
});

document.addEventListener('DOMContentLoaded', () => {
  new Vue({ el: '#staffApp', router, render: h => h(app) });
});

import Vue from 'vue/dist/vue.runtime.esm';
import VueRouter from 'vue-router';
import DashboardClient from '../components/clients/Dashboard';
import DashboardOrganization from '../components/organizations/Dashboard';
import DashboardEquipment from '../components/equipments/Dashboard';
import DashboardStaff from '../components/staffs/Dashboard';
import ClientModalEdit from '../components/clients/Modal';
import OrganizationModalEdit from '../components/organizations/Modal';
import StaffModalEdit from '../components/staffs/Modal';
import EquipmentModalEdit from '../components/equipments/Modal';

Vue.use(VueRouter);
export default new VueRouter({
  mode: 'history',
  hashbang: false,
  base: '/staff/',
  routes: [
    {
      path: '/clients',
      component: DashboardClient,
      name: 'Clients',
      children: [
        {
          path: ':id/edit',
          components: { ClientModalEdit },
          name: 'ClientModalEdit',
          meta: { showModal: true },
        },
      ],
    },
    {
      path: '/equipments',
      component: DashboardEquipment,
      name: 'Equipments',
      children: [
        {
          path: ':id/edit',
          components: { EquipmentModalEdit },
          name: 'EquipmentModalEdit',
          meta: { showModal: true },
        },
      ],
    },
    {
      path: '/organizations',
      component: DashboardOrganization,
      name: 'Organizations',
      children: [
        {
          path: ':id/edit',
          components: { OrganizationModalEdit },
          name: 'OrganizationModalEdit',
          meta: { showModal: true },
        },
      ],
    },
    {
      path: '/staffs',
      component: DashboardStaff,
      name: 'Staff',
      children: [
        {
          path: ':id/edit',
          components: { StaffModalEdit },
          name: 'StaffModalEdit',
          meta: { showModal: true },
        },
      ],
    },
  ],
});

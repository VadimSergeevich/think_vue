const { environment } = require('@rails/webpacker');
const { VueLoaderPlugin } = require('vue-loader');
const vue = require('./loaders/vue');
const pug = require('./loaders/pug');
const sass = require('./loaders/sass');
const babelLoaderQuasar = require('./loaders/babel-loader-quasar');
const stylus = require('./loaders/stylus');

environment.loaders.append('stylus', stylus);
environment.loaders.append('js', babelLoaderQuasar);
environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin());
environment.loaders.prepend('pug', pug);
environment.loaders.prepend('sass', sass);
environment.loaders.prepend('vue', vue);
module.exports = environment;

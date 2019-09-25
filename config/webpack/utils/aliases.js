const path = require('path');

module.exports = {
  resolve: {
    alias: {
      staff_images: path.resolve(
        __dirname,
        '../../../app/javascript/staff/assets/images',
      ),
    },
  },
};

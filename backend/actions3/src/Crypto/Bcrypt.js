const bcrypt = require("bcrypt");

exports.hash_ = function (password) {
  return bcrypt.hashSync(password, 10);
};

const bcrypt = require("bcrypt");

exports.hash_ = function (password) {
  return bcrypt.hashSync(password, 10);
};

exports.compare_ = function (password, hash) {
  return bcrypt.compareSync(password, hash);
};

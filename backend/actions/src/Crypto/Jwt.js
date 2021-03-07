const jwt = require("jsonwebtoken");

const secret = process.env.HASURA_GRAPHQL_JWT_SECRET;

exports.sign_ = function (data) {
  return jwt.sign(data, secret);
};

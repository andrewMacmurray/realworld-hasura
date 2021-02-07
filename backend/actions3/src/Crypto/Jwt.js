const jwt = require("jsonwebtoken");

const secret = process.env.HASURA_GRAPHQL_JWT_SECRET;

exports.sign_ = function (data) {
  return jwt.sign(data, secret);
};

exports.isValid = function (token) {
  try {
    jwt.verify(token, secret);
    return true;
  } catch (error) {
    return false;
  }
};

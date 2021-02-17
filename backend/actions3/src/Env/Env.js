exports.adminSecret = getEnv("HASURA_GRAPHQL_ADMIN_SECRET");
exports.graphqlUrl = getEnv("HASURA_GRAPHQL_URL");

function getEnv(env_var) {
  const val = process.env[env_var];
  if (val) {
    return val;
  } else {
    throw new Error(`missing ${env_var}`);
  }
}

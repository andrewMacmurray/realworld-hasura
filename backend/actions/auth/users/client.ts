const { HASURA_ADMIN_SECRET, HASURA_GRAPHQL_ENDPOINT } = process.env;

const adminSecret = { "X-hasura-admin-secret": HASURA_ADMIN_SECRET };

export function query<I, O>(query: string, variables: I): Promise<O> {
  return fetch(HASURA_GRAPHQL_ENDPOINT, {
    method: "POST",
    headers: adminSecret,
    body: JSON.stringify({ query, variables })
  })
    .then(checkOk)
    .then(res => res.json())
    .then(checkGraphqlErrors)
    .then(res => res.data);
}

function checkGraphqlErrors(res) {
  if (res.errors) {
    const err = res.errors.map(x => x.message).join("; ");
    throw new Error(err);
  } else {
    return res;
  }
}

function checkOk(res) {
  if (res.ok) {
    return res;
  } else {
    throw new Error(res.statusText);
  }
}

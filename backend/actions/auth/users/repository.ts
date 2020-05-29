import * as client from "./client";

interface Create {
  passwordHash: string;
  email: string;
  username: string;
}

interface Find {
  username?: string;
  email?: string;
}

interface FindResponse {
  id: string;
  username: string;
  email: string;
  passwordHash: string;
}

interface CreateResponse {
  id: string;
  email: string;
  username: string;
}

export async function find(variables: Find): Promise<FindResponse> {
  return client
    .query(
      `query($email: String, $username: String) {
          users(where: {_or: {email: {_eq: $email}, username: {_eq: $username}}}) {
            password_hash,
            username,
            email,
            id
          }
        }
    `,
      variables
    )
    .then(toUserDetails);
}

function toUserDetails({ users }): FindResponse {
  if (users.length === 1) {
    const { id, username, email, password_hash } = users[0];
    return {
      id,
      username,
      email,
      passwordHash: password_hash,
    };
  } else {
    throw new Error("Invalid username / password combination");
  }
}

export async function create(variables: Create): Promise<CreateResponse> {
  return client
    .query(
      `mutation($email: String!, $username: String!, $passwordHash: String!) {
          insert_users(objects: {email: $email, password_hash: $passwordHash, username: $username}) {
            returning {
              id
            }
          }
        }
    `,
      variables
    )
    .then((res) => toCreateResponse(variables, res))
    .catch((_) => {
      throw new Error("Error creating user");
    });
}

function toCreateResponse(variables, res): CreateResponse {
  return {
    id: res.insert_users.returning[0],
    email: variables.email,
    username: variables.username,
  };
}

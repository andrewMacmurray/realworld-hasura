import * as Client from "../../client";

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
  id: number;
  username: string;
  email: string;
  passwordHash: string;
  bio: string | null;
  profile_image: string | null;
}

interface CreateResponse {
  id: number;
  email: string;
  username: string;
  bio: string | null;
  profile_image: string | null;
}

export async function find(variables: Find): Promise<FindResponse> {
  return Client.execute(
    `query($email: String, $username: String) {
          users(where: {_or: {email: {_eq: $email}, username: {_eq: $username}}}) {
            password_hash,
            username,
            email,
            bio,
            profile_image,
            id
          }
        }
    `,
    variables
  ).then(toUserDetails);
}

function toUserDetails({ users }): FindResponse {
  if (users.length === 1) {
    const { id, username, email, password_hash, bio, profile_image } = users[0];
    return {
      id,
      username,
      email,
      passwordHash: password_hash,
      bio: bio,
      profile_image: profile_image,
    };
  } else {
    throw new Error("Invalid username / password combination");
  }
}

export function create(variables: Create): Promise<CreateResponse> {
  console.log(variables);
  return Client.execute(
    `mutation MyMutation($email: String!, $passwordHash: String!, $username: String!) {
      create_user(object: {email: $email, username: $username, password_hash: $passwordHash}) {
        id
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
    id: res.create_user.id,
    email: variables.email,
    username: variables.username,
    bio: null,
    profile_image: null,
  };
}

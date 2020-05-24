import * as jwt from "jsonwebtoken";

const { JWT_SECRET } = process.env;

export interface UserDetails {
  id: string;
  email: string;
  username: string;
}

export function generate(user: UserDetails): string {
  return jwt.sign(
    {
      username: user.username,
      email: user.email,
      "https://hasura.io/jwt/claims": {
        "x-hasura-allowed-roles": ["user"],
        "x-hasura-default-role": "user",
        "x-hasura-user-id": `${user.id}`
      }
    },
    JWT_SECRET
  );
}

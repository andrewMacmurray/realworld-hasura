import * as Password from "./password";
import * as Users from "./repository";
import * as TokenResponse from "./token";

interface TokenResponse {
  token: string;
  username: string;
  email: string;
}

export interface SignupDetails {
  email: string;
  username: string;
  password: string;
}

export interface LoginDetails {
  username: string;
  password: string;
}

export async function signup({
  password,
  email,
  username,
}: SignupDetails): Promise<TokenResponse> {
  return Password.hash(password)
    .then((passwordHash) => Users.create({ passwordHash, email, username }))
    .then(generateToken);
}

export async function login({
  username,
  password,
}: LoginDetails): Promise<TokenResponse> {
  return Users.find({ username })
    .then((user) => Password.check(password, user))
    .then(generateToken);
}

function generateToken(details: TokenResponse.UserDetails): TokenResponse {
  return {
    token: TokenResponse.generate(details),
    username: details.username,
    email: details.email,
  };
}

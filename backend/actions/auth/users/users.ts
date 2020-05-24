import * as Password from "./password";
import * as Users from "./repository";
import * as Token from "./token";

interface Token {
  token: string;
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
  username
}: SignupDetails): Promise<Token> {
  return Password.hash(password)
    .then(passwordHash => Users.create({ passwordHash, email, username }))
    .then(generateToken);
}

export async function login({
  username,
  password
}: LoginDetails): Promise<Token> {
  return Users.find({ username })
    .then(user => Password.check(password, user))
    .then(generateToken);
}

function generateToken(details: Token.UserDetails): Token {
  return { token: Token.generate(details) };
}

import * as Password from "./password";
import * as Users from "./repository";
import * as TokenResponse from "./token";

interface TokenResponse {
  token: string;
  user_id: number;
  username: string;
  email: string;
  bio: string | null;
  profile_image: string | null;
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
    user_id: details.id,
    username: details.username,
    email: details.email,
    bio: details.bio,
    profile_image: details.profile_image,
  };
}

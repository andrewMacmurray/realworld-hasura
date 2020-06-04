import * as bcrypt from "bcrypt";

interface User {
  id: string;
  email: string;
  username: string;
  passwordHash: string;
}

export async function hash(password: string): Promise<string> {
  return bcrypt.hash(password, 10);
}

export async function check(password: string, user: User): Promise<User> {
  const isMatch = await bcrypt.compare(password, user.passwordHash);
  if (isMatch) {
    return user;
  } else {
    throw new Error("Invalid username / password combination");
  }
}

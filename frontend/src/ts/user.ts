import * as Utils from "./utils";

interface User {
  username: string;
  email: string;
  token: string;
  bio: string | null;
  profileImage: string | null;
  following: number[];
}

export function load(): User | null {
  return Utils.safeParse(localStorage.getItem("user"));
}

export function save(user: User) {
  localStorage.setItem("user", JSON.stringify(user));
}

export function clear() {
  localStorage.removeItem("user");
}

import * as Users from "./users/users";
import * as Response from "../response";

export const handler = async (event) => {
  const payload = JSON.parse(event.body);
  const user: Users.LoginDetails = payload.input;

  return Users.login(user).then(Response.ok).catch(Response.error);
};

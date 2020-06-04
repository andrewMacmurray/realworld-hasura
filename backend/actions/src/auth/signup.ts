import * as Users from "./users/users";
import * as Response from "../response";

export const handler = async (event) => {
  const payload = JSON.parse(event.body);
  const user: Users.SignupDetails = payload.input;

  return Users.signup(user).then(Response.ok).catch(Response.error);
};

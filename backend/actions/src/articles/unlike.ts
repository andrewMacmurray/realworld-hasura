import * as Articles from "./articles";
import * as Response from "../response";
import * as Request from "../request";

export const handler = async (event) => {
  const payload = JSON.parse(event.body);
  const input: Articles.UnlikeArgs = payload.input;
  const userId = Request.userId(payload);

  return Articles.unlike(input, userId).then(Response.ok).catch(Response.error);
};

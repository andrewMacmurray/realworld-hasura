export function userId(payload): number {
  return payload.session_variables["x-hasura-user-id"];
}

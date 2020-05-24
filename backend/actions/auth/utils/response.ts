interface Response {
  statusCode: number;
  body: string;
}

export function ok(body: any): Response {
  return {
    statusCode: 200,
    body: JSON.stringify(body)
  };
}

export function error(err: Error): Response {
  return {
    statusCode: 412,
    body: JSON.stringify({ error: err.message })
  };
}

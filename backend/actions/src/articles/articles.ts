import * as Client from "../client";

export interface UnlikeResponse {
  article_id: number;
}

export interface UnlikeArgs {
  article_id: number;
}

export function unlike(
  args: UnlikeArgs,
  userId: number
): Promise<UnlikeResponse> {
  return Client.execute(
    `mutation MyMutation($userId: Int!, $articleId: Int!) {
      delete_likes(where: {user_id: {_eq: $userId}, article_id: {_eq: $articleId}}) {
        returning {
          article_id
        }
      }
    }`,
    { articleId: args.article_id, userId: userId }
  ).then((_) => ({ article_id: args.article_id }));
}

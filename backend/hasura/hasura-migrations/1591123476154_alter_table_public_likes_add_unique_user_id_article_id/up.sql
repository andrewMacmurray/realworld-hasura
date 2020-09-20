alter table "public"."likes" add constraint "likes_user_id_article_id_key" unique ("user_id", "article_id");

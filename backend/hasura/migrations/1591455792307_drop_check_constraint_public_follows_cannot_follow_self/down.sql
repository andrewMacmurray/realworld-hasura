alter table "public"."follows" add constraint "cannot_follow_self" check (CHECK (user_id <> following_id));

alter table "public"."follows" add constraint "cannot_follow_self" check (user_id != following_id);

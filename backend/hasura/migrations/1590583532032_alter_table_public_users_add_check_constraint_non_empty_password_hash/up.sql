alter table "public"."users" add constraint "non_empty_password_hash" check ((password_hash = ''::text) IS NOT TRUE);

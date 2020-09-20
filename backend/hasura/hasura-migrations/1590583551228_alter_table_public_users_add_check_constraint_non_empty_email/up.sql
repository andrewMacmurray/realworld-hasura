alter table "public"."users" add constraint "non_empty_email" check ((email = ''::text) IS NOT TRUE);

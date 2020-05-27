alter table "public"."users" add constraint "non_empty_username" check ((username = '') IS NOT TRUE);

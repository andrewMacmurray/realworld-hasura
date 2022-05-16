CREATE OR REPLACE VIEW "public"."profile" AS 
 SELECT users.id AS user_id,
    users.email,
    users.username,
    users.bio,
    users.profile_image
   FROM users;

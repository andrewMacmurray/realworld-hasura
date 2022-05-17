CREATE TABLE "public"."follows"("id" serial NOT NULL, "user_id" integer NOT NULL, "following" integer NOT NULL, PRIMARY KEY ("id") , FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON UPDATE cascade ON DELETE cascade, FOREIGN KEY ("following") REFERENCES "public"."users"("id") ON UPDATE cascade ON DELETE cascade, UNIQUE ("user_id", "following"));
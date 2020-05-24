CREATE TABLE "public"."users"("id" serial NOT NULL, "username" text NOT NULL, "email" text NOT NULL, "password_hash" text NOT NULL, PRIMARY KEY ("id") , UNIQUE ("id"), UNIQUE ("username"));

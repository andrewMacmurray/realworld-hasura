CREATE TABLE "public"."tags"("id" serial NOT NULL, "article_id" integer NOT NULL, "tag" text NOT NULL, PRIMARY KEY ("id") , FOREIGN KEY ("article_id") REFERENCES "public"."articles"("id") ON UPDATE cascade ON DELETE cascade, UNIQUE ("article_id", "tag"));
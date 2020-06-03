CREATE FUNCTION likes_for_article(articles_row articles)
RETURNS INT AS $$
  SELECT COUNT(*)::INT FROM likes WHERE likes.article_id = articles_row.id
$$ LANGUAGE sql STABLE;

CREATE FUNCTION tag_count(tag_row tags)
RETURNS INT AS $$
  SELECT COUNT(*)::INT FROM tags WHERE tags.tag = tag_row.tag
$$ LANGUAGE sql STABLE;

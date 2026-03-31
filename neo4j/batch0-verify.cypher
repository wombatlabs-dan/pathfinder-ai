MATCH (n) RETURN labels(n)[0] AS type, count(n) AS count ORDER BY count DESC;

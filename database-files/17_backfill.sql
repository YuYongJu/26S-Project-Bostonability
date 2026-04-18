USE bostonability;

UPDATE report r
JOIN accessibility_report ar ON r.report_id = ar.report_id
SET r.user_id = ar.user_id
WHERE r.user_id IS NULL;

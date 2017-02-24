DROP TABLE survey_scores;

CREATE TABLE survey_scores AS
SELECT
  provider_id,
  overall_performance,
  overall_achieve_pts
FROM survey_responses_schema
WHERE overall_achieve_pts not like "Not%"
;

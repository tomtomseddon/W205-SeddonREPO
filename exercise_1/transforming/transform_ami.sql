DROP TABLE ami_scores;
CREATE TABLE ami_scores AS
SELECT
  provider_id,
  cast(score as decimal(4,1)) ami_mort,
  compare_national,
  denominator,
  footnote
FROM readmissions_schema
WHERE measure_ID = "MORT_30_AMI"
AND score not like "Not%"
AND footnote not like "7%"
;

DROP TABLE pneum_scores;
CREATE TABLE pneum_scores AS
SELECT
  provider_id,
  cast(score as decimal(3,1)) pn_mort,
  compare_national,
  denominator,
  footnote
FROM readmissions_schema
WHERE measure_ID = "MORT_30_PN"
AND score not like "Not%"
AND footnote not like "7%";

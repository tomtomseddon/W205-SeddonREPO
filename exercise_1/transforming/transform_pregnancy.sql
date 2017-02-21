DROP TABLE pregnancy_scores;
CREATE TABLE pregnancy_scores AS
SELECT
  provider_id,
  cast(score as decimal (3,0)) preg_early,
  cast(sample as decimal (5,0)) sample,
  footnote
FROM effective_care_schema
WHERE measure_ID = "PC_01"
AND score not like "Not%"
AND footnote not like "%3%"
;

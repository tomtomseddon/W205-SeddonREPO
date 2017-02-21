DROP TABLE ER_scores;
CREATE TABLE ER_scores AS
SELECT
  provider_id,
  cast(score as decimal (3,0)) er_wait,
  cast(sample as decimal (5,0)) sample,
  footnote
FROM effective_care_schema
WHERE measure_ID = "OP_20"
AND score not like "Not%"
AND footnote not like "3%"
;

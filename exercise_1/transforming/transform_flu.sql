DROP TABLE flu_scores;
CREATE TABLE flu_scores AS
SELECT
  provider_id,
  cast(score as decimal(3,0)) imm_rate,
  cast(sample as decimal(5,0)) sample,
  footnote
FROM effective_care_schema
WHERE measure_ID = "IMM_2"
AND score not like "Not%"
AND footnote not like "%3%"
;

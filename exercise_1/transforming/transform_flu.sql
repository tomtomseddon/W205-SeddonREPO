DROP TABLE flu_scores;
CREATE TABLE flu_scores
  AS SELECT provider_id, score, sample, footnote
  FROM effective_care_schema
  WHERE measure_ID = "IMM_2";

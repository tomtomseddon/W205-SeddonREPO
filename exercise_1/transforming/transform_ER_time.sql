DROP TABLE ER_scores;
CREATE TABLE ER_scores
  AS SELECT provider_id, score, sample, footnote
  FROM effective_care_schema
  WHERE measure_ID = "OP_20";

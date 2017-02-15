DROP TABLE pregnancy_scores;
CREATE TABLE pregnancy_scores
  AS SELECT provider_id, score, sample, footnote
  FROM effective_care_schema
  WHERE measure_ID = "PC_01";

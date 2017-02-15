DROP TABLE hf_scores;
CREATE TABLE hf_scores
  AS SELECT provider_id, score, compare_national, denominator, footnote
  FROM readmissions_schema
  WHERE measure_ID = "MORT_30_HF";

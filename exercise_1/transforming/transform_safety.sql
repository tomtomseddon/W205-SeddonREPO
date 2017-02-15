DROP TABLE safety_scores;
CREATE TABLE safety_scores
  AS SELECT provider_id, PSI_90_performance, PSI_90_achieve_pts
  FROM safety_schema;

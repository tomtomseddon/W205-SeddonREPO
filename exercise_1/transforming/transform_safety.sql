DROP TABLE safety_scores;
CREATE TABLE safety_scores AS
SELECT
  provider_id,
  cast(PSI_90_performance as decimal(4,3)) PSI_90,
  PSI_90_achieve_pts
  FROM safety_schema;

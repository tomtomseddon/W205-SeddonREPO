-- Script to identify how patient survey responses are linked to other quality measures
-- It looks at it two ways.

-- Script developed to run in SparkSQL.

-- Note: Assumes best_hospitals.sql script has already been run.


-- Create combination of patient survey score and overall HVBP hospital rating

DROP TABLE simple_rating;
CREATE TABLE simple_rating AS
SELECT
  hospital_selected.overall_rating,
  survey_scores.overall_performance
FROM
  hospital_selected,
  survey_scores
WHERE
  hospital_selected.provider_id=survey_scores.provider_id
AND overall_rating not like "Not%"
AND overall_performance not like "Not%" 
;

-- Calculate average survey rating by HVBP rating group
DROP TABLE survey_hvbp;
CREATE TABLE survey_hvbp AS
SELECT
  overall_rating,
  cast(AVG(overall_performance) AS decimal(4,2)) avg_perf,
  count(overall_rating)
FROM simple_rating
GROUP BY overall_rating
ORDER BY overall_rating DESC
;


-- Create combination of patient survey rating and my normalized, weighted quality
-- score developed to find the best hospitals

DROP TABLE proc_rating;
CREATE TABLE proc_rating AS
SELECT
  totalled_hosps.z_total,
  survey_scores.overall_achieve_pts
FROM
  totalled_hosps,
  survey_scores
WHERE
  totalled_hosps.provider_id=survey_scores.provider_id
AND overall_achieve_pts not like "Not%"
;

-- Calculate average quality score by patient survey score group
DROP TABLE survey_zrating;
CREATE TABLE survey_zrating AS
SELECT
  overall_achieve_pts,
  cast(AVG(z_total) as decimal(3,2)) avg_z,
  COUNT(z_total)
FROM proc_rating
WHERE overall_achieve_pts not like "10%"
GROUP BY overall_achieve_pts
ORDER BY overall_achieve_pts DESC
;





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

SELECT
  overall_rating,
  cast(AVG(overall_performance) AS decimal(4,2)) avg_perf,
  count(overall_rating)
FROM simple_rating
GROUP BY overall_rating
ORDER BY overall_rating DESC
;

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

SELECT
  overall_achieve_pts,
  cast(AVG(z_total) as decimal(3,2)) avg_z,
  COUNT(z_total)
FROM proc_rating
WHERE overall_achieve_pts not like "10%"
GROUP BY overall_achieve_pts
ORDER BY overall_achieve_pts DESC
;





DROP TABLE totalled_states;

CREATE TABLE totalled_states AS
SELECT
  hospital_selected.state,
  cast(avg(totalled_hosps.z_total) as decimal(3,2)) avg_rating,
  count(totalled_hosps.provider_id) as hosp_count
FROM
  hospital_selected,
  totalled_hosps
WHERE
  hospital_selected.provider_id=totalled_hosps.provider_id
GROUP BY
  hospital_selected.state
;

SELECT *
FROM totalled_states
WHERE hosp_count>=20
ORDER BY avg_rating DESC
LIMIT 10
;

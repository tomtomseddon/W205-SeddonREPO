DROP TABLE totalled_states;

CREATE TABLE totalled_states AS
SELECT
  hospital_selected.state
  count(scored_hosps.provider_id) as hosp_count,
  avg(scored_hosps.z_total) as avg_rating
FROM
  hospital_selected
  scored_hosps
WHERE
  hospital_selected.provider_id=scored_hosps.provider_id
GROUP BY
  hospital_selected.state

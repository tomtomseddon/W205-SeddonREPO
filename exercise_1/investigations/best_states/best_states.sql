-- This script creates a list of 10 states that consistently model high quality care

-- This was developed to run in SparkSQl.

-- Note:  This script assumes that the best_hospitals.sql query has already been run.


-- Create totalled scores by state

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

-- Identify ten best states, given >=20 hospitals in the state with scores

DROP TABLE topten_states;
CREATE TABLE topten_states AS
SELECT *
FROM totalled_states
WHERE hosp_count>=20
ORDER BY avg_rating DESC
LIMIT 10
;

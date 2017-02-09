-- Adding the DDL statements for each of the base files in Exercise 1

-- hospitals file
DROP TABLE hospitals_schema;
CREATE EXTERNAL TABLE hospitals_schema
(provider_id string,
hospital_name string,
address string,
city string,
state string,
zip string,
county string,
phone string,
type string,
ownership string,
em_services string,
meets_EHR_crit string,
overall_rating string,
overall_rating_footnote string,
mortality string,
mortality_footnote string,
safety string,
safety_footnote string,
readmission string,
readmission_footnote string,
patient_experience string,
patient_experience_footnote string,
effectiveness string,
effectiveness_footnote string,
timeliness string,
timeliness_footnote string,
imaging string,
imaging_footnote string)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/hospitals';

-- effective_care file
DROP TABLE effective_care_schema;
CREATE EXTERNAL TABLE effective_care_schema
(provider_id string,
hospital_name string,
address string,
city string,
state string,
zip string,
county string,
phone string,
condition string,
measure_id string,
measure_name string,
score string,
sample string,
footnote string,
measure_start_date string,
measure_end_date string)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/effective_care';

-- readmissions file
DROP TABLE readmissions_schema;
CREATE EXTERNAL TABLE readmissions_schema
(provider_id string,
hospital_name string,
address string,
city string,
state string,
zip string,
county string,
phone string,
measure_name string,
measure_id string,
compare_national string,
denominator string,
score string,
lower_estimate string,
higher_estimate string,
footnote string,
measure_start_date string,
measure_end_date string)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/readmissions';

-- survey_responses file
DROP TABLE survey_responses_schema;
CREATE EXTERNAL TABLE survey_responses_schema
(provider_id string,
hospital_name string,
address string,
city string,
state string,
zip string,
county string,
comm_nurse_floor string,
comm_nurse_threshold string,
comm_nurse_benchmark string,
comm_nurse_baseline string,
comm_nurse_performance string,
comm_nurse_achieve_pts string,
comm_nurse_improve_pts string,
comm_nurse_dimension string,
comm_doctors_floor string,
comm_doctors_threshold string,
comm_doctors_benchmark string,
comm_doctors_baseline string,
comm_doctors_performance string,
comm_doctors_achieve_pts string,
comm_doctors_improve_pts string,
comm_doctors_dimension string,
resp_staff_floor string,
resp_staff_threshold string,
resp_staff_benchmark string,
resp_staff_baseline string,
resp_staff_performance string,
resp_staff_achieve_pts string,
resp_staff_improve_pts string,
resp_staff_dimension string,
pain_mgmt_floor string,
pain_mgmt_threshold string,
pain_mgmt_benchmark string,
pain_mgmt_baseline string,
pain_mgmt_performance string,
pain_mgmt_achieve_pts string,
pain_mgmt_improve_pts string,
pain_mgmt_dimension string,
comm_meds_floor string,
comm_meds_threshold string,
comm_meds_benchmark string,
comm_meds_baseline string,
comm_meds_performance string,
comm_meds_achieve_pts string,
comm_meds_improve_pts string,
comm_meds_dimension string,
clean_floor string,
clean_threshold string,
clean_benchmark string,
clean_baseline string,
clean_performance string,
clean_achieve_pts string,
clean_improve_pts string,
clean_dimension string,
discharge_floor string,
discharge_threshold string,
discharge_benchmark string,
discharge_baseline string,
discharge_performance string,
discharge_achieve_pts string,
discharge_improve_pts string,
discharge_dimension string,
overall_floor string,
overall_threshold string,
overall_benchmark string,
overall_baseline string,
overall_performance string,
overall_achieve_pts string,
overall_improve_pts string,
overall_dimension string,
base_score string,
consistency string)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/survey_responses';

-- Measures file
DROP TABLE measures_schema;
CREATE EXTERNAL TABLE measures_schema
(measure_name string,
measure_id string,
measure_start_qtr string,
measure_start_date string,
measure_end_qtr string,
measure_end_date string)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/measures';




-- Adding the DDL statements for each of the base files in Exercise 1

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

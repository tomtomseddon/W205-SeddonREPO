-- Script to transform all the basic tables into the tables
-- in my ER diagram.
-- I filter out records without valid scores in the transformations
-- of all the seven 'procedures' and the survey.


-- Hospitals

DROP TABLE hospital_selected;
CREATE TABLE hospital_selected AS
SELECT
  provider_id,
  hospital_name,
  state,
  overall_rating
FROM hospitals_schema
;

-- AMI (Heart Attack)
 
DROP TABLE ami_scores;
CREATE TABLE ami_scores AS
SELECT
  provider_id,
  cast(score as decimal(4,1)) ami_mort,
  compare_national,
  denominator,
  footnote
FROM readmissions_schema
WHERE measure_ID = "MORT_30_AMI"
AND score not like "Not%"
AND footnote not like "7%"
;

-- HF (Heart Failure)

DROP TABLE hf_scores;
CREATE TABLE hf_scores AS
SELECT
  provider_id,
  cast(score as decimal(3,1)) hf_mort,
  compare_national,
  denominator,
  footnote
FROM readmissions_schema
WHERE measure_ID = "MORT_30_HF"
AND score not like "Not%"
AND footnote not like "7%"
;

-- Pneumonia

DROP TABLE pneum_scores;
CREATE TABLE pneum_scores AS
SELECT
  provider_id,
  cast(score as decimal(3,1)) pn_mort,
  compare_national,
  denominator,
  footnote
FROM readmissions_schema
WHERE measure_ID = "MORT_30_PN"
AND score not like "Not%"
AND footnote not like "7%"
;

-- Safety

DROP TABLE safety_scores;
CREATE TABLE safety_scores AS
SELECT
  provider_id,
  cast(PSI_90_performance as decimal(4,3)) PSI_90,
  PSI_90_achieve_pts
FROM safety_schema
WHERE PSI_90_achieve_pts not like "Not%"
;

-- Pregnancy

DROP TABLE pregnancy_scores;
CREATE TABLE pregnancy_scores AS
SELECT
  provider_id,
  cast(score as decimal (3,0)) preg_early,
  cast(sample as decimal (5,0)) sample,
  footnote
FROM effective_care_schema
WHERE measure_ID = "PC_01"
AND score not like "Not%"
AND footnote not like "%3%"
;

-- Flu

DROP TABLE flu_scores;
CREATE TABLE flu_scores AS
SELECT
  provider_id,
  cast(score as decimal(3,0)) imm_rate,
  cast(sample as decimal(5,0)) sample,
  footnote
FROM effective_care_schema
WHERE measure_ID = "IMM_2"
AND score not like "Not%"
AND footnote not like "%3%"
;

-- ER wait

DROP TABLE ER_scores;
CREATE TABLE ER_scores AS
SELECT
  provider_id,
  cast(score as decimal (3,0)) er_wait,
  cast(sample as decimal (5,0)) sample,
  footnote
FROM effective_care_schema
WHERE measure_ID = "OP_20"
AND score not like "Not%"
AND footnote not like "3%"
;

-- Patient Surveys

DROP TABLE survey_scores;

CREATE TABLE survey_scores AS
SELECT
  provider_id,
  overall_performance,
  overall_achieve_pts
FROM survey_responses_schema
WHERE overall_achieve_pts not like "Not%"
;
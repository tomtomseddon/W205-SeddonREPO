-- This script creates a table of 10 which support my answer to which are 10
-- hospitals that model consistently high quality care


-- Combine the individual procedure measures into a single table

DROP TABLE comb_hosps;
CREATE TABLE comb_hosps AS
SELECT hospital_selected.provider_id,
       hospital_selected.hospital_name,
       ami_scores.ami_mort,
       hf_scores.hf_mort,
       pneum_scores.pn_mort,
       pregnancy_scores.preg_early,
       flu_scores.imm_rate,
       er_scores.er_wait,
       safety_scores.PSI_90
FROM
  hospital_selected,
  ami_scores,
  hf_scores,
  pneum_scores,
  pregnancy_scores,
  flu_scores,
  er_scores,
  safety_scores
WHERE hospital_selected.provider_id = ami_scores.provider_id
  AND hospital_selected.provider_id = hf_scores.provider_id
  AND hospital_selected.provider_id = pneum_scores.provider_id
  AND hospital_selected.provider_id = pregnancy_scores.provider_id
  AND hospital_selected.provider_id = flu_scores.provider_id
  AND hospital_selected.provider_id = er_scores.provider_id
  AND hospital_selected.provider_id = safety_scores.provider_id 
;

-- Create a table with summary aggregated statistics for each measure

DROP TABLE summary_variables;
CREATE TABLE summary_variables AS
SELECT
  avg(ami_mort) AS avg_ami,
  stddev(ami_mort) AS sd_ami,
  avg(hf_mort) AS avg_hf,
  stddev(hf_mort) AS sd_hf,
  avg(pn_mort) AS avg_pn,
  stddev(pn_mort) AS sd_pn,
  avg(preg_early) AS avg_preg,
  stddev(preg_early) AS sd_preg,
  avg(imm_rate) AS avg_imm,
  stddev(imm_rate) AS sd_imm,
  avg(er_wait) AS avg_er,
  stddev(er_wait) AS sd_er,
  avg(psi_90) AS avg_psi,
  stddev(psi_90) AS sd_psi
FROM
  comb_hosps
; 

-- Combine the summary variables with the individual scores to prepare for
-- calculating normalized z scores for each

DROP TABLE z_calcs;
CREATE TABLE z_calcs AS
SELECT
  provider_id,
  hospital_name,
  ami_mort,
  avg_ami,
  sd_ami,
  hf_mort,
  avg_hf,
  sd_hf,
  pn_mort,
  avg_pn,
  sd_pn,
  preg_early,
  avg_preg,
  sd_preg,
  imm_rate,
  avg_imm,
  sd_imm,
  er_wait,
  avg_er,
  sd_er,
  psi_90,
  avg_psi,
  sd_psi
FROM
  comb_hosps,
  summary_variables
; 

-- Calculate a normalized score value for each measure

DROP TABLE scored_hosps;

CREATE TABLE scored_hosps AS
SELECT
  provider_id,
  hospital_name,
  ami_mort,
  (avg_ami - ami_mort)/sd_ami AS z_ami,
  hf_mort,
  (avg_hf - hf_mort)/sd_hf AS z_hf,
  pn_mort,
  (avg_pn - pn_mort)/sd_pn AS z_pn,
  preg_early,
  (avg_preg - preg_early)/sd_preg AS z_preg ,
  imm_rate,
  (imm_rate - avg_imm)/sd_imm AS z_imm,
  er_wait,
  (avg_er - er_wait)/sd_er AS z_er,
  psi_90,
  (avg_psi - psi_90)/sd_psi AS z_psi
FROM
  z_calcs
;

-- Combine the individual normalized scores to create an overall score
-- Note: weights the safety score.

DROP TABLE totalled_hosps;
CREATE TABLE totalled_hosps AS
SELECT
  provider_id,
  hospital_name,
  cast(z_ami+z_hf+z_pn+z_preg+z_imm+z_er+3*z_psi AS decimal(4,2)) z_total,
  ami_mort,
  hf_mort,
  pn_mort,
  preg_early,
  imm_rate,
  er_wait,
  psi_90
FROM
  scored_hosps
;

-- Identify the top 10 best hospitals based on the total score

DROP TABLE topten_hosps;
CREATE TABLE topten_hosps AS
SELECT * FROM scored_hosps
ORDER BY z_total DESC
LIMIT 10
;
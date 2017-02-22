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

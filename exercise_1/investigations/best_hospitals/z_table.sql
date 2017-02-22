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

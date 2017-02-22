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

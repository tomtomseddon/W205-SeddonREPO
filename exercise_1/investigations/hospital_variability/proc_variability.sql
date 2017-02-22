DROP TABLE procedure_var;

CREATE TABLE procedure_var AS
SELECT
  sd_ami/avg_ami AS ami_var,
  sd_hf/avg_hg AS hf_var,
  sd_pn/avg_pn as pn_var,
  sd_preg/avg_preg as preg_var,
  sd_imm/avg_imm as imm_var,
  sd_er/avg_er as er_var,
  sd_psi/avg_psi as psi_var
FROM
  summary_variables
;

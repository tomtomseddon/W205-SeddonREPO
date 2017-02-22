DROP TABLE procedure_var;

CREATE TABLE procedure_var AS
SELECT
  cast(sd_ami/avg_ami AS decimal(4,3)) ami_var,
  cast(sd_hf/avg_hf AS decimal(4,3)) hf_var,
  cast(sd_pn/avg_pn as decimal(4,3)) pn_var,
  cast(sd_preg/avg_preg as decimal(4,3)) preg_var,
  cast(sd_imm/avg_imm as decimal(4,3)) imm_var,
  cast(sd_er/avg_er as decimal(4,3)) er_var,
  cast(sd_psi/avg_psi as decimal(4,3)) psi_var
FROM
  summary_variables
;

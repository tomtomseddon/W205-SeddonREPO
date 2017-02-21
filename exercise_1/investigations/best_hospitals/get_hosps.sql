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


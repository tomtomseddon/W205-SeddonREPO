CREATE TABLE hospital_selected
  AS SELECT provider_id, hospital_name, state, overall_rating
  FROM hospitals_schema;

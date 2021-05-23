SELECT DISTINCT NULL AS model_alias_id,
  NULL               AS model_id,
  nfo.model_code
FROM STG_NFO.nf_purpose_detail_vehicle nfo
LEFT JOIN DM_SM.xref_sm_models_aliases ma
ON upper(ma.model_alias) = upper(nfo.model_code)
WHERE ma.model_alias    IS NULL
ORDER BY NFO.MODEL_CODE
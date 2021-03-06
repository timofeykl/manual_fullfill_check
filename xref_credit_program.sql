SELECT distinct pr.*,
 SUBSTR(cr.!!!, 0,LENGTH(cr.!!!) - 8) AS reference_name
FROM !!!! pr
RIGHT JOIN
  (SELECT *
  FROM dm_sm.credit
 WHERE GIVE_DT>=DATE'{0}-{1}-01'
  AND GIVE_DT   <DATE'{0}-{2}-01'
  AND app_number IS NOT NULL
  ) cr
ON (lower(SUBSTR(REPLACE(REGEXP_REPLACE(cr.FULL_CREDIT_PROGRAM_NM, '_| ', ''), '.', ''), 0, LENGTH(REPLACE(REGEXP_REPLACE(cr.FULL_CREDIT_PROGRAM_NM, '_| ', ''), '.', '')) - 8))) =
lower(REPLACE(REGEXP_REPLACE(pr.CREDIT_PROGRAM_NM, '_| ', ''), '.', ''))
WHERE pr.IS_BALLOON   IS NULL
OR pr.ISCRM           IS NULL
OR pr.is_rrp          IS NULL
OR pr.CREDIT_PROGRAM_CLASS_ID IS NULL

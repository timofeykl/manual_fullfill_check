SELECT prog.credit_program_alias_id,
  prog.CREDIT_PROGRAM_ID,
  prog_cr.full_credit_program_nm
FROM
  (SELECT DISTINCT full_credit_program_nm
  FROM DM_SM.CREDIT
   WHERE GIVE_DT>=DATE'{0}-{1}-01'
  AND GIVE_DT   <DATE'{0}-{2}-01'
  AND app_number IS NOT NULL
  ) prog_cr
LEFT JOIN
  (SELECT * FROM DM_SM.XREF_CREDIT_PROGRAM_alias
  ) prog
ON prog_cr.full_credit_program_nm   = prog.credit_program_alias_nm
WHERE prog.credit_program_alias_nm IS NULL


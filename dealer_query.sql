SELECT!!!
FROM
  (SELECT DISTINCT(bir)
  FROM DM_SM.CREDIT
  WHERE GIVE_DT>=DATE'{0}-{1}-01'
  AND GIVE_DT   <DATE'{0}-{2}-01'
  and app_number is not null
  ) bir_cr
LEFT JOIN
  (SELECT *
  FROM dm_sm.xref_dealer
  ) dealer
ON bir_cr.bir              =dealer.dealer_bir_cd
WHERE (dealer.BRAND        IS NULL
OR dealer.INN             IS NULL
OR dealer.DEALER_NM_RUS   IS NULL
OR dealer.DEALER_NM_ENG   IS NULL
OR dealer.DEALER_LEGAL_NM IS NULL)
and bir_cr.bir is not null

SELECT bir_cr.bir
, dealer.DEALER_GROUP_CD
, dealer.BRAND
, dealer.INN
, dealer.DEALER_NM_RUS
, dealer.DEALER_NM_ENG
, dealer.OPEN_DT
, dealer.CLOSE_DT
, dealer.STATUS
, dealer.ASM
, dealer.ASM_OLD
, dealer.CITY_NM
, dealer.ZONE
, dealer.ZONE_FLASH
, dealer.INSURANCE_PROG_START_DT
, dealer.VO_START_DT
, dealer.USED_PROG_START_DT
, dealer.ADDRESS
, dealer.REGION
, dealer.DEALER_LEGAL_NM
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
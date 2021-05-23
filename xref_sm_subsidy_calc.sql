select *
from DM_SM.XREF_SM_SUBSIDY_CALC
   WHERE EXTRACT(YEAR FROM TO_DATE(valid_to_dt, 'DD-MON-RR'))>={0}
   AND EXTRACT(month FROM TO_DATE(valid_to_dt, 'DD-MON-RR'))>={1}
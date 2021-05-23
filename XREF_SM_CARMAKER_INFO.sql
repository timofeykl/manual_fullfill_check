select *
from DM_SM.XREf_sm_carmaker_info
   WHERE EXTRACT(YEAR FROM TO_DATE(DATE_to, 'DD-MON-RR'))>={0}
   AND EXTRACT(month FROM TO_DATE(DATE_to, 'DD-MON-RR'))>{1}
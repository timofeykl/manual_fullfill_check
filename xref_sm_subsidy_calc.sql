select *
from !!!!
   WHERE EXTRACT(YEAR FROM TO_DATE(valid_to_dt, 'DD-MON-RR'))>={0}
   AND EXTRACT(month FROM TO_DATE(valid_to_dt, 'DD-MON-RR'))>={1}

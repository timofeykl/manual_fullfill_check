select *
from !!!
   WHERE EXTRACT(YEAR FROM TO_DATE(DATE_to, 'DD-MON-RR'))>={0}
   AND EXTRACT(month FROM TO_DATE(DATE_to, 'DD-MON-RR'))>={1}

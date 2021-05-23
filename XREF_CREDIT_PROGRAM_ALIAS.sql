select
max(CREDIT_PROGRAM_ID),
(lower(SUBSTR(replace(REGEXP_REPLACE(CREDIT_PROGRAM, '_| ', ''), '.', ''), 0,
length(replace(REGEXP_REPLACE(CREDIT_PROGRAM, '_| ', ''), '.', '')) - 8)))

as  CREDIT_PROGRAM
from smth
 group by
 (lower(SUBSTR(replace(REGEXP_REPLACE(CREDIT_PROGRAM, '_| ', ''), '.', ''), 0,
 length(replace(REGEXP_REPLACE(CREDIT_PROGRAM, '_| ', ''), '.', '')) - 8)))

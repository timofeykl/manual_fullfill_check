select
max(CREDIT_PROGRAM_ID) credit_id,
lower(replace(REGEXP_REPLACE(CREDIT_PROGRAM_NM, '_| ', ''), '.', ''))

as  CREDIT_PROGRAM_NM_SPACEOUT
from dm_sm.xref_credit_program
 group by
lower(replace(REGEXP_REPLACE(CREDIT_PROGRAM_NM, '_| ', ''), '.', ''))
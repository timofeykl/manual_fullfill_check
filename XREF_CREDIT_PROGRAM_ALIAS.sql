select
max(CREDIT_PROGRAM_ID),
(lower(SUBSTR(replace(REGEXP_REPLACE(CREDIT_PROGRAM_ALIAS_NM, '_| ', ''), '.', ''), 0,
length(replace(REGEXP_REPLACE(CREDIT_PROGRAM_ALIAS_NM, '_| ', ''), '.', '')) - 8)))

as  CREDIT_PROGRAM_ALIAS_NM_SPACEOUT
from dm_sm.xref_credit_program_alias
 group by
 (lower(SUBSTR(replace(REGEXP_REPLACE(CREDIT_PROGRAM_ALIAS_NM, '_| ', ''), '.', ''), 0,
 length(replace(REGEXP_REPLACE(CREDIT_PROGRAM_ALIAS_NM, '_| ', ''), '.', '')) - 8)))
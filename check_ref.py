print('\n'
    'dm_sm.bank_subsidy references test\n'
      '\n'
      'Wait for further instructions...')


import cx_Oracle as cx
import pandas as pd
import datetime
import sys
import os
import numpy as np

year_input = int(input('Type year:'))
month_input = int(input('Type month:'))

print('Connecting to DWHNW_PDB...')
dsn_new = """(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)
(HOST=rnb-vmdwh-dbpr03.rci.renault.ru)(PORT=1521))
(ADDRESS=(PROTOCOL=TCP)
(HOST=rnb-vmdwh-dbpr03.rci.renault.ru)(PORT=1521))
(LOAD_BALANCE= yes))
(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=DWHNW_PDB)))
"""
connection_new = cx.connect("iz01340", "iz01340", dsn_new)

print('Query in progress...')


print('Checking XREF_DEALER...')
query_new = open("dealer_query.sql", "r").read()
query_new = query_new.format(year_input, month_input, month_input + 1)
dealer_check = pd.read_sql(query_new,
                        con=connection_new,
                        index_col='BIR'
                        )

print(dealer_check)

print('Checking XREF_CREDIT_PROGRAM_ALIAS')

query_new = open("XREF_CREDIT_PROGRAM_alias_null.sql", "r").read()
query_new = query_new.format(year_input, month_input, month_input + 1)
credit_alias_null = pd.read_sql(query_new,
                                con=connection_new)

#last index
query_new = open("max_id_alias.sql", "r").read()
id_seq = pd.read_sql(query_new,
                     connection_new)
print(id_seq.iloc[0, 0])

#credit_alias = credit_alias.reset_index()
#dataframe with null program
credit_alias_null['CREDIT_PROGRAM_ALIAS_ID'] = credit_alias_null.index \
                                               + id_seq.iloc[0, 0]

credit_alias_null.set_index('CREDIT_PROGRAM_ALIAS_ID')
credit_alias_null['FULL_CREDIT_PROGRAM_NM_SPACEOUT'] = credit_alias_null['FULL_CREDIT_PROGRAM_NM']. \
                                                           str.replace(" ", ""). \
                                                           str.replace("_", ""). \
                                                           str.replace(".", ""). \
                                                           str[:-8].str.lower()
print(credit_alias_null)

query_new = open("XREF_CREDIT_PROGRAM_ALIAS.sql", "r").read()
credit_alias = pd.read_sql(query_new,
                           connection_new)

credit_alias_null = pd.merge(credit_alias_null,
                             credit_alias,
                             how='left',
                             left_on='FULL_CREDIT_PROGRAM_NM_SPACEOUT',
                             right_on='CREDIT_PROGRAM_ALIAS_NM_SPACEOUT')

print(credit_alias_null)

#Filling out column  from another one
credit_alias_null.iloc[:, 1]=credit_alias_null.iloc[:, 4]

query_new = open("distinct_xref_credit.sql", "r").read()
distinct_credit = pd.read_sql(query_new,
                           connection_new)

print(credit_alias_null)
print(1)

credit_alias_null = pd.merge(credit_alias_null,
                             distinct_credit,
                             how='left',
                             left_on='FULL_CREDIT_PROGRAM_NM_SPACEOUT',
                             right_on='CREDIT_PROGRAM_NM_SPACEOUT')

print(credit_alias_null)
print(2)
print(credit_alias_null[credit_alias_null['CREDIT_PROGRAM_ID'].isna()].iloc[:, -2])

credit_alias_null['CREDIT_PROGRAM_ID'] = np.where(~credit_alias_null['CREDIT_ID'].
                                                  isnull(),
                                                  credit_alias_null['CREDIT_ID'],
                                                  credit_alias_null['CREDIT_PROGRAM_ID'])

# credit_alias_null[credit_alias_null['CREDIT_PROGRAM_ID'].isna()] = \
#     credit_alias_null[credit_alias_null['CREDIT_PROGRAM_ID'].isna()].iloc[:, -2]

print(credit_alias_null)
print(3)

credit_alias_null = credit_alias_null.iloc[:, :3]

print(credit_alias_null)



print('Checking XREF_CREDIT_PROGRAM...')

query_new = open("xref_credit_program.sql", "r").read()
query_new = query_new.format(year_input, month_input, month_input + 1)
xref_credit_program = pd.read_sql(query_new,
                                con=connection_new)

print(xref_credit_program)

print('Checking XREF_RRP_BRAND...')

query_new = open("dm_sm_xref_rrp_brand.sql", "r").read()
query_new = query_new.format(year_input, month_input)
xref_rrp_brand = pd.read_sql(query_new,
                                con=connection_new)

print(xref_rrp_brand)

print('Checking XREF_SM_SUBSIDY_CALC...')

query_new = open("xref_sm_subsidy_calc.sql", "r").read()
query_new = query_new.format(year_input, month_input)
xref_sm_subsidy_calc = pd.read_sql(query_new,
                                con=connection_new)

print(xref_sm_subsidy_calc)

print('Checking XREF_SM_MODELS_ALIASES...')

query_new = open("max_model_alias.sql", "r").read()
model_seq = pd.read_sql(query_new,
                           connection_new)

query_new = open("xref_sm_models_aliases.sql", "r").read()
models_aliases = pd.read_sql(query_new,
                           connection_new)

models_aliases['MODEL_ALIAS_ID'] = models_aliases.index \
                                   + model_seq.iloc[0, 0]

print(models_aliases)

print('Downloading XREF_SM_MODELS...')

query_new = open("XREF_SM_MODELS.sql", "r").read()
xref_models = pd.read_sql(query_new,
                           connection_new)

print(xref_models)

print('Checking XREF_SM_CARMAKER_INFO...')

query_new = open("XREF_SM_CARMAKER_INFO.sql", "r").read()
query_new = query_new.format(year_input, month_input)
xref_carmaker = pd.read_sql(query_new,
                           connection_new)

print(xref_carmaker)

print('Uploading to XLSX...')

writer = pd.ExcelWriter\
    ('XREF_on_bank_subsidy'+str(month_input)+'_'+str(year_input)+'.xlsx'
     , engine='xlsxwriter')

dealer_check.to_excel(writer, sheet_name='XREF_DEALER')
credit_alias_null.to_excel(writer, sheet_name='XREF_CREDIT_PROGRAM_ALIAS')
xref_credit_program.to_excel(writer, sheet_name='XREF_CREDIT_PROGRAM')
xref_rrp_brand.to_excel(writer, sheet_name='XREF_RRP_BRAND')
xref_sm_subsidy_calc.to_excel(writer, sheet_name='XREF_SM_SUBSIDY_CALC')
models_aliases.to_excel(writer, sheet_name='XREF_SM_MODELS_ALIASES')
xref_models.to_excel(writer, sheet_name='XRED_SM_MODELS')
xref_carmaker.to_excel(writer, sheet_name='XREF_SM_CARMAKER_INFO')

writer.save()

print('Done.')

import pandas as pd
import numpy as np

def period(df):
  return f'{df["Start"]}-{df["End"]}'

def total(df):
  return f'${df["Project Total"]:,d} (${df["Candidates Share"]:,d})'

def investigators(df):
  if df['Names and Roles of Co-Investigators'] == '':
    return 'PI'
  else:
    return f'co-PI, {df["Names and Roles of Co-Investigators"]}'

def make_spend_df(df, key='$/day'):
  dates = pd.date_range(start=df['Start'], periods=df['Days'])
  spend = np.ones(len(dates)) * df[key]
  return pd.Series(spend, index=dates)

def highlight_alternate_rows(row):
    # Apply style to even rows (indexing starts at 0)
    return ['background-color: lightgray' if row.name % 2 == 0 else '' for _ in row]

df = pd.read_csv('./grants.csv', delimiter='|')
df = df[df['Status'] != 'In Review']
df["Names and Roles of Co-Investigators"] = df["Names and Roles of Co-Investigators"].convert_dtypes(str).fillna('')
grant_period = df.apply(period, axis=1)
grant_total = df.apply(total, axis=1)
names = df.apply(investigators, axis=1)
df['Role and Co-Investigators'] =  names
df['Title'] = df['Grant Title']
df['Agency'] = df['Source of Funds/ Funding Agency']
df['Grant Total (My Share)'] = grant_total
df['Grant Period'] = grant_period


df['Start'] = pd.to_datetime(df['Start'], format='%m/%Y')
df['End'] = pd.to_datetime(df['End'], format='%m/%Y')
df['Days'] = (df['End'] - df['Start']).apply(lambda df: np.fix(df.days)).astype(np.int32)
df['$/day (My Share)'] = df['Candidates Share'] / df['Days']
df['$/day'] = df['Project Total'] / df['Days']

df = df.sort_values(by=['Rank', 'Start'], 
  ascending=[True, True], ignore_index=True)


total_days = (pd.to_datetime('8/2023', format='%m/%Y') - df['Start'].min()).days
df_new = pd.DataFrame(index=pd.date_range(start=df['Start'].min(), periods=total_days))
df_new_my_share = pd.DataFrame(index=pd.date_range(start=df['Start'].min(), periods=total_days))

select = (df['Status'] != 'In Review').to_numpy()
for index, row in df[select].iterrows():
   df_new[f'Project {index}'] = make_spend_df(row, key='$/day')
   df_new_my_share[f'Project {index}'] = make_spend_df(row, key='$/day (My Share)')

select = (df_new.index >= pd.to_datetime('8/2016', format='%m/%Y'))
post_tenure_df = df_new.loc[select].sum(axis=1)
post_tenure_df_my_share = df_new_my_share.loc[select].sum(axis=1)
post_tenure_total = np.round(post_tenure_df.sum(), decimals=0)
post_tenure_total_my_share = np.round(post_tenure_df_my_share.sum(), decimals=0)

total = df.loc[df['Status'] != 'In Review', 'Project Total'].sum()
my_share = df.loc[df['Status'] != 'In Review', 'Candidates Share'].sum()

select = (df['Rank'] == 'Associate').to_numpy() * (df['Status'] != 'In Review').to_numpy()
total_in_rank = df.loc[select, 'Project Total'].sum()
my_share_in_rank = df.loc[select, 'Candidates Share'].sum()


df = df.loc[:, 'Role and Co-Investigators':'Grant Period']
ind = len(df) + 1
df.loc[ind, 'Agency'] = 'Totals'
df.loc[ind, 'Grant Total (My Share)'] = f'${total:,d} (${my_share:,d})'

# df.loc[ind + 1, 'Grant Total (My Share)'] = f'${total_in_rank:,d} (${my_share_in_rank:,d})'
# df.loc[ind + 1, 'Title'] = 'Indicates awarded in rank'
#
# df.loc[ind + 2, 'Grant Total (My Share)'] = f'${int(post_tenure_total):,d} (${int(post_tenure_total_my_share):,d})'
# df.loc[ind + 2, 'Title'] = 'Indicates research spending in rank'

df = df.fillna('')
# styled_df = df.style.highlight_between(left='13', right='30', axis=0, color='yellow').hide(axis='index')
styled_df = df.style.apply(highlight_alternate_rows, axis=1)
with open('./table.tex', mode='w') as f:
    f.write(styled_df.to_latex(escape=True, index=False))

# OSHA's Budget And Inflation Graph
This repository contains the code used to create a graph showing how OSHA's budget has eroded due to inflation. My hope is that the graph may enrich the public discussion around OSHA's budget, showing quantitatively what many know intuitively. The data, however, is somewhat tricky, and the notes mentioned in the graph are expanded upon here.

# Data Sources

## OSHA Budget
Except for fiscal year (FY) 2024, the OSHA budget data comes from Sage Data (https://data.sagepub.com/dataset/datasheet?id=18E3517173A22&type=Datasheet).

SAGE gets its numbers from the Federal Budget Authority Database.

The problem with its numbers past FY 2023 is that they are misleading. SAGE uses the number _requested_ by the Department of Labor in its "Fiscal Year 2024 - Budget in Brief" (https://www.dol.gov/sites/dolgov/files/general/budget/2024/FY2024BIB.pdf, page 42).

But this was just a request--the actual operating budget was the same as FY 2023 (https://www.dol.gov/sites/dolgov/files/general/budget/2024/FY2024OperatingPlanAPT.pdf, page 5).

## Inflation Data
On the news, people talk about inflation as though it's one measure. But that's far from reality. In truth, inflation is very nebulous, with a variety of methods of calculating that each cater to some different need. And then some methods vary even further, for example taking out volatile categories (food and energy) to produce a less-noisy rate. This is why the graph uses multiple rates. By estimating OSHA's inflation-adjusted budget since 2010 with multiple different rates, one may see the range of possible values that the true, but unknown, value may be. 

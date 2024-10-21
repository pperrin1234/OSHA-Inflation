# Summary
OSHA is in crisis. Every year, Congress asks OSHA to perform more tasks, while giving them fewer resources to do so. But the truth of this is not immediately obvious--after all, OSHA's budget *looks* like it is increasing significantly over time, and it is not easy to account for inflation in one's head when looking at such figures. By comparing OSHA's budget against a variety of inflation rates, this repository provides clear evidence of OSHA's shrinking budget, with the hope of making the discourse more data-driven.

![Untitled](https://github.com/user-attachments/assets/76244647-8581-4d50-b26b-f2719f1db1f3)

![Untitled](https://github.com/user-attachments/assets/1f333627-59ff-4e85-afdc-d2d52707376b)


# Data Sources

## OSHA Budget
The budget data was manually extracted from the Department of Labor's Operating Plans, from FY 2009 to FY 2024. Other estimates tend to be of lower quality, primarily because they include mandatory spending, such as money authorized by the American Rescue Plan which significantly increased OSHA's budget for just one fiscal year (FY 2020). Furthermore, some of the earlier fiscal years had their estimates revised years later, so some of these other data sources may be using unrevised data. Also, some data sources may mislead by showing what the Department of Labor _requested_ its budget be, rather than what it actually received from Congress.

## Inflation Data
On the news, people talk about inflation as though it's one measure. But that's far from reality. In truth, inflation is very nebulous, with a variety of methods of calculating that each cater to some different need. And then some methods vary even further, for example taking out volatile categories (food and energy) to produce a less-noisy rate. This is why the graph uses multiple rates. By estimating OSHA's inflation-adjusted budget since 2010 with multiple different rates, one may see the range of possible values that the true, but unknown, value may be. 

The inflation data is pulled from FRED. FRED, or Federal Reserve Economic Data, is run by the St. Louis Federal Reserve, and is the go-to source for a variety of economic data. The code used to generate the graph uses the fredr package to pull data from the FRED API, retrieving up-to-date data on demand.

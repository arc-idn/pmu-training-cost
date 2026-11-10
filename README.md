# PMU training: JKN cost projection

Training repository for the BKPK Policy Modelling Unit (PMU). It teaches how to project what JKN will need to finance,
step by step, in R. **The data here is DUMMY data, invented for practice.** No real BPJS data is included.

## The policy question

How much will JKN spend in the coming years, how does that compare with contribution revenue, and which drivers
(number of members, use of services, cost per service) move the gap most? This follows PMU research plan study C
(JKN financing needs and sustainability).

## The method in four steps

1. **Cost today.** For each membership segment and year: members x visits per member x cost per visit, at primary care
   (FKTP), hospital outpatient (RJTL) and inpatient (RITL) level. Revenue: members x contribution x 12.
2. **Growth of the drivers.** Average yearly growth, 2019-2024, of the number of members and of cost per member.
3. **Scenarios to 2030.** Base (past growth continues), high utilisation (+3 points a year on cost per member) and cost
   containment (-2 points). Contributions stay at 2024 rates, so the gap shows the financing need.
4. **Outputs.** A projection table and a chart of cost and revenue.

## How to run

In RStudio, open this folder as a project and run `source("run_all.R")`, or in a terminal `Rscript run_all.R`.
It creates the dummy data if missing, then runs the scripts in order. Only base R is used.

| File | What it does |
|---|---|
| `R/00_make_dummy_data.R` | Writes the dummy input `data/dummy/jkn_dummy_segment_year.csv` |
| `R/01_clean.R` | Reads and checks the input, computes cost and revenue by segment and year |
| `R/02_analysis.R` | Estimates driver growth and projects three scenarios to 2030 |
| `R/03_outputs.R` | Writes `outputs/projection_2025_2030.csv` and `outputs/projection.png` |

## Using real data

Put your files in another folder and set `DATA_DIR` before running, for example
`Sys.setenv(DATA_DIR = "D:/pmu/data")`. The input needs one row per segment and year with the columns of the dummy file:
`year, segment, members_m, fktp_rate, rjtl_rate, ritl_rate, fktp_cost, rjtl_cost, ritl_cost,
contribution_per_member_month`. Never commit real data: `.gitignore` keeps `data/` (except the dummy files) and
`outputs/` out of git.

## Exercises

1. Which segment contributes most to the cost growth? Add a table of cost growth by segment.
2. Add a scenario in which contributions rise 10% in 2027. When does the gap close, if ever?
3. Replace the single growth rate of cost per member with separate growth rates for utilisation and unit cost.
4. How sensitive is the 2030 gap to a one-point change in the growth of membership?

ARC Institute for the BKPK Policy Modelling Unit. Dummy data only.

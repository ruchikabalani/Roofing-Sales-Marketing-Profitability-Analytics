# Roofing Sales, Marketing & Profitability Analytics

**PostgreSQL + Tableau Public | Business analytics portfolio project**

An end-to-end analysis of a fictional roofing company's sales pipeline, project profitability, and marketing performance. The project uses **synthetic data** to demonstrate SQL analysis, KPI design, interactive dashboard development, and business-focused recommendations.

## Interactive Tableau dashboards

**[Explore the Tableau Public workbook](https://public.tableau.com/app/profile/ruchika.balani/viz/RoofingSalesMarketingProfitabilityAnalytics/RoofingSalesPipelineOverview3)**

The workbook includes three dashboards:

1. **Sales Pipeline Overview** — Lead volume, win rate, conversion time, channel performance, and pipeline stages.
2. **Project Profitability Overview** — Revenue, direct project costs, gross profit, service-line margins, and monthly trends.
3. **Marketing Performance Overview** — Marketing spend, cost per lead, cost per conversion, channel efficiency, and monthly trends.

## Project overview

| Area | Headline result |
| --- | ---: |
| Leads analyzed | 800 |
| Converted leads | 250 |
| Lead conversion rate | 31.25% |
| Average days to conversion | 23.1 |
| Project revenue | $2,394,160 |
| Project gross profit | $860,602 |
| Gross profit margin | 35.9% |
| Marketing spend | $84,132 |
| Cost per lead | ~$105 |
| Cost per conversion | ~$337 |

*Figures are rounded where appropriate and reflect the synthetic portfolio dataset.*

## Key business findings

### 1. Referrals show strong acquisition efficiency
Referral leads convert at **48%** and cost about **$30 per lead**, compared with **27% / $156** for Google Ads and **15% / $186** for Direct Mail. A referral-program pilot may be worthwhile, but management should first test whether referral volume can scale and whether referred projects remain profitable.

### 2. Estimate follow-up could improve pipeline performance
The pipeline contains **139 leads at “Estimate Sent”**, plus 114 “Contacted” and 67 “New.” Reviewing estimate age, customer objections, and follow-up timing could identify recoverable opportunities. These records should not automatically be treated as currently active deals.

### 3. Roof replacement drives most gross profit
Roof replacement contributes approximately **$624K**, or **72%**, of total gross profit. Its margin is around **36%**, close to the overall average. Protecting material purchasing efficiency, crew productivity, and pricing in this service line is therefore important.

### 4. Marketing efficiency weakened in December
Monthly cost per lead increased from approximately **$92 in November** to **$140 in December**, while leads declined from **69 to 54**. This is a signal to investigate campaign mix, seasonal demand, and lead quality—not proof of a particular cause.

### 5. High revenue does not automatically imply higher profitability
July generated approximately **$304K in revenue** and **$112K in gross profit**. Reviewing project mix and direct costs is necessary to understand what drove that performance and whether it can be repeated.

## Recommended actions

- Pilot a structured customer referral program and measure incremental conversion and acquisition costs.
- Audit and prioritize follow-up for leads in the estimate stage.
- Evaluate marketing channels using **attributable project gross profit**, not only lead counts.
- Monitor material and labor cost variance on roof replacement projects.
- Investigate the drivers of December's higher cost per lead before reallocating spend.

## Tools and methods

- **PostgreSQL / SQL:** Joins, aggregations, common table expressions (CTEs), date-based analysis, profitability calculations, and reusable SQL views.
- **Tableau Public:** Interactive dashboards, calculated fields, KPI cards, filters, bar charts, line charts, and dual-axis visualizations.
- **Business analysis:** Lead conversion, sales pipeline analysis, marketing acquisition efficiency, and gross margin analysis.

## Repository contents

```text
.
├── README.md
├── Roofing_Business_Insights_Report_Revised.pdf
├── data/
│   ├── leads.csv
│   ├── projects.csv
│   └── marketing_spend.csv
└── sql/
    ├── 01_sales_pipeline_view.sql
    ├── 02_project_profitability_view.sql
    ├── 03_marketing_performance_view.sql
    ├── 04_sales_analysis.sql
    ├── 05_marketing_analysis.sql
    └── 06_profitability_analysis.sql
```

**[Read the Business Insights & Strategic Recommendations report](Roofing_Business_Insights_Report_Revised.pdf)**

The SQL files document the analyses and the three views used to prepare Tableau-ready datasets. Source tables are `roofing.leads`, `roofing.projects`, and `roofing.marketing_spend` in a PostgreSQL database.

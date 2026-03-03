# Private Markets Reporting & Governance Portfolio
**Akhil Vohra** | Data & Reporting Analyst

---

## Overview

This portfolio demonstrates end-to-end reporting and data governance skills applied to a private markets fund administration context — directly mirroring the operational environment at firms like BBH, where fund administrators are responsible for LP reporting, NAV validation, capital activity tracking, and data integrity across multi-currency,multi-fund structures.

The work covers the full reporting lifecycle: raw data ingestion, structured querying, business analysis, governance dashboards, and client-facing LP reporting. All three core tools — SQL, Power BI, and Excel — are represented with real business use cases.

---

## The Dataset

**File:** `private_markets_raw_data.xlsx`

| Table | Description |
|---|---|
| `Funds` | Master fund register — 3 funds, $2.75B total AUM |
| `Investors` | LP base — pension funds, insurance companies, endowments, family offices |
| `Commitments` | LP commitments per fund, including side letter fee discounts |
| `Transactions` | 107 capital calls, distributions and management fees |
| `FX_Rates` | Historical exchange rates (USD, EUR, GBP) |
| `NAV_Quarterly` | Quarterly NAV — gross, net, called and distributed to date |

---

## SQL Queries (`/sql`)

| # | File | Business Question |
|---|---|---|
| 01 | `01_fund_overview.sql` | What funds are we administering and what is their size? |
| 02 | `02_lp_commitments_ranked.sql` | Which investors have the largest total commitments? |
| 03 | `03_commitment_utilization.sql` | What percentage of each LP commitment has been called? |
| 04 | `04_capital_calls_by_fund.sql` | How much capital has been drawn down per fund? |
| 05 | `05_distributions_by_fund.sql` | How much has been returned to investors per fund? |
| 06 | `06_investor_type_breakdown.sql` | What is our LP base composition by investor type? |
| 07 | `07_net_cash_flow_by_fund.sql` | What is the net cash position per fund? |
| 08 | `08_transaction_activity_by_quarter.sql` | How has transaction volume trended over time? |
| 09 | `09_lp_statement.sql` | What is each investor's complete financial position? |
| 10 | `10_fx_exposure.sql` | Which transactions involved currency conversion? |
| 11 | `11_nav_progression.sql` | How has each fund's NAV evolved quarter by quarter? |
| 12 | `12_fund_dpi.sql` | How much have investors gotten back relative to what they put in? |
| 13 | `13_investor_concentration.sql` | What percentage of total AUM does each LP represent? |
| 14 | `14_unfunded_commitments.sql` | How much capital is each LP still obligated to contribute? |
| 15 | `15_quarterly_reporting_pack.sql` | Complete fund health snapshot — NAV, DPI, RVPI |

**Techniques used:** CTEs, window functions (`LAG`), `CASE WHEN`, `CROSS JOIN`, `COALESCE`, multi-table JOINs across 3+ tables

---

## Power BI Dashboard (`/powerbi`)

Three-page dashboard balancing performance analytics with governance and exception reporting.

| Page | Focus |
|---|---|
| Fund Performance Overview | NAV progression, LP commitments, capital activity, investor concentration |
| Data Governance & Exception Reporting | FX exception flags, commitment compliance checks, LP utilization |
| LP Activity & NAV Reconciliation | Ledger vs NAV variance analysis, exception counts by control type |

DAX measures: `Total Called`, `Called_Variance` (NAV-reported vs ledger balancing figure)

---

## Excel LP Quarterly Statement (`/excel`)

**`LP_Quarterly_Statement_Stichting_Pensioenfonds_ABN_Q2_2024.xlsx`**

Client-facing quarterly statement for Stichting Pensioenfonds ABN (Dutch pension fund, EUR) as at Q2 2024.

| Sheet | Purpose |
|---|---|
| LP Statement | Investor details, KYC status, portfolio summary |
| Transaction Detail | Every capital call, distribution and fee with FX rates |
| Fund Performance | DPI per fund |
| NAV Attribution | Opening NAV + Called + Unrealised Gains/(Losses) − Fees = Closing NAV |
| Cash Flow Timeline | J-curve analysis with quarterly In J-Curve / Above Water status |
| Fee Summary | Fees by fund and period, as % of called capital |
| FX Impact Summary | EUR/USD translation impact per transaction |

**Key figures:** $550M committed | $455.9M called (82.9%) | $25M distributed | DPI 0.05x | Cumulative net CF -$430.9M

---

## Data Governance Controls

| Control | Tool | What It Catches |
|---|---|---|
| JOIN duplication prevention | SQL (CTEs) | Inflated totals from multi-table joins |
| Missing FX rate flag | Power BI | Transactions with NULL FX rates |
| NAV reconciliation break detection | Power BI | Mismatch between NAV-reported and ledger values |
| Called > Committed validation | Excel | LP over-commitment data errors |
| J-Curve status tracking | Excel | Investor cumulative cash flow position per quarter |
| Fee burden monitoring | Excel | Management fees as % of called capital |

---

## Process Documentation

**`Private_Markets_Fund_Administration_Process_Documentation_Akhil_Vohra.docx`**

Full documentation covering data architecture, SQL techniques, Power BI design, Excel LP statement methodology, governance controls, and key findings.

---

## Repository Structure
```
bbh-reporting-portfolio/
├── sql/                        15 SQL queries (01–15)
├── powerbi/
│   ├── private_markets_dashboard.pbix
│   └── private_markets_dashboard.pdf
├── excel/
│   └── LP_Quarterly_Statement_Stichting_Pensioenfonds_ABN_Q2_2024.xlsx
├── private_markets_raw_data.xlsx
├── Private_Markets_Fund_Administration_Process_Documentation_Akhil_Vohra.docx
└── README.md
```

---

*All data is synthetic and created for demonstration purposes only.*

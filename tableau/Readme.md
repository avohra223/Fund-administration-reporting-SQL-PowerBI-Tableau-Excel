# Tableau Dashboards

Interactive dashboards built from `private_markets_raw_data_March2026.xlsx` (8 sheets: 3 funds, 6 LPs, 107 transactions, 25 quarters NAV, benchmarks, performance metrics).

## Dashboard 1: Fund Performance & Benchmarking
- Quarterly excess return vs benchmark (bar chart)
- TVPI heat map by fund and year

[View Dashboard](https://public.tableau.com/app/profile/akhil.vohra/viz/FundAdministrationPortfolio-AkhilVohra/PerformanceDashboard)

## Dashboard 2: Capital Activity & LP Overview
- NAV progression vs capital deployed (combo chart: lines + bars)
- Capital calls, distributions & fees by fund
- LP commitment breakdown by fund

[View Dashboard](https://public.tableau.com/app/profile/akhil.vohra/viz/FundAdministrationPortfolio-AkhilVohra/CapitalDashboard)

## Data Source
All visuals connect to the Excel workbook in the repo root. Key sheets used:
- `Performance_vs_Benchmark` — fund returns, benchmark returns, excess returns
- `NAV_Quarterly` — quarterly NAV, called capital, distributions
- `Transactions` — 107 individual transactions (calls, fees, distributions)
- `Commitments` — LP-level commitment amounts by fund
- `Fund_Performance_Metrics` — TVPI, DPI, RVPI, quarterly NAV returns
- `Benchmarks` — Cambridge PE, S&P 500, ICE BofA Euro HY quarterly returns

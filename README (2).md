# 📊 Sales Pipeline & Revenue Operations Analysis

> An end-to-end revenue operations analysis tracking sales performance, pipeline velocity, discount impact, and order trends — built with SQL and Power BI.

---

## 🧩 Business Problem

Revenue and sales operations teams need clear, reliable visibility into how revenue is being generated, where discounts are eroding profit, and how order volume is trending over time. Without this visibility, businesses cannot make informed decisions around pricing strategy, territory planning, or quota management.

This project simulates that environment — delivering the kind of operational intelligence a Revenue Operations team uses daily.

---

## 🎯 Objectives

- Track total revenue, profit, and order performance over time
- Analyze pipeline velocity through monthly and quarterly revenue trends
- Measure average order value across segments and years
- Quantify the impact of discounting on profit margins
- Identify which customer segments and regions drive the most value

---

## 🛠️ Tools Used

| Tool | Purpose |
|---|---|
| SQL | Data cleaning, transformation, metric calculation |
| Power BI | Interactive dashboard and data visualization |
| Microsoft Excel | Data validation and preliminary exploration |

---

## 📁 Repository Structure

```
├── data/
│   └── sales_pipeline.csv          # Source dataset (Kaggle)
├── sql/
│   ├── 01_data_cleaning.sql        # Null handling, deduplication, standardization
│   └── 02_revenue_metrics.sql      # KPI queries: revenue, AOV, discount analysis
├── dashboard/
│   └── dashboard_screenshot.png    # Power BI dashboard preview
├── report/
│   └── Sales_Pipeline_Report.pdf   # Full analysis report with findings
└── README.md
```

---

## 📈 Dashboard Preview

![Sales Pipeline Dashboard](dashboard/dashboard_screenshot.png)

---

## 📊 Key Metrics Built

- **Total Revenue** — $2.30M across the full period
- **Total Orders** — 10K transactions analyzed
- **Average Order Value (AOV)** — $459 per order
- **Overall Profit** — $286K net profit
- **Monthly & Quarterly Revenue Trends** — seasonal patterns identified
- **Average Profit by Discount Bracket** — discount erosion quantified
- **Order Volume by Discount Tier** — pricing behavior mapped

---

## 🔍 Key Findings

1. **Q4 consistently outperforms all other quarters** — revenue peaks in Q4, suggesting strong seasonal demand or end-of-year budget spending patterns
2. **Order volume grew exponentially from 2020 to 2023** — indicating strong business growth or market expansion over the period
3. **Discounts above 30% generate negative average profit** — the highest discount tier is actively loss-making, representing a significant pricing risk
4. **The 0% discount bracket carries the healthiest margins** — undiscounted orders deliver the strongest profit per transaction
5. **AOV has remained relatively stable year-over-year** — suggesting consistent deal sizing despite volume growth

---

## 💡 Business Recommendations

1. **Implement discount approval thresholds** — orders above 20% discount should require manager sign-off given the demonstrated profit erosion at higher tiers
2. **Protect Q4 pipeline aggressively** — Q4 is the highest revenue quarter; sales capacity and resource allocation should reflect this
3. **Review 30%+ discount deals for strategic fit** — these deals are loss-making on average and should only be approved with clear long-term customer value justification
4. **Investigate 2020–2021 order volume drivers** — understanding what caused the growth inflection point can inform future territory and quota planning

---

## 📂 Data Source

Public dataset sourced from Kaggle.
Columns used: `row_id`, `order_id`, `order_date`, `contact_name`, `country`, `city`, `region`, `subregion`, `customer`, `customer_id`, `industry`, `segment`, `product`, `license`, `sales`, `quantity`, `discount`, `profit`

---

## 👩🏽‍💻 Author

**Sinmiloluwa Ayoola** — Data & Revenue Operations Analyst
[LinkedIn](https://linkedin.com/in/sinmiloluwa-ayoola-a366171b6) | [Portfolio](https://github.com/afeniki)

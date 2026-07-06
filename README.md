# 🛍️ Customer Shopping Behavior Analysis

### End-to-End Data Analytics Project | Python • SQL • Power BI

![Python](https://img.shields.io/badge/Python-3.10-blue?logo=python&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-Data%20Cleaning-150458?logo=pandas&logoColor=white)
![MySQL](https://img.shields.io/badge/SQL-MySQL-4479A1?logo=mysql&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?logo=powerbi&logoColor=black)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)

A complete data analytics pipeline — from raw, messy retail data to a polished, interactive dashboard — built to uncover what drives customer purchasing behavior, retention, and revenue in an e-commerce/retail setting.

---

## 📌 Table of Contents
- [Overview](#-overview)
- [Dashboard Preview](#-dashboard-preview)
- [Dataset](#-dataset)
- [Tools & Technologies](#️-tools--technologies)
- [Project Workflow](#-project-workflow)
- [Key Insights](#-key-insights)
- [Repository Structure](#-repository-structure)
- [How to Run](#-how-to-run)
- [Author](#-author)

---

## 📖 Overview

This project analyzes shopping behavior for **3,900 customers** across a retail dataset, aiming to answer real business questions: *Who is spending the most? Does subscribing actually keep customers loyal? Which products and shipping methods perform best?*

The workflow mirrors a real-world analytics pipeline used by data/BI teams:

**Raw CSV → Python Cleaning → SQL Database → SQL Analysis → Power BI Dashboard**

The goal is to turn raw transactional data into decision-ready insights that a retail business could act on — improving revenue, customer retention, and marketing spend.

---

## 📊 Dashboard Preview

<p align="center">
  <img src="Dashboard.png" alt="Customer Behavior Dashboard" width="800"/>
</p>

The Power BI dashboard includes:
- KPI cards for **Average Purchase Amount ($59.76)**, **Average Review Rating (3.75)**, and **Total Customers (3.9K)**
- A donut chart breaking down subscribers vs. non-subscribers (27% / 73%)
- Revenue & sales breakdowns by **Category** and **Age Group**
- Interactive slicers for Subscription Status, Gender, Category, and Shipping Type

> 💡 *Add your exported dashboard image as `Dashboard.png` in the repo root so it renders above, or replace with your `.pbix` file link.*

---

## 🗂️ Dataset

The project uses `customer_shopping_behavior.csv` — transaction-level data where each row represents a customer's most recent purchase.

| Category | Columns |
|---|---|
| **Demographics** | Customer ID, Age, Gender, Location |
| **Purchase Details** | Item Purchased, Category, Purchase Amount (USD), Size, Color, Season |
| **Shipping & Promotions** | Shipping Type, Discount Applied, Promo Code Used |
| **Behavioral Metrics** | Review Rating, Subscription Status, Previous Purchases, Payment Method, Frequency of Purchases |

**Size:** ~3,900 rows × 18 columns

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|---|---|
| **Python (Pandas)** | Data cleaning, feature engineering |
| **Jupyter Notebook** | Development environment for the cleaning pipeline |
| **SQL (MySQL)** | Business-question querying, CTEs, window functions |
| **Power BI + DAX** | Interactive dashboard and KPI reporting |
| **SQLAlchemy / psycopg2 / pymysql** | Python ↔ database connectivity |

---

## 🔄 Project Workflow

### 1️⃣ Data Cleaning & Feature Engineering (`data_cleaning.ipynb`)
- Loaded and inspected the raw dataset with `pandas` (`.info()`, `.describe()`, null checks).
- Handled missing `review_rating` values by imputing the **median rating within each product category**, rather than a global median — preserving category-level rating patterns.
- Standardized all column names to `snake_case` (e.g. `Purchase Amount (USD)` → `purchase_amount`).
- Engineered new features:
  - **`age_group`** — bucketed customers into `young_adults`, `adult`, `middle_aged`, `senior` using `pd.qcut()` for even quartile splits.
  - **`purchase_frequency_days`** — mapped textual frequency labels (`Weekly`, `Fortnightly`, `Monthly`, etc.) to numeric day values for quantitative analysis.
- Identified and dropped `promo_code_used` after confirming it was 100% redundant with `discount_applied`.
- Loaded the cleaned DataFrame into a MySQL database using `SQLAlchemy` for downstream SQL analysis.

### 2️⃣ SQL Analysis (`analysis.sql`)
Business questions answered directly in SQL:
- 💰 Revenue split by **gender**
- 🎯 Customers who used a discount but **still spent above the average** purchase amount
- ⭐ **Top 5 products** by average review rating
- 🚚 Average spend comparison: **Standard vs. Express shipping**
- 🔁 Spend and revenue comparison: **subscribers vs. non-subscribers**
- 🏷️ **Top 5 products** most frequently sold with a discount
- 🧩 Customer segmentation into **New / Returning / Loyal** tiers using `CASE` + CTEs
- 🏆 **Top 3 best-selling products per category** using the `ROW_NUMBER()` window function
- 📉 Whether high-frequency repeat buyers are actually converting into subscribers
- 📈 Revenue contribution by **age group**

### 3️⃣ Dashboard Design
- Connected Power BI directly to the MySQL database.
- Built DAX measures for core KPIs (avg. purchase, avg. rating, customer count).
- Designed a single-page dashboard with donut, bar, and column charts plus cross-filtering slicers for fast exploration.

---

## 🔑 Key Insights

- **📦 Express shipping customers spend more** on average than Standard shipping customers — suggesting express buyers may be less price-sensitive.
- **🧑 Young Adults drive the most revenue** of any age group, making them the highest-priority segment for marketing spend.
- **⚠️ Subscription paradox:** Non-subscribers make up 73% of customers, and a large share of *repeat* buyers (previous purchases > 5) still aren't subscribed — pointing to an untapped opportunity to convert loyal repeat buyers into paying subscribers.
- **⭐ Certain product categories** (e.g. footwear and accessories items like gloves, sandals, boots) consistently earn the highest average review ratings, making them strong candidates for promotional focus.
- **🏷️ Discount usage varies significantly by product** — some items are discounted far more frequently than others, useful for evaluating discount ROI.

---

## 📁 Repository Structure

```
customer-shopping-behavior-analysis/
│
├── customer_shopping_behavior.csv    # Raw dataset
├── data_cleaning.ipynb               # Python cleaning & feature engineering
├── analysis.sql                      # SQL business-question queries
├── Dashboard.pdf                     # Power BI dashboard export
├── Dashboard.png                     # (optional) dashboard screenshot for preview
└── README.md                         # Project documentation
```

---

## ▶️ How to Run

1. **Clone this repository**
   ```bash
   git clone https://github.com/<your-username>/<repo-name>.git
   cd <repo-name>
   ```
2. **Install dependencies**
   ```bash
   pip install pandas sqlalchemy pymysql psycopg2-binary
   ```
3. **Run the cleaning notebook**
   Open `data_cleaning.ipynb` and run all cells to clean the raw CSV and (optionally) load it into your own MySQL/PostgreSQL instance.
   > ⚠️ Before running, replace the database credentials in the notebook with your own — **never commit real passwords to a public repo**. Consider using environment variables (`os.environ`) or a `.env` file instead.
4. **Run the SQL queries**
   Execute the queries in `analysis.sql` against your loaded `customer` table to reproduce the analysis.
5. **View the dashboard**
   Open the `.pbix` file (if included) in Power BI Desktop, or view the static export in `Dashboard.pdf`.

---

## 👤 Author

**Shikhar**
Aspiring Data Analyst

Feel free to connect or reach out if you have feedback on this project!

---

⭐ *If you found this project interesting, consider giving it a star!*

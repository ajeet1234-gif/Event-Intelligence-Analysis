# 🎟️ Event Intelligence Analytics Platform

<p align="center">
<strong>Clean • Analyze • Model • Visualize • Discover</strong><br>
An end-to-end event analytics project combining Python data cleaning, MySQL analysis, and Power BI business intelligence.
</p>

---

## 📌 Project Overview

**Event Intelligence Analytics Platform** is an end-to-end data analytics project built to analyze customers, events, tickets, bookings, payments, attendance, venues, organizers, event categories, and weather conditions.

The project follows a practical analytics workflow:

```text
Raw CSV Data
      ↓
Python Data Audit & Cleaning
      ↓
Validated / Cleaned CSVs
      ↓
MySQL Relational Database
      ↓
SQL Business Analysis
      ↓
Power BI Data Model & Dashboard
      ↓
Business Insights
```

The project demonstrates the complete journey from raw relational data to interactive business intelligence.

---

## 🎯 Project Objectives

- Audit the quality of 10 related event-analytics datasets.
- Remove duplicate rows and duplicate business keys where appropriate.
- Standardize text categories and dates.
- Handle missing and invalid values.
- Validate primary-key and foreign-key relationships.
- Handle orphan foreign-key records.
- Apply business-rule validation.
- Load cleaned data into MySQL.
- Analyze customer, event, venue, booking, ticket, revenue, payment, attendance, organizer, and category performance.
- Build an interactive Power BI dashboard for decision-oriented analysis.

---

# 🧩 System Architecture

```text
┌─────────────────────────────┐
│       Raw Event Data        │
│        10 CSV Tables        │
└──────────────┬──────────────┘
               │
               ▼
┌─────────────────────────────┐
│      Python / Pandas        │
│ Audit • Cleaning • QA       │
│ Validation • Standardizing  │
└──────────────┬──────────────┘
               │
               ▼
┌─────────────────────────────┐
│       Cleaned CSVs          │
│   Validated relational data │
└──────────────┬──────────────┘
               │
               ▼
┌─────────────────────────────┐
│          MySQL              │
│ Tables • PK • FK • Queries  │
└──────────────┬──────────────┘
               │
               ▼
┌─────────────────────────────┐
│          Power BI            │
│ KPIs • Charts • Slicers     │
│ Interactive Dashboard       │
└─────────────────────────────┘
```

---

# 🗃️ Data Model

The project contains 10 relational tables.

| Table | Purpose |
|---|---|
| `customers` | Customer profile, demographics, location, registration and segment information |
| `event_categories` | Event category reference data |
| `venues` | Venue, city, capacity and location characteristics |
| `organizers` | Organizer profiles and business information |
| `events` | Event master data, category, venue, organizer, date, price and status |
| `tickets` | Ticket type, seat category, pricing, discount and status |
| `bookings` | Customer ticket bookings, quantity, channel, date and status |
| `payments` | Payment transactions, amount, method, status and refunds |
| `attendance` | Event attendance, check-in/check-out and attendance status |
| `weather` | Event-level weather conditions and measurements |

### Core relationships

```text
customers ────────< bookings >──────── tickets >──────── events
                       │                                  │
                       ▼                                  ├── event_categories
                   payments                               ├── venues
                                                          └── organizers

customers ────────< attendance >──────── events
                                             │
                                             └──────── weather
```

The MySQL schema in `sql/event_intelligence.sql` defines the primary and foreign-key relationships.

---

# 📊 Dataset & Data Quality

The initial audit in the cleaning notebook identified the following raw dataset scale and quality issues:

| Table | Raw Rows | Columns | Duplicate Rows | Missing Cells |
|---|---:|---:|---:|---:|
| Attendance | 250,800 | 8 | 800 | 0 |
| Bookings | 301,000 | 8 | 1,000 | 0 |
| Customers | 101,500 | 9 | 1,500 | 2,526 |
| Event Categories | 15 | 4 | 0 | 0 |
| Events | 5,150 | 12 | 150 | 0 |
| Organizers | 2,100 | 7 | 100 | 207 |
| Payments | 320,800 | 8 | 800 | 1,101 |
| Tickets | 50,500 | 9 | 500 | 304 |
| Venues | 500 | 10 | 0 | 250 |
| Weather | 20,300 | 8 | 300 | 0 |

The audit also records memory usage and missing-value percentages before cleaning.

---

# 🧹 Python Data Cleaning

The cleaning notebook is designed as a complete pipeline rather than a collection of isolated transformations.

### Cleaning steps documented in the notebook

- Load all 10 raw tables.
- Create a data-quality audit.
- Remove exact duplicate rows.
- Remove duplicate business keys where appropriate.
- Standardize text using trimming and whitespace normalization.
- Normalize category labels.
- Validate email formats.
- Handle missing values.
- Fix invalid numeric values.
- Standardize date fields.
- Validate primary keys and foreign keys.
- Identify and handle orphan foreign-key records.
- Apply business-rule validation.
- Export cleaned CSV files.
- Produce a final quality report.

Raw CSVs are not overwritten by the notebook.

### Notebook

`notebooks/01_Event_Intelligence_Data_Cleaning.ipynb`

---

# 🗄️ MySQL Data Layer

The SQL file creates the `event_intelligence` database and the 10 relational tables, loads cleaned CSV files using `LOAD DATA LOCAL INFILE`, restores foreign-key checks, and runs row-count verification.

### Main database tables

```text
customers
            ↓
bookings → tickets → events → event_categories
    ↓                  ↓
 payments            venues
                       ↓
                   organizers

attendance → events
weather    → events
```

### SQL file

`sql/event_intelligence.sql`

---

# 📈 SQL Business Analysis

The SQL analysis contains **50 business questions** grouped into analytical areas:

### Customer Analysis

- Total customers
- Customers by city
- Gender distribution
- Average customer age
- Customer age groups

### Event Analysis

- Total events
- Events by category
- Average ticket price by category
- Top events by ticket price
- Events by organizer

### Venue Analysis

- Events by venue
- Highest-capacity venues
- Venues by city

### Booking Analysis

- Total bookings
- Booking status distribution
- Booking-channel performance
- Monthly booking trend
- Highest-booking customers

### Ticket Analysis

- Ticket-type distribution
- Average ticket price by type
- Seat-category pricing
- Average discount
- Highest-discount tickets

### Revenue & Payment Analysis

- Completed-payment revenue
- Payment status distribution
- Revenue by payment method
- Monthly revenue trend
- Top events by revenue

### Customer Behaviour

- Repeat customers
- Bookings by customer segment
- Revenue by customer segment
- Bookings by age group

### Attendance

- Attendance status distribution
- Highest-attendance events
- Attendance rate by event

### Advanced Business Analysis

- Revenue by organizer
- Bookings by organizer
- Category revenue ranking
- Top 3 events within each category
- Monthly revenue and running total
- High-booking / low-attendance events
- Revenue by venue
- Average revenue per booking
- Highest-booking events
- Highest-booking categories
- Highest-revenue customers
- Overall booking-to-attendance conversion rate
- Overall business metrics

---

# 📊 Power BI Dashboard

The supplied Power BI report contains **four pages** and uses a widescreen 1920×1080 canvas. The report includes KPI cards, analytical charts, slicers, navigation buttons, images and a custom theme.

### Dashboard capabilities include

- Executive KPI monitoring
- Booking analytics
- Customer analytics
- Revenue and payment analysis
- Category performance
- Interactive filtering
- Navigation between report pages

The complete extracted report definition and source package are stored under:

`powerbi/`

---

# 🔑 Core KPIs

The dashboard analysis covers metrics such as:

- Total Customers
- Total Events
- Total Bookings
- Confirmed Bookings
- Cancelled Bookings
- Total Revenue
- Total Attendance
- Successful / completed payments
- Failed payments
- Average payment amount
- Customer repeat rate
- Booking-to-attendance conversion

Exact measures and visual configurations are maintained in the Power BI report.

---

# 📁 Project Structure

```text
Event_Intelligence_GitHub_Ready/
│
├── data/
│   └── README.md
│
├── notebooks/
│   └── 01_Event_Intelligence_Data_Cleaning.ipynb
│
├── sql/
│   └── event_intelligence.sql
│
├── powerbi/
│   ├── Event_Intelligence_Report/
│   ├── Event_Intelligence_Report_Source.zip
│   └── README.md
│
├── images/
│   └── dashboard_screenshots/   # add final exported screenshots here
│
├── .gitignore
├── requirements.txt
└── README.md
```

---

# ⚙️ Setup

## 1. Clone the repository

```bash
git clone <YOUR_GITHUB_REPOSITORY_URL>
cd Event_Intelligence_GitHub_Ready
```

## 2. Create a virtual environment

### macOS / Linux

```bash
python3 -m venv .venv
source .venv/bin/activate
```

### Windows

```bash
python -m venv .venv
.venv\\Scripts\\activate
```

## 3. Install Python dependencies

```bash
pip install -r requirements.txt
```

## 4. Run the cleaning notebook

Open:

```text
notebooks/01_Event_Intelligence_Data_Cleaning.ipynb
```

Update the raw-data path for your local machine if necessary, then run the notebook from top to bottom.

## 5. Load the cleaned data into MySQL

Open:

```text
sql/event_intelligence.sql
```

Update the `LOAD DATA LOCAL INFILE` paths to match your local cleaned-data folder, then execute the script in MySQL Workbench/MySQL 8.x.

## 6. Open Power BI

Use the supplied Power BI report/project under `powerbi/` and connect it to the MySQL database according to the model used in the report.

---

# 🛠️ Tech Stack

| Category | Technology |
|---|---|
| Programming | Python |
| Data Processing | Pandas, NumPy |
| Visualization / EDA | Matplotlib, Seaborn |
| Database | MySQL |
| Querying | SQL |
| BI | Microsoft Power BI |
| Notebook | Jupyter Notebook |
| Version Control | Git / GitHub |

---

# 💡 Business Questions Answered

The project is designed to answer questions such as:

- Which event categories generate the most revenue?
- Which booking channels generate the most bookings?
- Which customers contribute the most revenue?
- Which venues generate the highest revenue?
- Which organizers generate the highest revenue?
- How does booking volume change month by month?
- How does revenue change month by month?
- Which events attract high bookings but low attendance?
- Which customer segments generate the most bookings and revenue?
- How does attendance compare with booking volume?
- What is the overall booking-to-attendance conversion rate?

---

# ⚠️ Project Notes

- The cleaning notebook expects the raw CSV folder structure used during development; local paths should be updated when running on another machine.
- The SQL import script also contains local file paths that must be updated for the user's environment.
- Large raw datasets are not included in this GitHub-ready package by default.
- The Power BI report supplied with the project is included separately under `powerbi/`.

---

# 🚀 Future Enhancements

Potential extensions include:

- Automated data refresh pipelines
- Cloud database deployment
- Real-time booking monitoring
- Forecasting event revenue and attendance
- Event demand prediction
- Dynamic ticket-price optimization
- Weather-impact modelling
- Customer lifetime value analysis
- Automated anomaly detection
- Power BI Service deployment and scheduled refresh

---

# 👤 Author

**Ajeet Kumar**

Data Analytics / Data Science Portfolio Project

Skills demonstrated:

`Python` • `Pandas` • `NumPy` • `SQL` • `MySQL` • `Power BI` • `Data Cleaning` • `EDA` • `Data Visualization` • `Business Analytics`

---

## ⭐ Project Summary

This project demonstrates an end-to-end analytics workflow:

**Raw Data → Python Cleaning → MySQL → SQL Business Analysis → Power BI → Business Insights**

The final presentation will be created separately after the GitHub repository is finalized.

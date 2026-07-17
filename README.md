# 📊 Customer Analytics Dashboard

![Python](https://img.shields.io/badge/Python-3.x-blue)
![SQL](https://img.shields.io/badge/SQL-MySQL-orange)
![Pandas](https://img.shields.io/badge/Pandas-Data%20Analysis-darkblue)
![Plotly](https://img.shields.io/badge/Plotly-Visualization-purple)
![Streamlit](https://img.shields.io/badge/Streamlit-Dashboard-red)
![License](https://img.shields.io/badge/License-MIT-green)

An end-to-end **Customer Analytics** project built using **SQL, Python, Pandas, Plotly, and Streamlit** to analyze customer purchasing behavior, product performance, seller performance, payment trends, and regional sales insights using the Brazilian E-Commerce (Olist) dataset.

This project demonstrates a complete Data Analytics workflow—from raw transactional data to an interactive dashboard that supports data-driven business decisions.

---

# 📌 Project Overview

The objective of this project is to analyze customer purchasing patterns and business performance to uncover actionable insights for decision-makers.

The project focuses on:

- Customer purchasing behavior
- Revenue analysis
- Product performance
- Seller performance
- Payment preferences
- Geographical sales distribution
- Repeat customer analysis
- Interactive business dashboard

---

# 🎯 Business Problem

An e-commerce company wants to understand:

- Which customers generate the highest revenue?
- Which product categories perform best?
- Which sellers contribute the most sales?
- Which states generate the highest revenue?
- Which payment methods are preferred?
- How revenue changes throughout the year?
- Which customers make repeat purchases?

The objective is to transform raw transactional data into meaningful business insights that support strategic decision-making.

---

# 🛠️ Tech Stack

- **SQL (MySQL)** – Business Analysis
- **Python** – Data Cleaning & Analysis
- **Pandas** – Data Manipulation
- **Plotly** – Interactive Visualizations
- **Streamlit** – Dashboard Development
- **Git & GitHub** – Version Control

---

# 📂 Project Structure

```
Customer-Analytics-E-Commerce
│
├── app.py
├── requirements.txt
├── README.md
├── LICENSE
│
├── Data
│   └── customer_analytics_sample.csv
│
├── Images
│   ├── python_eda_dashboard.png
│   ├── streamlit_dashboard.png
│   ├── streamlit_dashboard (1).png
│   ├── streamlit_dashboard (2).png
│   └── streamlit_dashboard (3).png
│
├── Python
│   └── Customer_Analytics_EDA.ipynb
│
└── SQL
    └── Customer_Analytics_SQL.sql
```

---

# 🔄 Analytics Workflow

1. Import Dataset
2. Data Exploration
3. Data Quality Assessment
4. Data Cleaning
5. Data Integration
6. Feature Engineering
7. Exploratory Data Analysis (EDA)
8. SQL Business Analysis
9. Interactive Dashboard Development
10. Business Insights
11. Dashboard Deployment

---

# 📌 Business Questions Answered

- Which customer states generate the highest revenue?
- Which product categories contribute the most revenue?
- Who are the top-performing sellers?
- Who are the highest-value customers?
- Which payment methods are most frequently used?
- What are the monthly revenue trends?
- Which customers place repeat orders?
- Which product categories should the business prioritize?

---

# 📊 Dashboard Features

### 📈 Monthly Revenue Trend

Visualizes monthly revenue trends to identify seasonal sales patterns.

---

### 🛒 Product Category Analysis

Shows the highest revenue-generating product categories.

---

### 🌍 Customer State Analysis

Analyzes revenue distribution across customer states.

---

### 💳 Payment Method Distribution

Shows customer payment preferences using an interactive pie chart.

---

### 🏆 Top Sellers

Ranks sellers by total revenue generated.

---

### 👥 Top Customers

Identifies the highest-value customers.

---

### 🔄 Repeat Customers

Highlights customers with the highest purchase frequency.

---

# 📈 Key Performance Indicators (KPIs)

- 💰 Total Revenue
- 📦 Total Orders
- 👥 Total Customers
- 🛒 Average Order Value
- 📈 Monthly Revenue Trend
- 🛍️ Top Product Categories
- 🌎 Customer State Revenue
- 💳 Payment Distribution
- 🏆 Top Sellers
- 👤 Top Customers

---

# 🎯 Skills Demonstrated

### SQL

- Joins
- Aggregate Functions
- GROUP BY
- ORDER BY
- Window Functions
- Common Table Expressions (CTEs)
- Business Query Writing

### Python

- Pandas
- Data Cleaning
- Feature Engineering
- Data Manipulation
- Exploratory Data Analysis

### Data Visualization

- Plotly
- Streamlit Dashboard
- Business KPI Design

### Business Analytics

- Customer Analytics
- Revenue Analysis
- Product Performance
- Seller Performance
- Payment Analysis
- Business Storytelling

---

# 🖥️ Dashboard Preview

## Python EDA Dashboard

![Python Dashboard](Images/python_eda_dashboard.png)

---

## Streamlit Dashboard

![Dashboard](Images/streamlit_dashboard%20(1).png)

![Dashboard](Images/streamlit_dashboard%20(2).png)

![Dashboard](Images/streamlit_dashboard%20(3).png)

---

# 🌐 Live Dashboard

👉 [https://your-dashboard.streamlit.app](https://customer-analytics-e-commerce-mowds66gb2blbhitnu5pva.streamlit.app/)

---

# 📂 Dataset

This project is based on the **Brazilian E-Commerce Public Dataset by Olist**.

The original dataset is not included in this repository because it exceeds GitHub's file size limit.

A sample dataset is included for demonstration purposes.

---

# 💡 Business Insights

- Revenue follows a clear seasonal trend, reaching its highest level around May and remaining relatively strong through August before declining sharply in September.

- A small number of product categories contribute a significant share of total revenue, with **cama_mesa_banho**, **beleza_saude**, and **informatica_acessorios** leading sales.

- Customer purchases are highly concentrated geographically, with **São Paulo (SP)** generating substantially more revenue than any other state, followed by Rio de Janeiro (RJ) and Minas Gerais (MG).

- **Credit Card** is the preferred payment method, accounting for approximately **74%** of all transactions, indicating a strong customer preference for card-based payments.

- Revenue is concentrated among a relatively small number of sellers, suggesting that top-performing sellers have a significant impact on overall business performance.

- A limited number of customers contribute a disproportionately high share of total revenue, highlighting the importance of customer retention and loyalty strategies.

- The repeat customer analysis indicates that most customers purchase only a few times, suggesting an opportunity to improve repeat purchases through personalized marketing, loyalty programs, and targeted promotions.

- The interactive dashboard enables users to dynamically filter customer states, payment methods, and product categories, allowing business stakeholders to explore sales performance across different dimensions in real time.

---

# ⭐ Business Story (STAR Method)

## Situation

An e-commerce company wanted to better understand customer purchasing behavior, sales performance, payment preferences, and regional demand. Business stakeholders needed a centralized dashboard to monitor key performance indicators and identify revenue-driving customers, sellers, and product categories.

---

## Task

Develop an end-to-end Customer Analytics solution capable of:

- Cleaning and preparing transactional data
- Performing SQL-based business analysis
- Conducting exploratory data analysis using Python
- Building an interactive Streamlit dashboard
- Presenting actionable business insights for decision-makers

---

## Action

- Cleaned and transformed multiple e-commerce datasets using **Python (Pandas)**.
- Performed business analysis using **MySQL**, including customer, seller, product, revenue, payment, and order analysis.
- Engineered additional features to support reporting and visualization.
- Created interactive visualizations using **Plotly**.
- Built a responsive **Streamlit Dashboard** with sidebar filters for customer state, payment method, and product category.
- Designed KPI cards, revenue trends, product performance, seller rankings, customer analysis, and business insight sections for decision-makers.

---

## Result

The final dashboard provides a centralized view of business performance, enabling stakeholders to:

- Monitor monthly revenue trends.
- Identify top-performing product categories.
- Analyze regional sales performance.
- Understand customer payment preferences.
- Track top sellers and high-value customers.
- Explore repeat customer behavior.
- Filter business metrics interactively for faster decision-making.

The project demonstrates a complete end-to-end Customer Analytics workflow using SQL, Python, Plotly, and Streamlit while showcasing practical business intelligence and dashboard development skills.

---

# 🚀 Future Improvements

- Customer Lifetime Value (CLV)
- RFM Customer Segmentation
- Customer Churn Prediction
- Sales Forecasting
- Product Recommendation System
- Profitability Analysis
- Real-Time Data Integration

---

# 🌐 Live Dashboard

> **Coming Soon** *(Will be updated after deployment on Streamlit Community Cloud.)*

---

# 👨‍💻 Author

**Sameer Sharma**

**Aspiring Data Analyst**

### Skills

- SQL
- Python
- Excel
- Power BI
- Streamlit
- Git
- GitHub

---

# ⭐ Project Summary

This project showcases a complete end-to-end Customer Analytics workflow using industry-standard data analytics tools.

Starting from raw transactional data, the project performs SQL-based business analysis, Python data preprocessing, exploratory data analysis, interactive dashboard development, and business storytelling to generate actionable insights for decision-makers.

The project highlights practical skills expected from an entry-level Data Analyst, including SQL querying, data cleaning, data visualization, dashboard development, and business insight generation.

---

## ⭐ If you found this project helpful, consider giving it a Star!

# ==========================================
# CUSTOMER ANALYTICS DASHBOARD
# ==========================================


import streamlit as st
import pandas as pd
import plotly.express as px

st.set_page_config(page_title="Customer Analytics Dashboard", page_icon="📊", layout="wide")

@st.cache_data
def load_data():
    df = pd.read_csv("customer_analytics_master.csv")
    if "order_purchase_timestamp" in df.columns:
        df["order_purchase_timestamp"] = pd.to_datetime(df["order_purchase_timestamp"], errors="coerce")
    return df

df = load_data()

st.title("📊 Customer Analytics Dashboard")
st.markdown("Interactive Customer Analytics Dashboard built with **Python**, **Pandas**, **Plotly** and **Streamlit**.")
st.divider()

# Sidebar filters
st.sidebar.header("Filters")

filtered = df.copy()

if "customer_state" in df.columns:
    states = sorted(df["customer_state"].dropna().unique())
    sel_states = st.sidebar.multiselect("Customer State", states, default=states)
    filtered = filtered[filtered["customer_state"].isin(sel_states)]

if "payment_type" in df.columns:
    pays = sorted(df["payment_type"].dropna().unique())
    sel_pay = st.sidebar.multiselect("Payment Type", pays, default=pays)
    filtered = filtered[filtered["payment_type"].isin(sel_pay)]

if "product_category_name" in df.columns:
    cats = sorted(filtered["product_category_name"].fillna("Unknown").unique())
    sel_cat = st.sidebar.multiselect("Product Category", cats, default=cats)
    filtered = filtered[filtered["product_category_name"].fillna("Unknown").isin(sel_cat)]

# KPIs
revenue_col = "payment_value" if "payment_value" in filtered.columns else "Total_Order_Value"

total_revenue = filtered[revenue_col].sum()
orders = filtered["order_id"].nunique() if "order_id" in filtered.columns else len(filtered)
customers = filtered["customer_unique_id"].nunique() if "customer_unique_id" in filtered.columns else 0
avg_order = total_revenue / orders if orders else 0

c1,c2,c3,c4 = st.columns(4)
c1.metric("💰 Revenue", f"${total_revenue:,.0f}")
c2.metric("📦 Orders", f"{orders:,}")
c3.metric("👥 Customers", f"{customers:,}")
c4.metric("🛒 Avg Order", f"${avg_order:,.2f}")

st.divider()

left,right = st.columns(2)

with left:
    if "Month_Name" in filtered.columns:
        order = ["January","February","March","April","May","June","July","August","September","October","November","December"]
        m = filtered.groupby("Month_Name",as_index=False)[revenue_col].sum()
        m["Month_Name"] = pd.Categorical(m["Month_Name"], categories=order, ordered=True)
        m = m.sort_values("Month_Name")
        fig = px.line(m,x="Month_Name",y=revenue_col,markers=True,title="Monthly Revenue Trend")
        st.plotly_chart(fig,use_container_width=True)

    if "customer_state" in filtered.columns:
        s = filtered.groupby("customer_state",as_index=False)[revenue_col].sum().sort_values(revenue_col,ascending=False).head(10)
        fig = px.bar(s,x="customer_state",y=revenue_col,title="Top Customer States")
        st.plotly_chart(fig,use_container_width=True)

with right:
    if "product_category_name" in filtered.columns:
        p = filtered.groupby("product_category_name",as_index=False)[revenue_col].sum().sort_values(revenue_col,ascending=False).head(10)
        fig = px.bar(p,x="product_category_name",y=revenue_col,title="Top Product Categories")
        st.plotly_chart(fig,use_container_width=True)

    if "payment_type" in filtered.columns:
        pay = filtered["payment_type"].value_counts().reset_index()
        pay.columns=["Payment Type","Count"]
        fig = px.pie(pay,names="Payment Type",values="Count",title="Payment Method Distribution")
        st.plotly_chart(fig,use_container_width=True)

st.divider()

c5,c6 = st.columns(2)

with c5:
    if "seller_id" in filtered.columns:
        sellers = filtered.groupby("seller_id",as_index=False)[revenue_col].sum().sort_values(revenue_col,ascending=False).head(10)
        sellers["Seller"]=[f"Seller {i+1}" for i in range(len(sellers))]
        fig = px.bar(sellers,x="Seller",y=revenue_col,title="Top Sellers")
        st.plotly_chart(fig,use_container_width=True)

with c6:
    if "customer_unique_id" in filtered.columns:
        cust = filtered.groupby("customer_unique_id",as_index=False)[revenue_col].sum().sort_values(revenue_col,ascending=False).head(10)
        cust["Customer"]=[f"Customer {i+1}" for i in range(len(cust))]
        fig = px.bar(cust,x="Customer",y=revenue_col,title="Top Customers")
        st.plotly_chart(fig,use_container_width=True)

st.divider()
st.subheader("Business Insights")

top_state = filtered.groupby("customer_state")[revenue_col].sum().idxmax() if "customer_state" in filtered.columns and not filtered.empty else "N/A"
top_cat = filtered.groupby("product_category_name")[revenue_col].sum().idxmax() if "product_category_name" in filtered.columns and not filtered.empty else "N/A"
top_pay = filtered["payment_type"].mode().iloc[0] if "payment_type" in filtered.columns and not filtered.empty else "N/A"

st.markdown(f"""
- **Total Revenue:** ${total_revenue:,.0f}
- **Top Customer State:** {top_state}
- **Top Product Category:** {top_cat}
- **Most Used Payment Method:** {top_pay}
- Dashboard updates dynamically based on sidebar filters.
""")

st.divider()
st.caption("Developed by Sameer Sharma | Customer Analytics Dashboard")

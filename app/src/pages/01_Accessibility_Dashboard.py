import logging
logger = logging.getLogger(__name__)
import requests
import pandas as pd
import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

st.header('Accessibility Dashboard')
st.write(f"### Hi, {st.session_state['first_name']}.")

API_BASE = "http://web-api:4000"


@st.cache_data(ttl=60)
def fetch_reports():
    try:
        r = requests.get(f"{API_BASE}/reports", timeout=5)
        r.raise_for_status()
        return pd.DataFrame(r.json())
    except Exception as e:
        logger.error(f"Failed to fetch reports: {e}")
        return None


df = fetch_reports()

if df is None or df.empty:
    st.error("Could not load report data. Please ensure the API server is running.")
    st.stop()

# --- Summary metrics ---
total = len(df)
open_count = df[df['report_status'].isin(['Open', 'In Progress'])].shape[0]
resolved_count = df[df['report_status'].isin(['Resolved', 'Closed'])].shape[0]
high_priority_count = df[df['urgency'] >= 4].shape[0] if 'urgency' in df.columns else 0
resolution_rate = (resolved_count / total * 100) if total > 0 else 0.0

col1, col2, col3, col4 = st.columns(4)
col1.metric("Open Reports", open_count)
col2.metric("Resolved Reports", resolved_count)
col3.metric("High Priority Reports", high_priority_count)
col4.metric("Resolution Rate", f"{resolution_rate:.1f}%")

st.divider()

# --- Reports table ---
st.subheader("All Reports")

col_map = {
    'report_id': 'ID',
    'issue_type_name': 'Issue Type',
    'neighborhood_name': 'Neighborhood',
    'report_date': 'Date',
    'urgency': 'Priority',
    'report_status': 'Status',
}

available = [c for c in col_map if c in df.columns]
table_df = df[available].rename(columns=col_map)

st.dataframe(table_df, use_container_width=True, hide_index=True)

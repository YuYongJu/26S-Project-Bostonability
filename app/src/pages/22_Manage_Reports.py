import logging
logger = logging.getLogger(__name__)

import requests
import json
import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(page_title="Manage Reports | Bostonability", layout="wide")
SideBarLinks()

st.markdown("## Manage Reports / Statistics")
st.caption("Review, edit, resolve, export, or delete reports. Monitor system health statistics.")

API_BASE = "http://web-api:4000"
STATUSES = ["Open", "In Progress", "Resolved", "Closed"]


def fetch_reports():
    r = requests.get(f"{API_BASE}/reports", timeout=10)
    r.raise_for_status()
    return r.json()


def fetch_stats():
    try:
        r = requests.get(f"{API_BASE}/analytics/resolution-summary", timeout=10)
        r.raise_for_status()
        return r.json()
    except Exception:
        return []


try:
    reports = fetch_reports()
except Exception as e:
    st.error("Cannot reach API.")
    st.code(str(e))
    st.stop()

search = st.text_input("Search or Filter Reports",
                       placeholder="Report ID, neighborhood, issue type, description")

rep_col, stat_col = st.columns([3, 2])

with stat_col:
    st.markdown("#### Report Statistics")
    try:
        stats = fetch_stats()
        if stats:
            total_tickets    = sum(s.get("ticket_count", 0) for s in stats)
            open_tickets     = next((s["ticket_count"] for s in stats
                                     if s.get("ticket_status") == "open"), 0)
            resolved_tickets = next((s["ticket_count"] for s in stats
                                     if s.get("ticket_status") == "resolved"), 0)
            bug_reports      = next((s["ticket_count"] for s in stats
                                     if s.get("ticket_status") == "bug"), 0)
            st.metric("Open Reports", open_tickets)
            st.metric("Resolved (this month)", resolved_tickets)
            st.metric("Application Bug Reports", bug_reports)
            st.metric("Total Tickets", total_tickets)
        else:
            open_c     = sum(1 for r in reports if r.get("report_status") in ["Open", "In Progress"])
            resolved_c = sum(1 for r in reports if r.get("report_status") in ["Resolved", "Closed"])
            st.metric("Total Reports", len(reports))
            st.metric("Open / In Progress", open_c)
            st.metric("Resolved / Closed", resolved_c)
    except Exception:
        st.info("Statistics unavailable.")

with rep_col:
    st.markdown("#### Reports")

    filtered = reports
    if search.strip():
        q = search.strip().lower()
        filtered = [
            r for r in filtered
            if q in str(r.get("report_id", "")).lower()
            or q in str(r.get("neighborhood_name", "")).lower()
            or q in str(r.get("issue_type_name", "")).lower()
            or q in str(r.get("description", "")).lower()
            or q in str(r.get("report_status", "")).lower()
        ]

    st.caption(f"{len(filtered)} report{'s' if len(filtered) != 1 else ''}")

    for rep in filtered:
        rid    = rep.get("report_id")
        status = rep.get("report_status", "Open")
        issue  = rep.get("issue_type_name", "Unknown")
        hood   = rep.get("neighborhood_name", "")
        rdate  = str(rep.get("report_date", ""))[:10]
        uid    = rep.get("user_id", "?")
        desc   = rep.get("description", "")

        header = f"Report {rid} - {issue}"
        if hood:
            header += f" | {hood}"

        with st.expander(header):
            st.markdown("**Information**")
            st.write(f"Report ID: {rid}")
            st.write(f"Location: {hood}")
            st.write(f"Date Reported: {rdate}")
            st.write(f"User: {uid}")
            st.write(f"Status: {status}")
            if desc:
                st.markdown("**Issue Description**")
                st.write(desc)

            st.markdown("**Options**")
            opt1, opt2, opt3, opt4 = st.tabs(["Edit Ticket", "Ticket Resolved", "Export Ticket", "Delete Ticket"])

            with opt1:
                with st.form(f"edit_rep_{rid}"):
                    new_status = st.selectbox("Status", STATUSES,
                                              index=STATUSES.index(status) if status in STATUSES else 0,
                                              key=f"rs_{rid}")
                    new_desc = st.text_area("Description", value=desc, height=80, key=f"rd_{rid}")
                    new_urg  = st.slider("Urgency", 1, 5,
                                         value=int(rep.get("urgency", 3)), key=f"ru_{rid}")
                    save = st.form_submit_button("Save", type="primary")

                if save:
                    try:
                        r = requests.put(f"{API_BASE}/reports/{rid}",
                                         json={"report_status": new_status,
                                               "description": new_desc,
                                               "urgency": new_urg}, timeout=10)
                        r.raise_for_status()
                        st.success("Report updated!")
                        st.rerun()
                    except Exception as e:
                        st.error(f"Update failed: {e}")

            with opt2:
                st.write("Mark this report as resolved.")
                if st.button("Mark Resolved", key=f"res_{rid}", type="primary"):
                    try:
                        r = requests.put(f"{API_BASE}/reports/{rid}",
                                         json={"report_status": "Resolved"}, timeout=10)
                        r.raise_for_status()
                        st.success("Marked as resolved!")
                        st.rerun()
                    except Exception as e:
                        st.error(f"Failed: {e}")

            with opt3:
                st.write("Export this report as JSON.")
                export_data = {k: str(v) for k, v in rep.items()}
                st.download_button(
                    "Download JSON",
                    data=json.dumps(export_data, indent=2),
                    file_name=f"report_{rid}.json",
                    mime="application/json",
                    key=f"exp_{rid}",
                )

            with opt4:
                st.warning("This permanently deletes the report.")
                if st.button(f"Delete Report {rid}", key=f"del_{rid}"):
                    try:
                        r = requests.delete(f"{API_BASE}/reports/{rid}", timeout=10)
                        r.raise_for_status()
                        st.success(f"Report {rid} deleted.")
                        st.rerun()
                    except Exception as e:
                        st.error(f"Delete failed: {e}")

st.divider()
st.markdown("#### Quick Navigation")
qn1, qn2, qn3 = st.columns(3)
with qn1:
    if st.button("Manage Users", use_container_width=True, key="nav_users"):
        st.switch_page("pages/21_Manage_Users.py")
with qn2:
    if st.button("Accessibility Info", use_container_width=True, key="nav_acc"):
        st.switch_page("pages/24_Admin_Accessibility_Info.py")
with qn3:
    if st.button("Manage Tickets", use_container_width=True, key="nav_tickets"):
        st.switch_page("pages/23_Manage_Tickets.py")

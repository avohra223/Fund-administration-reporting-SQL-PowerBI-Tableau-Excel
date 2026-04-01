"""
Excel-to-SQLite loader and query helpers.
Reads private_markets_raw_data_March2026.xlsx into a SQLite database,
then provides helper functions for SQL queries and pandas operations.
"""

import sqlite3
import os
import pandas as pd

# Data file lives at repo root; DB is generated in streamlit/ folder
STREAMLIT_DIR = os.path.dirname(os.path.dirname(__file__))
REPO_ROOT = os.path.dirname(STREAMLIT_DIR)
EXCEL_PATH = os.path.join(REPO_ROOT, "private_markets_raw_data_March2026.xlsx")
DB_PATH = os.path.join(STREAMLIT_DIR, "fund_admin.db")

SHEETS = [
    "Funds",
    "Investors",
    "Commitments",
    "FX_Rates",
    "Transactions",
    "NAV_Quarterly",
    "Benchmarks",
    "Fund_Performance_Metrics",
    "Performance_vs_Benchmark",
]


def init_db():
    """Load all Excel sheets into SQLite. Skips if DB already exists."""
    if os.path.exists(DB_PATH):
        return
    conn = sqlite3.connect(DB_PATH)
    xls = pd.ExcelFile(EXCEL_PATH)
    for sheet in SHEETS:
        df = pd.read_excel(xls, sheet)
        for col in df.columns:
            if pd.api.types.is_datetime64_any_dtype(df[col]):
                df[col] = df[col].dt.strftime("%Y-%m-%d")
        df.to_sql(sheet, conn, if_exists="replace", index=False)
    conn.close()


def get_connection():
    """Return a sqlite3 connection. Initializes DB if needed."""
    init_db()
    return sqlite3.connect(DB_PATH)


def query_df(sql: str, params=None) -> pd.DataFrame:
    """Run a SQL query and return a pandas DataFrame."""
    conn = get_connection()
    df = pd.read_sql_query(sql, conn, params=params)
    conn.close()
    return df


def load_sheet(sheet_name: str) -> pd.DataFrame:
    """Load a sheet directly from Excel via pandas (no SQL)."""
    return pd.read_excel(EXCEL_PATH, sheet_name=sheet_name)

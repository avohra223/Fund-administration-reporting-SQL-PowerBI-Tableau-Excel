-- Query 15: Quarterly Reporting Pack
-- Business question: What is the complete fund health snapshot for the most recent quarter?
-- Combines NAV, capital activity, and performance in one view

WITH Latest_NAV AS (
    SELECT Fund_ID, 
        MAX(Quarter_End_Date) AS Latest_Quarter
    FROM NAV_Quarterly
    GROUP BY Fund_ID
),
Called AS (
    SELECT Fund_ID, SUM(Amount_Fund_Base) AS Total_Called
    FROM Transactions
    WHERE Txn_Type = 'Capital Call'
    GROUP BY Fund_ID
),
Distributed AS (
    SELECT Fund_ID, SUM(Amount_Fund_Base) AS Total_Distributed
    FROM Transactions
    WHERE Txn_Type = 'Distribution'
    GROUP BY Fund_ID
)
SELECT
    Funds.Fund_Name,
    Funds.Strategy,
    Funds.Fund_Size,
    Latest_NAV.Latest_Quarter AS Reporting_Date,
    NAV_Quarterly.Net_NAV_Fund_Base AS Current_Net_NAV,
    Called.Total_Called,
    COALESCE(Distributed.Total_Distributed, 0) AS Total_Distributed,
    Called.Total_Called - COALESCE(Distributed.Total_Distributed, 0) AS Net_Invested,
    ROUND(Called.Total_Called * 100.0 / Funds.Fund_Size, 2) AS Pct_Deployed,
    ROUND(COALESCE(Distributed.Total_Distributed, 0) * 1.0 / Called.Total_Called, 4) AS DPI,
    ROUND(NAV_Quarterly.Net_NAV_Fund_Base * 1.0 / Called.Total_Called, 4) AS RVPI
FROM Funds
JOIN Latest_NAV ON Funds.Fund_ID = Latest_NAV.Fund_ID
JOIN NAV_Quarterly ON NAV_Quarterly.Fund_ID = Latest_NAV.Fund_ID 
    AND NAV_Quarterly.Quarter_End_Date = Latest_NAV.Latest_Quarter
JOIN Called ON Funds.Fund_ID = Called.Fund_ID
LEFT JOIN Distributed ON Funds.Fund_ID = Distributed.Fund_ID
ORDER BY Funds.Fund_Size DESC;

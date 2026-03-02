-- Query 9: LP Statement by Investor
-- Business question: What is each investor's complete financial position across all funds?

WITH Committed AS (
    SELECT Investor_ID, SUM(Commitment_Amount) AS Total_Committed
    FROM Commitments
    GROUP BY Investor_ID
),
Called AS (
    SELECT Investor_ID, SUM(Amount_Fund_Base) AS Total_Called
    FROM Transactions
    WHERE Txn_Type = 'Capital Call'
    GROUP BY Investor_ID
),
Distributed AS (
    SELECT Investor_ID, SUM(Amount_Fund_Base) AS Total_Distributed
    FROM Transactions
    WHERE Txn_Type = 'Distribution'
    GROUP BY Investor_ID
)
SELECT
    Investors.Investor_Name,
    Investors.Investor_Type,
    Committed.Total_Committed,
    COALESCE(Called.Total_Called, 0) AS Total_Called,
    COALESCE(Distributed.Total_Distributed, 0) AS Total_Distributed,
    Committed.Total_Committed - COALESCE(Called.Total_Called, 0) AS Unfunded_Commitment,
    COALESCE(Distributed.Total_Distributed, 0) - COALESCE(Called.Total_Called, 0) AS Net_Position
FROM Investors
JOIN Committed ON Investors.Investor_ID = Committed.Investor_ID
LEFT JOIN Called ON Investors.Investor_ID = Called.Investor_ID
LEFT JOIN Distributed ON Investors.Investor_ID = Distributed.Investor_ID
ORDER BY Total_Committed DESC;

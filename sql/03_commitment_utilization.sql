-- Query 3: Commitment Utilization by LP
-- Business question: What percentage of each LP's commitment has been called so far?

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
)
SELECT
    Investors.Investor_Name,
    Committed.Total_Committ

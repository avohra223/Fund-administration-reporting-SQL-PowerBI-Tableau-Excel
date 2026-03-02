-- Query 5: Distributions by Fund
-- Business question: How much has been returned to investors per fund, and what % of fund size does that represent?

SELECT
    Funds.Fund_Name,
    Funds.Strategy,
    Funds.Fund_Size,
    COUNT(Transactions.Txn_ID) AS Number_Of_Distributions,
    SUM(Transactions.Amount_Fund_Base) AS Total_Distributed,
    ROUND(SUM(Transactions.Amount_Fund_Base) * 100.0 / Funds.Fund_Size, 2) AS Pct_Of_Fund_Size
FROM Funds
JOIN Transactions ON Funds.Fund_ID = Transactions.Fund_ID
WHERE Transactions.Txn_Type = 'Distribution'
GROUP BY Funds.Fund_Name, Funds.Strategy, Funds.Fund_Size
ORDER BY Total_Distributed DESC;

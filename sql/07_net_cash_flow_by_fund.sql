-- Query 7: Net Cash Flow by Fund
-- Business question: What is the net cash position per fund (capital called vs distributions returned)?

SELECT
    Funds.Fund_Name,
    Funds.Strategy,
    SUM(CASE WHEN Transactions.Txn_Type = 'Capital Call' 
        THEN Transactions.Amount_Fund_Base ELSE 0 END) AS Total_Called,
    SUM(CASE WHEN Transactions.Txn_Type = 'Distribution' 
        THEN Transactions.Amount_Fund_Base ELSE 0 END) AS Total_Distributed,
    SUM(CASE WHEN Transactions.Txn_Type = 'Capital Call' 
        THEN Transactions.Amount_Fund_Base ELSE 0 END) -
    SUM(CASE WHEN Transactions.Txn_Type = 'Distribution' 
        THEN Transactions.Amount_Fund_Base ELSE 0 END) AS Net_Cash_Flow
FROM Funds
JOIN Transactions ON Funds.Fund_ID = Transactions.Fund_ID
GROUP BY Funds.Fund_Name, Funds.Strategy
ORDER BY Net_Cash_Flow DESC;

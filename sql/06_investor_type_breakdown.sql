-- Query 6: Investor Breakdown by Type
-- Business question: What is our LP base composition and how much has each investor type committed?

SELECT
    Investors.Investor_Type,
    COUNT(Investors.Investor_ID) AS Number_Of_Investors,
    SUM(Commitments.Commitment_Amount) AS Total_Committed
FROM Investors
JOIN Commitments ON Investors.Investor_ID = Commitments.Investor_ID
GROUP BY Investors.Investor_Type
ORDER BY Total_Committed DESC;

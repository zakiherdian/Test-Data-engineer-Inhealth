SELECT TOP 5
    b.store_Location AS city,
    SUM(a.item_quantity) AS total_item_terjual
FROM Fact.Fact_Transactions a
JOIN dimension.Dim_Store b 
    ON a.store_fk = b.store_ID
GROUP BY 
    b.store_Location
ORDER BY 
    SUM(a.item_quantity) DESC;
--  order by SUM(a.item_quantity)
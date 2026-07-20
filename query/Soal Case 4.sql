SELECT TOP 5
    b.store_name AS store,
    SUM(a.item_quantity) AS total_item_terjual_bulan_januari_semua_tahun
FROM Fact.Fact_Transactions a
JOIN dimension.Dim_Store b 
    ON a.store_fk = b.store_ID
WHERE 
    MONTH(a.trx_date) = 1   -- hanya bulan Januari (semua tahun)
GROUP BY 
    b.store_ID,
    b.store_name
ORDER BY 
    total_item_terjual_bulan_januari_semua_tahun DESC;-- urutkan dari yang terbesar
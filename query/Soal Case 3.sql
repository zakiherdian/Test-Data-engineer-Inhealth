WITH top5 AS (
    SELECT TOP 5
        c.product_name AS [Product],
        SUM(a.item_quantity) AS total_item_terjual --jumlah total item
    FROM Fact.Fact_Transactions a
    JOIN dimension.Dim_Customer b 
        ON a.customer_fk = b.Customer_ID
    JOIN dimension.Dim_Product c 
        ON a.produk_fk = c.product_id 
    JOIN dimension.Dim_Gender d on b.Gender_fk =d.gender_id
    WHERE 
        d.gender='male'-- filter hanya yang laki laki
    GROUP BY 
        c.product_id,
        c.product_name
    ORDER BY 
        total_item_terjual DESC  -- ambil 5 terbesar dulu
)

SELECT *
FROM top5
ORDER BY total_item_terjual ASC;  -- urukan dari yang terkecil
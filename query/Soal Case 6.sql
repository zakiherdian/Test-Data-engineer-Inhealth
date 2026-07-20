WITH customer_spending AS (
   --grouping total pengeluaran
   SELECT
        b.Customer_ID,
        CONCAT(b.First_Name, ' ', b.Last_Name) AS nama_lengkap,
        SUM(a.item_price) AS total_pengeluaran
    FROM Fact.Fact_Transactions a
    JOIN dimension.Dim_Customer b 
        ON a.customer_fk = b.Customer_ID
    GROUP BY 
        b.Customer_ID,
        b.First_Name,
        b.Last_Name
),

top5 AS (
--cari 5 yang terbesar
    SELECT TOP 5 *
    FROM customer_spending
    ORDER BY total_pengeluaran DESC
)

SELECT 
    t.nama_lengkap,
  

    --list  Produk unik
    (
        SELECT STRING_AGG(p2.product_name, ', ') -- menggabungkan produk menjadi  1 kolom
        FROM (
            SELECT DISTINCT p.product_name
            FROM Fact.Fact_Transactions f
            JOIN dimension.Dim_Product p 
                ON f.produk_fk = p.product_id
            WHERE f.customer_fk = t.Customer_ID
        ) p2
    ) AS list_uniq_produk,

    -- list Store unik
    (
        SELECT STRING_AGG(s2.store_Location, ', ') --menggabungkan store menjadi  1 kolom
        FROM (
            SELECT DISTINCT s.store_Location
            FROM Fact.Fact_Transactions f
            JOIN dimension.Dim_Store s 
                ON f.store_fk = s.store_ID
            WHERE f.customer_fk = t.Customer_ID
        ) s2
    ) AS list_uniq_store,
      t.total_pengeluaran

FROM top5 t
ORDER BY t.total_pengeluaran DESC;
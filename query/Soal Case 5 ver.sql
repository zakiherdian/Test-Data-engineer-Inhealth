WITH kota_rank AS (
    -- Ranking kota berdasarkan total penjualan ke perempuan
    SELECT
        s.store_Location AS city,
        SUM(f.item_quantity) AS total_item,
        ROW_NUMBER() OVER (ORDER BY SUM(f.item_quantity) DESC) AS rn
    FROM Fact.Fact_Transactions f
    JOIN dimension.Dim_Store s 
        ON f.store_fk = s.store_ID
    JOIN dimension.Dim_Customer c 
        ON f.customer_fk = c.Customer_ID
    JOIN dimension.Dim_Gender d 
        ON c.Gender_fk = d.gender_id
    WHERE 
        d.gender = 'Female'
    GROUP BY 
        s.store_Location
),

customer_rank AS (
    -- Ranking customer .gov di kota terbaik
    SELECT
        c.email,
        s.store_Location AS city,
        SUM(f.item_quantity* f.item_price) AS total_pembelian,
        ROW_NUMBER() OVER (
            ORDER BY SUM(f.item_quantity* f.item_price) DESC
        ) AS rn
    FROM Fact.Fact_Transactions f
    JOIN dimension.Dim_Customer c 
        ON f.customer_fk = c.Customer_ID
    JOIN dimension.Dim_Store s 
        ON f.store_fk = s.store_ID
    JOIN kota_rank kr
        ON s.store_Location = kr.city
    WHERE 
        kr.rn < 3                    -- hanya kota terbaik jika kurang tambahkan valuenya
        AND c.email LIKE '%.gov'      -- email pemerintah
    GROUP BY 
        c.email,
        s.store_Location
)

-- Ambil Top 5 customer
SELECT
    email,
    city,
    total_pembelian
FROM customer_rank
WHERE rn <= 5
ORDER BY total_pembelian DESC;
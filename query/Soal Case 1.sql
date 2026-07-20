SELECT top 5 -- ambil 5 terbanyak
    CONCAT(b.First_Name, ' ', b.Last_Name) AS nama_lengkap_customer, -- concat menggabungkan string first name dan lastname
    SUM(a.item_price*a.item_quantity) AS pengeluaran --menjumlahkan total pengeluaran
FROM Fact.Fact_Transactions a
JOIN dimension.Dim_Customer b 
    ON a.customer_fk = b.Customer_ID

GROUP BY 
    b.Customer_ID,
    b.First_Name, 
    b.Last_Name
     order by SUM(a.item_price)desc
  
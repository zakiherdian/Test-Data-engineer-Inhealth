SELECT
    transaction_id,
    customer_id,
    product_id,
    store_id,
    qty,
    CAST(REPLACE(amount, '$', '') AS DECIMAL(18,2)) AS amount,
    transaction_date
 FROM stagging.Stg_Transactions_json 
CROSS APPLY OPENJSON(JsonData)
WITH
(
    transaction_id Nvarchar(max) '$.trx_id',
    customer_id INT '$.customer_fk',
    product_id INT '$.produk_fk',
    store_id INT '$.store_fk',
    qty INT '$.item_quantity',
    amount VARCHAR(20) '$.item_price',
    transaction_date DATE '$.trx_date'
);
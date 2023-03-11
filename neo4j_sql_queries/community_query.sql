
WITH table1 AS (
        SELECT * -- List of all npis in nashville with zip to cbsa info
        FROM zip_to_cbsa AS zip
        INNER JOIN npidata AS npi
        ON zip.zip = npi.location_address_postal_code
        WHERE city = 'NASHVILLE' AND state = 'TN'
),
table2 AS (
        SELECT from_npi, 
                to_npi,
                zip AS from_zip,
                cbsa AS from_cbsa,
                patient_count,
                transaction_count,
                average_day_wait,
                std_day_wait
        FROM table1 as t
        INNER JOIN hop AS h
        ON t.npi = h.from_npi
)

SELECT t2.*, npi.location_address_postal_code AS to_zip 
FROM table2 AS t2
LEFT JOIN npidata AS npi
ON t2.to_npi = npi.npi
WHERE transaction_count >= 50
AND average_day_wait < 50
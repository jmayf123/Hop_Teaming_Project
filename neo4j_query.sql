
SELECT from_npi,
       to_npi,
       transaction_count
FROM hop
INNER JOIN npidata AS a
ON from_npi = a.npi
INNER JOIN npidata AS b
ON to_npi = b.npi
INNER JOIN zip_to_cbsa AS az
ON a.location_address_postal_code = az.zip
INNER JOIN zip_to_cbsa AS bz
ON b.location_address_postal_code = bz.zip
WHERE transaction_count >= 50
AND average_day_wait < 50
AND az.cbsa = 34980
AND bz.cbsa = 34980

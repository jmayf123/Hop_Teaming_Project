-- This will produce a list of npis for major hospitals in nashville only

WITH hospital_codes AS (
        SELECT taxonomy_code
        FROM taxonomy
        WHERE display_name = 'General Acute Care Hospital'
        
),

npis_nashville AS (
        SELECT CAST(npi AS int) AS npi, last_name, first_name, organization_name
        FROM npidata AS n
        WHERE taxonomy_code IN hospital_codes 
              AND location_address_city_name LIKE 'NASHVILLE'
              AND location_address_state_name LIKE 'TN'
)      

-- List of the provider npis that are referring patients to the major hosptials in Nashville
SELECT from_npi, last_name, first_name, organization_name
FROM hop AS h
INNER JOIN npis_nashville AS n
ON h.to_npi = n.npi
-- First, build a profile of providers referring patients to the major hospitals in Nashville. Are certain specialties more likely to refer to a particular hospital over the others?


-- This will produce a list of npis for major hospitals in nashville only

WITH hospital_codes AS (
        SELECT taxonomy_code
        FROM taxonomy
        WHERE display_name = 'General Acute Care Hospital'
        
),

npis_nashville AS (
        SELECT CAST(npi AS int) AS npi,  
               organization_name AS referred_to_org
        FROM npidata AS n
        WHERE taxonomy_code IN hospital_codes 
              AND location_address_city_name LIKE 'NASHVILLE'
              AND location_address_state_name LIKE 'TN'
)    

-- List of the provider npis that are referring patients to the major hosptials in Nashville
       
SELECT *
FROM hop AS h
INNER JOIN npis_nashville AS n
ON h.to_npi = n.npi

/*
SELECT from_npi, 
        to_npi, 
        patient_count, 
        transaction_count,
        average_day_wait,
        std_day_wait,
        referred_to_org
FROM table1 AS t 
INNER JOIN npidata AS n
ON t.from_npi = n.npi
*/
--Build Profile for providers referring patients to major hospitals in Nashville.
--Are certain specialties more likely to refer to particular hospital over others?

SELECT n.provider_business_practice_location_address_city_name AS city, 
       n.provider_business_practice_location_address_state_name AS state,
       n.provider_business_practice_location_address_postal_code AS zipcode,
       "provider_organization_name_(legal_business_name)" AS display_name,
       --column(provider_organization_name_(legal_business_name)),
       t.classification
FROM npi n
LEFT JOIN taxonomy t
USING(taxonomy_code)
WHERE entity_type_code = 2 
        AND provider_business_practice_location_address_city_name = 'NASHVILLE'
        AND classification = 'General Acute Care Hospital'


---------------------------------
---------------------------------
---------------------------------
---------------------------------

--PROVIDERS doing referrals to nashville hospitals

WITH nash_hosps AS (SELECT npi, display_name, organization_name AS hospital  
            FROM npidata n
            LEFT JOIN taxonomy t
            USING(taxonomy_code)
            WHERE entity_type_code = 2
                AND n.location_address_city_name= 'NASHVILLE'
                AND n.location_address_state_name = 'TN'
                AND t.display_name = 'General Acute Care Hospital')   --nash_hosps only

--building profile for the referring_provs         
SELECT 
        h.from_npi AS referring_npi, 
        t.display_name AS referring_specialty,
        n.organization_name AS referring_organization,
        n.location_address_city_name AS referring_city,
        n.location_address_state_name AS referring_state,
        n.location_address_postal_code AS referring_zipcode,
        nash_hosps.npi AS referred_npi,
        nash_hosps.hospital AS referred_hospital

FROM hop h

INNER JOIN npidata n  --to find their npi info
ON h.from_npi = n.npi

INNER JOIN taxonomy t --to find their specialty
USING(taxonomy_code)

LEFT JOIN nash_hosps   --referred to hospitals
ON h.to_npi = nash_hosps.npi

WHERE h.to_npi IN (SELECT npi FROM nash_hosps);
                 

---------------------------------
---------------------------------
---------------------------------
---------------------------------






---------------------------------
---------------------------------
SELECT * FROM npidata;

SELECT * FROM taxonomy;

SELECT * FROM zip_to_cbsa;

SELECT * FROM hop;


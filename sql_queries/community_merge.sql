SELECT nc.npi,
        organization_name,
        first_name,
        last_name,
        nc.communityid,
        t.grouping,
        t.classification,
        t.specialization,
        entity_type_code
        
FROM npi_community AS nc
INNER JOIN npidata AS nd
USING(npi)
INNER JOIN taxonomy AS t
USING(taxonomy_code);

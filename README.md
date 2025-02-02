# Hop Teaming Analysis
### Nashville Software School Data Science Bootcamp
### Cohort 6, September 2022 - June 2023    


## Team Floating Spirit
- [Ajay Kale](https://www.linkedin.com/in/ajaykale/)
- [Essete Tsahai](https://github.com/essetetsahai)
- [Jackson Mayfield](https://github.com/jmayf123)
- [Monica Weiss-Sharp](https://github.com/MWeissSharp)
- [Rod Miller](https://github.com/RodNSS)   


## Project Details
<details>
    <summary>See project instructions and context</summary>

For this project, you will be working with the Hop Teaming dataset, a dataset which aims to capture referrals between healthcare providers based on Medicare claims. The 2018 Hop Teaming dataset can be downloaded from https://drive.google.com/file/d/1t2-qcCSmXCFBJ-xvbRvMc2Nlu9VTsZts/view?usp=sharing. More information about the Hop Teaming data can be found at https://careset.com/docgraph-hop-teaming-dataset/. 

The Hop Teaming dataset identifies providers using NPIs, or National Provider Identifiers. An NPI is a unique identification number for covered health care providers created to improve the efficiency and effectiveness of electronic transmission of health information. An NPI is mandatory for all Medicare providers. To supplement the Hop Teaming, download the NPPES Data Dissemination from https://download.cms.gov/nppes/NPI_Files.html. 

</details>

## Data Details

### NPPES data
The NPPES dataset contains a large number of fields, only a few of which are relevant to this project:   
- 'NPI'    
-  Entity Type, indicated by the 'Entity Type Code' field:   
    - 1 = Provider (doctors, nurses, etc.)   
    - 2 = Facility (Hospitals, Urgent Care, Doctors Offices)    
-  Entity Name: Either First/Last or Organization or Other Organization Name contained in the following fields:   
    - 'Provider Organization Name (Legal Business Name)'   
    - 'Provider Last Name (Legal Name)'   
    - 'Provider First Name'   
    - 'Provider Middle Name'   
    - 'Provider Name Prefix Text'   
    - 'Provider Name Suffix Text'   
    - 'Provider Credential Text'   
- Address: Business Practice Location (not mailing), contained in the following fields:
    - 'Provider First Line Business Practice Location Address'
    - 'Provider Second Line Business Practice Location Address'
    - 'Provider Business Practice Location Address City Name'
    - 'Provider Business Practice Location Address State Name'
    - 'Provider Business Practice Location Address Postal Code'
- The provider's taxonomy code, which is contained in one of the 'Healthcare Provider Taxonomy Code*' columns. A provider can have up to 15 taxonomy codes, but we want the one which has Primary Switch = Y in the associated 'Healthcare Provider Primary Taxonomy Switch*' field. Note that this does not always occur in spot 1.

### Taxonomy
Next, download the taxonomy code to classification crosswalk from the [National Uniform Claim Committee](https://www.nucc.org/index.php/code-sets-mainmenu-41/provider-taxonomy-mainmenu-40/csv-mainmenu-57). Using the primary taxonomy code, match each provider to a classification (from the Classification column).

### Zip code to CBSA details 
Finally, you need the [ZIP code to CBSA crosswalk](https://www.huduser.gov/portal/datasets/usps_crosswalk.html) Match each provider to a CBSA using the Business Zip code. Note that the zipcodes in the nppes dataset are either 5 or 9 digits, and be mindful that leading zeros might be dropped when reading the dataset into a dataframe.

## Tasks   
- We want to eliminate "accidental" referrals, so filter the hop teaming data so that the transaction_count is at least 50 and the average_day_wait is less than 50. 
- First, build a profile of providers referring patients to the major hospitals in Nashville. Are certain specialties more likely to refer to a particular hospital over the others?
- Determine which professionals Vanderbilt Hospital should reach out to in the Nashville area to expand their own patient volume. 
    - First, research which professionals are sending significant numbers of patients only to competitor hospitals (such as TriStar Centennial Medical Center).
    - Next, consider the specialty of the provider. If Vanderbilt wants to increase volume from Orthopedic Surgeons or from Family Medicine doctors who should they reach out to in those areas?
- Finally, look for "communities" of providers in the Nashville/Davidson County CBSA. Make use of the [Louvain community detection algorithm from Neo4j](https://neo4j.com/docs/graph-data-science/current/algorithms/louvain/).


## Findings   
Our major conclusions include:   
- Tennessee providers are responsible for the vast majority of referrals, with Kentucky providers following at a distant second
- Vanderbit is already the lead hospital/hospital system in the Nashville area in terms of the number of providers sending referrals as well as the number of referral transactions and referral patients
- Physicians working in heart-related specialties are typically the ones responsible for the largest number of referral patients
- Vanderbilt might focus outreach on specialties and individual providers who have a larger number of referral patients/referral transactions and longer average wait times
- There are many communities among Nashville area providers (individuals and organizations)
- The largest community has over 1800 members and appears to primarily involve providers in and around Vanderbilt

You can see all final visualizations and detailed findings [on our Google Site](https://sites.google.com/view/hopteaming/home). 
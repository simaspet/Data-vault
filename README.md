Junior Data Engineer Project: Football Analytics

Project Structure
The project is divided into several key phases:

Data Extraction: Raw football data, including game details and player statistics, is provided in files. The initial step involves extracting data from these files and loading them into staging tables using SSIS packages.

Data Staging: Staging tables act as an intermediate step for data transformation and quality checks. SSIS packages will be designed to load the extracted data into these staging tables.

Data Transformation with Dynamic SQL: Dynamic SQL queries are employed to transform data from staging tables into a Data Vault structure. The dynamic nature of SQL queries allows for flexibility in handling various data transformations and ensures adaptability to changing data requirements.

Data Mart Creation: Once the data is transformed into the Data Vault structure, the next step is to load it into data marts with a star schema. This step involves creating a structured data model that facilitates efficient querying and reporting.

Integration with Power BI: The final phase involves integrating the processed data into Power BI for visualization and analytics. Power BI reports and dashboards will be created to provide insights into football game trends, player performance, and other relevant metrics.

Project Components
1. SSIS Packages
Extraction Package: Extracts data from raw files and loads it into staging tables.
Staging Package: Transfers data from staging tables, performs basic quality checks, and prepares it for transformation.
Dynamic SQL Transformation Package: Applies dynamic SQL queries to transform data from staging to Data Vault tables.
2. Dynamic SQL Queries
Dynamic SQL queries are used to dynamically generate transformation logic based on the specific requirements of the data. This ensures adaptability to changes in data structure and facilitates efficient handling of various data scenarios.

3. Data Vault Tables
Data Vault tables are designed to capture raw, unaltered data and provide a foundation for building flexible and scalable data structures.

4. Data Mart Tables
Data marts with a star schema are created to support efficient querying and reporting. These tables will be optimized for Power BI integration.

5. Power BI Integration
Power BI reports and dashboards will be developed to visually represent the football analytics data. Key metrics, trends, and insights will be highlighted to aid decision-making.

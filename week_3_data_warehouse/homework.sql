-- Creating external table referring to gcs path
CREATE OR REPLACE EXTERNAL TABLE `uplifted-nuance-338810.nytaxy.external_fhv_tripdata`
OPTIONS (
  format = 'PARQUET',
  uris = [' gs://dtc_data_lake_uplifted-nuance-338810/raw/fhv_tripdata_2019-*.parquet ', ' gs://dtc_data_lake_uplifted-nuance-338810/raw/fhv_tripdata_2019-*.parquet ']
);


-- Creating external table referring to gcs path - Partitined and Clustered
CREATE OR REPLACE EXTERNAL TABLE `uplifted-nuance-338810.nytaxy.external_fhv_tripdata_partitoned_clustered`
PARTITION BY DATE(dropoff_datetime)
CLUSTER BY dispatching_base_num AS
SELECT * FROM `uplifted-nuance-338810.nytaxy.external_fhv_tripdata`;

-- Q 1
SELECT COUNT(*)
FROM uplifted-nuance-338810.nytaxy.external_fhv_tripdata_partitoned_clustered


-- Q2
SELECT COUNT(DISTINCT dispatching_base_num)
FROM uplifted-nuance-338810.nytaxy.external_fhv_tripdata_partitoned_clustered

-- Q4
SELECT COUNT(*)
FROM `uplifted-nuance-338810.nytaxy.external_fhv_tripdata_partitoned_clustered`
WHERE DATE(dropoff_datetime) BETWEEN  '2019-01-01' AND '2019-03-31'
AND dispatching_base_num IN ('B00987', 'B02060', 'B02279')

create DATABASE SCOPED CREDENTIAL cred_jean
WITH IDENTITY = 'Managed Identity'


create EXTERNAL DATA SOURCE source_gold WITH(


    LOCATION = 'https://awstoragedatalakejean.blob.core.windows.net/gold',
    CREDENTIAL = cred_jean
)

create EXTERNAL DATA SOURCE source_silver WITH(


    LOCATION = 'https://awstoragedatalakejean.blob.core.windows.net/silver',
    CREDENTIAL = cred_jean
)


CREATE EXTERNAL FILE FORMAT format_parquet
WITH(

FORMAT_TYPE = PARQUET,
DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'

)


---CETE
CREATE EXTERNAL TABLE gold.extsales WITH(

    LOCATION ='extsales' ,
    DATA_SOURCE = source_gold,
    FILE_FORMAT = format_parquet
)
AS
SELECT * FROM gold.sales


SELECT * FROM gold.extsales

from pyspark.sql import SparkSession, DataFrame
from pyspark.sql.functions import decode
import os 

spark = SparkSession \
    .builder \
    .getOrCreate()

spark.sparkContext.setLogLevel("ERROR")

topics = [['vendor_id',"LONG"],['trip_id', "LONG"],['trip_distance',"FLOAT"],['fare_amount', "DOUBLE"],['store_and_fwd_flag', "STRING"]]
for index,topic in enumerate(topics):
    options = {
        "kafka.bootstrap.servers": os.getenv("DOMAIN_NAME")+":9092",
        "subscribe": topic[0],
    }   
    df = spark \
        .read \
        .format("kafka") \
        .options(**options) \
        .load()
    tmp_df = df.select(decode(df.key,'UTF-8').cast('LONG').alias("id"),decode(df.value,'UTF-8').cast(topic[1]).alias(topic[0])) 
    if index == 0:
        DF = tmp_df     
    else:
        DF = DF.join(tmp_df,'id','inner')
DF.show()

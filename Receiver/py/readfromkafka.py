from pyspark.sql import SparkSession, DataFrame
from pyspark.sql.functions import explode
from pyspark.sql.functions import split, to_binary,encode,decode,unhex,unbase64,to_number,row_number
from pyspark.sql.types import DoubleType, FloatType, LongType, StructType,StructField, StringType
from confluent_kafka.admin import AdminClient,NewTopic
import os 

spark = SparkSession \
    .builder \
    .appName("StructuredNetworkWordCount") \
    .getOrCreate()

spark.sparkContext.setLogLevel("ERROR")

admin_client=AdminClient({'bootstrap.servers': os.getenv("DOMAIN_NAME")+":9092"})
cluster_metadata = admin_client.list_topics()

topics = [['vendor_id',"LONG"],['trip_id', "LONG"],['trip_distance',"FLOAT"],['fare_amount', "DOUBLE"],['store_and_fwd_flag', "STRING"]]
for index,topic in enumerate(topics):
    print(topic[0],topic[1])
    options = {
        #"kafka.sasl.mechanism": "PLAIN",
        #"kafka.security.protocol" : "SASL_SSL",
        "kafka.bootstrap.servers": os.getenv("DOMAIN_NAME")+":9092",
        #"group.id": "test02",
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

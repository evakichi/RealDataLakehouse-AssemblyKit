from pyspark.sql import SparkSession, DataFrame
from pyspark.sql.functions import explode
from pyspark.sql.functions import split, to_binary,encode
from pyspark.sql.types import DoubleType, FloatType, LongType, StructType,StructField, StringType
import os

spark = SparkSession \
    .builder \
    .appName("StructuredNetworkWordCount") \
    .getOrCreate()

df = spark.table("demo.nyc.taxis00002")
df.select(encode(df.store_and_fwd_flag,'UTF-8').alias('value'))
df.select(encode(df.vendor_id,'UTF-8'))
df \
  .selectExpr("CAST(vendor_id AS BINARY)key","store_and_fwd_flag as value") \
  .write \
  .format("kafka") \
  .option("kafka.bootstrap.servers", os.getenv('DOMAIN_NAME')+":9092") \
  .option("topic", "topic1") \
  .save()

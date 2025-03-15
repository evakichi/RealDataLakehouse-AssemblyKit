from pyspark.sql import SparkSession, DataFrame
from pyspark.sql.functions import split, to_char,encode,base64,format_string
from pyspark.sql.types import DoubleType, FloatType, LongType, StructType,StructField, StringType
import os

spark = SparkSession \
    .builder \
    .appName("StructuredNetworkWordCount") \
    .getOrCreate()

df = spark.table("demo.nyc.taxis00002")
df.select(format_string("%d",df.trip_id)).show
df \
  .selectExpr("CAST(trip_id AS STRING) as key","cast (store_and_fwd_flag as string) as value") \
  .write \
  .format("kafka") \
  .option("kafka.bootstrap.servers", os.getenv('DOMAIN_NAME')+":9092") \
  .option("topic", "topic1") \
  .save()

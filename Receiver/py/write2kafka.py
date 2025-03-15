from pyspark.sql import SparkSession, DataFrame
from pyspark.sql.functions import explode
from pyspark.sql.functions import split, to_binary,encode
from pyspark.sql.types import DoubleType, FloatType, LongType, StructType,StructField, StringType

spark = SparkSession \
    .builder \
    .appName("StructuredNetworkWordCount") \
    .getOrCreate()

df = spark.table("demo.nyc.taxis00002")
df.select(encode(df.store_and_fwd_flag,'UTF-8').alias('value'))
df \
  .selectExpr("CAST(vendor_id AS BINARY) AS key","store_and_fwd_flag as value") \
  .write \
  .format("kafka") \
  .option("kafka.bootstrap.servers", "misumi.lan:9092") \
  .option("topic", "topic1") \
  .save()

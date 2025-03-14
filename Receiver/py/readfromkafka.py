from pyspark.sql import SparkSession, DataFrame
from pyspark.sql.functions import explode
from pyspark.sql.functions import split, to_binary,encode,decode
from pyspark.sql.types import DoubleType, FloatType, LongType, StructType,StructField, StringType

spark = SparkSession \
    .builder \
    .appName("StructuredNetworkWordCount") \
    .getOrCreate()

df = spark \
  .read \
  .format("kafka") \
  .option("kafka.bootstrap.servers", "misumi.lan:9092") \
  .option("subscribe", "topic1") \
  .load()

df.selectExpr("CAST(key as STRING)","CAST(value AS STRING)")
df.select(decode(df.key,'UTF-8'))
df.select(decode(df.value,'UTF8'))
df.show()
df.printSchema()


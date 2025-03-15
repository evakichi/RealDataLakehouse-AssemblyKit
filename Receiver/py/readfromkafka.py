from pyspark.sql import SparkSession, DataFrame
from pyspark.sql.functions import explode
from pyspark.sql.functions import split, to_binary,encode,decode,unhex,unbase64
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

#df2=df.selectExpr("CAST(value AS STRING) as value")
df2=df.select(decode(df.key,'UTF-8').alias("key"),df.value.cast('STRING').alias("value"))
#df.select(df2.value,decode(df.value,'UTF-8'))
df.show()
df.printSchema()
df2.show(30)

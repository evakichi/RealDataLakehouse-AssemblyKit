from  pyspark.sql import SparkSession, DataFrame
from pyspark.sql.types import DoubleType, FloatType, LongType, StructType,StructField, StringType

spark = SparkSession.builder.getOrCreate()
df = spark.table("demo.nyc.taxis00003")
df.show()
print(df.schema)

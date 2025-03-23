from pyspark.sql import SparkSession
import pyspark.sql.functions as F
import os

# Download from https://open.canada.ca/data/en/dataset/800106c1-0b08-401e-8be2-ac45d62e662e
# BroadcastLogs_2018_Q3_M8.CSV
# https://open.canada.ca/data/en/dataset/800106c1-0b08-401e-8be2-ac45d62e662e/resource/23b213b3-a4a4-4813-95f9-3916af57568c
# Data Dictionaly
# https://open.canada.ca/data/en/dataset/800106c1-0b08-401e-8be2-ac45d62e662e/resource/12efecb4-1eb5-4b92-808e-3dbaaee2ec9d
# Reference Tables
# https://open.canada.ca/data/en/dataset/800106c1-0b08-401e-8be2-ac45d62e662e/resource/8fdbf80d-2161-48a5-8a32-fc90e738a7a3

spark = SparkSession.builder.getOrCreate()

DIRECTORY = "./data/broadcast_logs"
logs = spark.read.csv(
        path=os.path.join(DIRECTORY, "BroadcastLogs_2018_Q3_M8.CSV"),
        sep="|",
        header=True,
        inferSchema=True,
        timestampFormat="yyyy-MM-dd",
        )
logs.select("BroadcastLogID", "LogServiceID", "LogDate").show(5, False)

logs.writeTo("Canada.Broadcast.Logs.2018_Q3.M8").create()

df = spark.table("Canada.Broadcast.Logs.2018_Q3.M8")
df.show()
df.printSchema()

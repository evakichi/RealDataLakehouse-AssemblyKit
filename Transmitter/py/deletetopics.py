from pyspark.sql import SparkSession, DataFrame
from pyspark.sql.functions import split, to_char,encode,base64,format_string
from pyspark.sql.types import DoubleType, FloatType, LongType, StructType,StructField, StringType
from kafka import KafkaAdminClient
from confluent_kafka.admin import AdminClient,NewTopic
import os

spark = SparkSession \
    .builder \
    .appName("StructuredNetworkWordCount") \
    .getOrCreate()

topics = ["vendor_id","trip_id","trip_distance","fare_amount","store_and_fwd_flag"]
old_topics = [NewTopic(topic) for topic in topics]
admin_client=AdminClient({'bootstrap.servers': os.getenv("DOMAIN_NAME")+":9092"})
admin_client.delete_topics(topics=topics)

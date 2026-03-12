from awsglue.context import GlueContext
from pyspark.context import SparkContext


sc = SparkContext()
glueContext = GlueContext(sc)

spark = glueContext.spark_session

tables = [
    'clientes',
    'produtos',
    'vendas',
    'preco_competidores'    
]


for table in tables:
    df = glueContext.create_dynamic_frame.from_catalog(
        database='datalake_raw',
        table_name = table
    )
    
    df_spark = df.toDF()
    
    df_spark.write.mode('overwrite').parquet(
    f"s3://lucas-datalake-excel-project/silver/{table}/"
    )
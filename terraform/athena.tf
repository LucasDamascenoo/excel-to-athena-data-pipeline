

resource "aws_athena_database" "silver_db" {
  name = "datalake_silver"
  bucket = aws_s3_bucket.datalake.bucket
}
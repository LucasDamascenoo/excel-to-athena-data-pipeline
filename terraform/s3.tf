# criando um recurso na aws
# aws_s3_bucket == tipo do recurso que estamos criando
# datalake == nome interno no terraform, isso nao aparece na aws
# {} == onde colocamos as configuracoes dos buckets ou outro recurso que vamos criar
# bucket == define o nome real do bucket
# "lucas-datalake-excel-project" == nome do meu bucket(deve ser unico) na aws

resource "aws_s3_bucket" "datalake" {
    bucket = "lucas-datalake-excel-project"
}



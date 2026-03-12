
# estamos criando um recurso - catalago de metadados dos arquivos pqt
# aws_glue_catalog_database == crie um database no catalago do glue
# datalake_db == nome 'interno' do recurso do terraform
# {}==  onde colocamos as configuracoes dos glue ou outro recurso que vamos criar
# name == nome do nosso database no catalago da aws

resource "aws_glue_catalog_database" "datalake_db" {
    name = "datalake_raw"  
}

resource "aws_glue_catalog_database" "silver_db" {
  name = "datalake_silver"
  
}

# crawler : responsavel por ler arquivos no s3 (detecta os schema automaticamente) e cria tabelas no glue catalog
#raw_crawler == nome interno no terraform
# name == nome real do crawler dentro da aws
# role == permissao pro crawler acessar o s3
#s3_target = onde o crawler deve procurar os arquivos


resource "aws_glue_crawler" "raw_crawler" {
    name = "raw_crawler"
    database_name = aws_glue_catalog_database.datalake_db.name
    role = aws_iam_role.glue_role.arn

    s3_target {
      
      path = "s3://lucas-datalake-excel-project/raw"

    }
  
}

resource "aws_glue_crawler" "silver_crawler" {
  name = "silver_crawler"
  database_name = aws_glue_catalog_database.silver_db.name
  role = aws_iam_role.glue_role.arn
  s3_target {
    path = "s3://lucas-datalake-excel-project/silver/"
  }
}

# cria um job que processa dados em spark/pysaprk e pandas
#excel-etl = nome interno do terraform
#name == nome real do job na AWS
# role_arn == role que permite o job : ler s3 > gravar no s3 > acessar glue catalog > e escrever logs no cloudWATCH

#command == define como o job vai ser executado
#script_location == onde o script etl vai executar
#python_version = definicao da versao do python

resource "aws_glue_job" "excel_etl" {

    name = "excel-to-parquet"
    role_arn = aws_iam_role.glue_role.arn

    command {
      script_location = "s3://lucas-datalake-excel-project/etl/excel_to_parquet.py"
      python_version = "3"
    }
  
}




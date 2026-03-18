# excel-to-athena-data-pipeline

Pipeline de Engenharia de Dados para ingestão, transformação e consulta de dados a partir de arquivos CSV utilizando um Data Lake na AWS com S3, Glue e Athena, provisionado com Terraform.

## 🎯 Objetivo do Projeto

Este projeto implementa um pipeline de dados seguindo arquitetura moderna de Data Lake (Bronze / Silver):

- Extract (Ingestão): upload de arquivos CSV locais para o S3 (camada raw)

- Transform (ETL): processamento com AWS Glue (Spark) convertendo CSV → Parquet

- Load (Consulta): disponibilização dos dados no Athena para consultas SQL

## 🧱 Arquitetura Utilizada

Infraestrutura (IaC)

- Terraform para provisionamento completo da infraestrutura

Armazenamento

- Amazon S3 como Data Lake:
  - /raw → dados brutos (CSV)
  - /silver → dados tratados (Parquet)

Processamento

- AWS Glue:
    - Crawlers para descoberta de schema
    - Job ETL em PySpark

Catálogo de Dados

- AWS Glue Data Catalog:
    - datalake_raw
    - datalake_silver

Consulta

- Amazon Athena
    - Queries SQL diretamente sobre os dados no S3

## Estrutura do Projeto


```text:
.
├── terraform/
│   ├── main.tf
│   ├── s3.tf
│   ├── iam.tf
│   ├── glue.tf
│
├── etl/
│   └── excel_to_parquet.py
│
├── scripts/
│   └── upload_to_s3.py
│
├── data/
│   └── *.csv
│
└── README.md
```

## ⚙️ Tecnologias Utilizadas

- Python
- PySpark
- Terraform
- AWS S3
- AWS Glue
- AWS Athena
- boto3

## 🧠 Conceitos Aplicados

- Data Lake Architecture (Bronze / Silver)
- ETL com Spark
- Schema-on-read
- Data Catalog
- Infraestrutura como código (IaC)
- Processamento distribuído


## 📌 Observações

Este projeto simula um pipeline real de engenharia de dados, utilizando práticas comuns em ambientes de produção com foco em escalabilidade, organização e performance.
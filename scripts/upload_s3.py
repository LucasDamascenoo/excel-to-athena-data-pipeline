
import boto3
import os


# bucket criado no terraform
# aqui sera o destino dos nossos arquivos:

BUCKET_NAME = 'lucas-datalake-excel-project'

# Pasta local : onde estao os arquivos

DATA_PATH = '../data'

# criando o cliente do s3 : nos permitindo  fazer upload-download-listar objettos e deletar os objetos
s3 = boto3.client('s3')

# criamos um dicionarios dos arquivos
# arquivo local -> caminho no s3
# sai de data para s3://lucas-datalake-excel-project/raw/clientes/arquivo.csv

files = {
    'clientes.csv': 'raw/clientes/clientes.csv',
    'produtos.csv': 'raw/produtos/produtos.csv',
    'vendas.csv': 'raw/vendas/vendas.csv',
    'preco_competidores.csv': 'raw/preco_competidores/preco_competidores.csv'
    
}


# loop nos arquivos

# fizemos uma iteracao chave(file_name) - valor(caminho)
for file_name , s3_path in files.items():
    #juntando o caminho local + arquivos
    # ../data/clientes.csv
    local_path = os.path.join(DATA_PATH,file_name)
    
    print(f'Uploadinf {file_name} -> {s3_path}' )
    
    #subindo os arquivos no s3
    #
    s3.upload_file(
        local_path, #arquivo local
        BUCKET_NAME, #nome do bucket
        s3_path # caminho no s3
    )
    
print('upload concluido')
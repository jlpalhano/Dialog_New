#!/bin/bash
. ./config_programa.txt
. ./conexao_db.cnf

frame=celular
FRAME=${celular^^}
seleciona_dados_edicao_celular_db(){
CELULAR=$1
$STRING_CONN_BANCO_TF "SELECT * FROM tbl_celular
        WHERE marcaCelu
                LIKE '$CELULAR%'
                LIMIT 1;" > ${frame}.tmp
}


insere_dados_celular_db(){

MARCA_CELULAR=$1
MODELO_CELULAR=$2


$STRING_CONN_BANCO "INSERT INTO tbl_celular (
                        marcaCelu, modeloCelu
                        )
                        VALUES (
                                '$MARCA_CELULAR','$MODELO_CELULAR'
                        );"
}

lista_dados_celular_db(){
$STRING_CONN_BANCO_TF "SELECT * FROM tbl_celular;" > celular.tmp
}


pesquisa_dados_celular_db(){
PARAM=$1
$STRING_CONN_BANCO_TF "SELECT * FROM tbl_celular
        WHERE marcaCelu
                LIKE '$PARAM%'
                LIMIT 1;" > ${frame}.tmp


}

atualiza_dados_cliente_db(){
#echo "UPDATE FROM tbl_pessoa
#        SET nome="$2",
#            endereco='$3'
#                WHERE idPessoa="$1";"



CODIGO="$1"
TP_PESSOA="$2"
NOME="$3"
SNOME="$4"
DT_NASC="$5"
CPF_CNPJ="$6"
ENDERECO="$7"
OBSPES="$8"
EMAIL="$9"
TELEFONE="${10}"  # Para mais de 10 parametros usar as {} na variavel
sleep 10
$STRING_CONN_BANCO "UPDATE tbl_pessoa           	\
        SET tpPessoa='$TP_PESSOA',                      \
                         nmPessoa='$NOME',              \
                         snomePessoa='$SNOME',  	\
                         dtNascimento='$DT_NASC',       \
                         cpf='$CPF_CNPJ',               \
                         endereco='$ENDERECO',  	\
                         obsPessoa='$OBSPES',           \
                         email='$EMAIL',                \
                         telefone='$TELEFONE'   	\
                         WHERE idPessoa='$CODIGO';"
}


seleciona_itens_delete_celular_db(){
$STRING_CONN_BANCO "SELECT idCelular, marcaCelu, modeloCelu
        FROM tbl_celular;" > query.txt
}
apaga_dados_celular_db(){
PARAM="$1"
echo "$STRING_CONN_BANCO DELETE FROM tbl_celular \
        WHERE idCelular IN ( "$PARAM" );"
sleep 4
$STRING_CONN_BANCO "DELETE FROM tbl_celular 	\
        WHERE idCelular IN ( '$PARAM' );"
}

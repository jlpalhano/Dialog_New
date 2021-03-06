#!/bin/bash
. ./config_programa.txt
. ./conexao_db.cnf

valida_login_db(){
USUARIO=$1
SENHA=$2
RETORNO=$($STRING_CONN_BANCO "SELECT fun_valida_usuario('$USUARIO','$SENHA') as Validou;")


NOME_LOGADO=$( $STRING_CONN_BANCO "SELECT pess.nmPessoa FROM tbl_pessoa pess
	 INNER JOIN tbl_usuario usr
		 WHERE pess.idPessoa = usr.idPessoa
			 AND usr.usuario = '$USUARIO';" ) 

}



seleciona_dados_edicao_cliente_db(){
CLIENTE=$1
$STRING_CONN_BANCO_TF "SELECT * FROM tbl_pessoa
        WHERE nmPessoa
                LIKE '$CLIENTE%'
                LIMIT 1;" > clientes.tmp
}


insere_dados_cliente_db(){

TP_PESSOA=$1
NOME=$2
SNOME=$3
DT_NASC=$4
CPF_CNPJ=$5
ENDERECO=$6
OBSPES=$7
EMAIL=$8
TELEFONE=$9


$STRING_CONN_BANCO "INSERT INTO tbl_pessoa (
                        tpPessoa, nmPessoa, snomePessoa, dtNascimento, cpf, endereco, obsPessoa, email, telefone
                        )
                        VALUES (
                                '$TP_PESSOA','$NOME', '$SNOME', '$DT_NASC', '$CPF_CNPJ', '$ENDERECO', '$OBSPES', '$EMAIL','$TELEFONE'
                        );"
}

lista_dados_cliente_db(){
$STRING_CONN_BANCO_TF "SELECT * FROM tbl_pessoa;" > clientes.tmp
}


pesquisa_dados_cliente_db(){
CLIENTE=$1
$STRING_CONN_BANCO_TF "SELECT * FROM tbl_pessoa
        WHERE nmPessoa
                LIKE '$CLIENTE%'
                LIMIT 1;" > clientes.tmp


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


seleciona_itens_delete_db(){
$STRING_CONN_BANCO "SELECT idPessoa, nmPessoa
        FROM tbl_pessoa;" > query.txt
}
apaga_dados_cliente_db(){
DELETE="$1"
echo "$STRING_CONN_BANCO DELETE FROM tbl_pessoa \
        WHERE idPessoa IN ( "$DELETE" );"
sleep 4
$STRING_CONN_BANCO "DELETE FROM tbl_pessoa 	\
        WHERE idPessoa IN ( '$DELETE' );"
}

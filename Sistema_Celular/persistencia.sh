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
$STRING_CONN_BANCO_TF  "SELECT * FROM tbl_pessoa
        WHERE nmPessoa
                LIKE '$CLIENTE%'
                LIMIT 1;" > clientes.tmp


}

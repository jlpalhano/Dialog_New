. ./conexao_db.cnf
export NCURSES_NO_UTF8_ACS=1
if [ -s clientes.tmp ];
then
#sed  -i '$d;1d' clientes.tmp # Remove a primeira e ultima linha do arquivo
codigo=$( awk -F"|" '{print $2}' clientes.tmp | sed 's/\s//; s/ *$//' )
tipoPessoa=$( awk -F"|" '{print $3}' clientes.tmp | sed 's/\s//; s/ *$//' )
nome=$( awk -F"|" '{print $4}' clientes.tmp | sed 's/\s//; s/ *$//' )
sobrenome=$( awk -F"|" '{print $5}' clientes.tmp | sed 's/\s//; s/ *$//' )
dataNascimento=$( awk -F"|" '{print $6}' clientes.tmp | sed 's/\s//; s/ *$//' )
cpf_cnpj=$( awk -F"|" '{print $7}' clientes.tmp | sed 's/\s//; s/ *$//' )
endereco=$( awk -F"|" '{print $8}' clientes.tmp | sed 's/\s//; s/ *$//' )
obsPessoa=$( awk -F"|" '{print $9}' clientes.tmp | sed 's/\s//; s/ *$//' )
email=$( awk -F"|" '{print $10}' clientes.tmp  | sed 's/\s//; s/ *$//' )
telefone=$( awk -F"|" '{print $11}' clientes.tmp | sed 's/\s//; s/ *$//' )

exec 3>&1

formulario=$( dialog                                             \
--title "INSERIR"                                  \
--form ""                                          \
0 0 0                                              \
"Codigo:"     	1 1	"$codigo"       	1 10 10 30  \
"Tipo Pessoa:"	2 1	"$tipoPessoa"   	2 10 10 30  \
"Nome:"     	3 1	"$nome"         	3 10 30 0   \
"Endereço:"     4 1     "$sobrenome"    	4 10 70 70  \
"DT. Nasc.:"    5 1     "$dataNascimento"       5 10 70 70  \
"CPF/CNPJ.:"    6 1     "$cpf_cnpj"     	6 10 70 70  \
"Endereço:"     7 1     "$endereco"     	7 10 70 70  \
"OBS:"     	8 1     "$obsPessoa"     	8 10 70 70  \
"E-mail:"     	9 1     "$email"     		9 10 70 70  \
"telefone:"     10 1    "$telefone"     	10 10 70 70 \
2>&1 1>&3)


exec 3>&-

codigo_=$( echo "$formulario" | sed 1!d )
tipoPessoa_=$( echo "$formulario" | sed 2!d )
nome_=$( echo "$formulario" | sed 3!d )
#nome_=$( echo "$nome" )
sobrenome_=$( echo "$formulario" | sed 4!d )
dataNascimento_=$( echo "$formulario" | sed 5!d )
cpf_cnpj_=$( echo "$formulario" | sed 6!d )
endereco_=$( echo "$formulario" | sed 7!d )
obsPessoa_=$( echo "$formulario" | sed 8!d )
email_=$( echo "$formulario" | sed 9!d )
telefone_=$( echo "$formulario" | sed 10!d )
echo $nome_

sleep 10
fi

UPDATE(){
echo "UPDATE FROM tbl_pessoa
	SET nome="$2",
	    endereco='$3'
		WHERE idPessoa="$1";"



CODIGO="$1"
TP_PESSOA="$2"
NOME="$3"
SNOME="$4"
DT_NASC="$5"
CPF_CNPJ="$6"
ENDERECO="$7"
OBSPES="$8"
EMAIL="$9"
TELEFONE="$10"
echo $TELEFONE
sleep 10
$STRING_CONN_BANCO "UPDATE tbl_pessoa 		\
        SET tpPessoa='$TP_PESSOA',			\
                         nmPessoa='$NOME',		\
                         snomePessoa='$SNOME',	\
                         dtNascimento='$DT_NASC',	\
                         cpf='$CPF_CNPJ',		\
                         endereco='$ENDERECO',	\
                         obsPessoa='$OBSPES',		\
                         email='$EMAIL', 		\
                         telefone='$TELEFONE' 	\
                         WHERE idPessoa='$CODIGO';"


}

UPDATE $codigo_ $tipoPessoa_ "$nome" "$sobrenome_" "$dataNascimento_" $cpf_cnpj_ "$endereco_" "$obsPessoa_" "$email_" "$telefone_"

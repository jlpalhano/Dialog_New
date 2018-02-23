#!/bin/bash
. ../persistencia.sh
#-------------------------------EDITA DADOS------------------------------

editar_dados_cliente(){
CLIENTE=""
while [ -z "${CLIENTE}" ]
do
        CLIENTE=$( dialog --stdout \
                --title "Informe o ${FRAME}" \
                --inputbox "Digite o nome do ${frame} a editar" \
                0 0
         )

        case $? in
        0) seleciona_dados_edicao_cliente_db ${CLIENTE};;
        1) dialog --title "Operacao Cancelada" --msgbox "Foi cancelada a edicao do ${frame}." 0 0 ;
        break;;
        *) echo "Qualquer dado vindo na edição";;
        esac

        [ -z "${CLIENTE}" ] && ( dialog --msgbox "Insira um nome de ${frame} valido." 0 0 ; continue) || break
done

if [ -s clientes.tmp ];
then
sed  -i '$d;1d' clientes.tmp # Remove a primeira e ultima linha do arquivo
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

echo $telefone

formulario=$(
         dialog                                             \
                --title "Atualizar dados do Cliente"                           \
                --form "Atualização"                                   \
0 0 0                                                       \
"Codigo:"       1  1     "$codigo"               1  10  10  30  \
"Tipo Pessoa:"  2  1     "$tipoPessoa"           2  10  10  30  \
"Nome:"         3  1     "$nome"                 3  10  30  30  \
"Endereço:"     4  1     "$sobrenome"            4  10  70  70  \
"DT. Nasc.:"    5  1     "$dataNascimento"       5  10  70  70  \
"CPF/CNPJ.:"    6  1     "$cpf_cnpj"             6  10  70  70  \
"Endereço:"     7  1     "$endereco"             7  10  70  70  \
"OBS:"          8  1     "$obsPessoa"            8  10  70  70  \
"E-mail:"       9  1     "$email"                9  10  70  70  \
"telefone:"    "10"  1     "$telefone"           "10"  11  70  70  \
2>&1 1>&3
)


exec 3>&-

codigo_=$( echo "$formulario" | sed 1!d )
tipoPessoa_=$( echo "$formulario" | sed 2!d )
nome_=$( echo "$formulario" | sed 3!d )
sobrenome_=$( echo "$formulario" | sed 4!d )
dataNascimento_=$( echo "$formulario" | sed 5!d )
cpf_cnpj_=$( echo "$formulario" | sed 6!d )
endereco_=$( echo "$formulario" | sed 7!d )
obsPessoa_=$( echo "$formulario" | sed 8!d )
email_=$( echo "$formulario" | sed 9!d )
telefone_=$( echo "$formulario" | sed 10!d )

echo $telefone_
exec 3>&-
echo "atualiza_dados_cliente_db codigo_ $codigo_ tipoPessoa_ $tipoPessoa_ nome_ "$nome_" sobrenome_ "$sobrenome_" dataNascimento_  "$dataNascimento_" cpf_cnpj_  $cpf_cnpj_ endereco_  "$endereco_" obsPessoa_ "$obsPessoa_" email_ "$email_" telefone_ "$telefone_""

if [ -z "$codigo_" ] || [ -z "$tipoPessoa_" ] || [ -z "$nome_" ] || [ -z "$sobrenome_" ] || [ -z "$dataNascimento_" ] ||  [ -z "$cpf_cnpj_" ] || [ -z "$endereco_"  ] || [ -z "$obsPessoa_" ] || [ -z "$email_" ] || [ -z "$telefone_" ]; then
dialog --title "Erro no update" --msgbox "Um erro ocorreu e um dado nao podera ser inserido" 0 0
else
atualiza_dados_cliente_db "$codigo_" "$tipoPessoa_" "$nome_" "$sobrenome_" "$dataNascimento_" "$cpf_cnpj_" "$endereco_" "$obsPessoa_" "$email_" "$telefone_"
fi

else
        dialog --title "Atenção" \
               --msgbox "Nao foi encontrado nenhum ${frame} com esta descrição."  \
               0 0
fi
}



#!/bin/bash

. ./persistencia.sh

insere_dados_cliente(){

status(){
retorno=$?
case $retorno in
	1) dialog --yesno "Deseja Sair?" 0 0;;
	2) dialog --yesno "Deseja Sair?" 0 0;;
	255) dialog --yesno "Deseja Sair?" 0 0;;
esac
}

tipoPessoa=$( 
dialog                                           \
   --stdout					 \
   --title 'Pergunta'                            \
   --radiolist "Digite o tipo da pessoa J - Juridica, F - Fisica do ${frame}:"  \
   0 0 0                                         \
   J  'Pessoa Juridica'      off                \
   F  'Pessoa Fisica'  on               \

         )
status

nome=$( dialog --stdout \
                --title "Adicionar $FRAME" \
                --inputbox "Digite o nome do ${frame}:" \
                0 0
         )
status

sobrenome=$( dialog --stdout \
                --title "Adicionar $FRAME" \
                --inputbox "Digite o sobrenome do ${frame}:" \
                0 0
         )
status

dataNascimento=$( dialog --stdout \
                --title "Adicionar $FRAME" \
                --inputbox "Digite a Data Nascimento do ${frame}:" \
                0 0
         )

cpf_cnpj=$( dialog --stdout \
                --title "Adicionar $FRAME" \
                --inputbox "Digite o cpf/cnpj do ${frame}:" \
                0 0
         )
status

endereco=$( dialog --stdout \
                --title "Adicionar $FRAME" \
                --inputbox "Digite o endereco do ${frame}:" \
                0 0
         )
status

obsPessoa=$( dialog --stdout \
                --title "Adicionar $FRAME" \
                --inputbox "Digite as observaçoes adicionais do ${frame}:" \
                0 0
         )
status

email=$( dialog --stdout \
                --title "Adicionar $FRAME" \
                --inputbox "Digite o e-mail do ${frame}:" \
                0 0
         )
status

telefone=$( dialog --stdout \
                --title "Adicionar $FRAME" \
                --inputbox "Digite o telefone do ${frame}:" \
                0 0
         )
status


insere_dados_cliente_db "$tipoPessoa" "$nome" "$sobrenome" "$dataNascimento" "$cpf_cnpj"  "$endereco" "$obsPessoa" "$email" "$telefone"
}



#---------------------------------------------LISTA DE CLIENTES---------------------------------------------------------


lista_dados_cliente(){
lista_dados_cliente_db

if [ -s clientes.tmp ];
then
sed  -i '$d;1d' clientes.tmp # Remove a primeira e ultima linha do arquivo

#O awk asegui precisa ser execudato a com o resultado da execução do comando STRING_CONN_BANCO_TF, que esta definido no arquivo de conexao
#Usando como separador o | 
 awk -F"|" 'BEGIN {printf("%-10s %-10s %s %s %s \n" ,"Código", "Tipo Pess.", "Nome", "E-mail", "Telefone" )}
        {printf("%6.0f  %-10s %s %s %s\n", $2, $3, $4, $10, $11)}' clientes.tmp > tmp2
	dialog --stdout \
               --extra-button --extra-label "Imprimir" \
               --title "Lista de $FRAME" \
               --textbox tmp2 \
               0 0
	  status 
else
        dialog --title "Atenção" \
               --msgbox "Nao foi encontrado nenhum ${frame} para exibir." \
               0 0
fi
#rm produtos.tmp
}





pesquisa_dados_cliente(){

CLIENTE=""
while [ -z "${CLIENTE}" ]
do
        CLIENTE=$( dialog --stdout \
                  --title "Pesquisa $FRAME" \
                  --inputbox "Digite o nome do ${frame}" \
                  0 0 )

        [ -z "${CLIENTE}" ] && ( dialog --msgbox "Insira um nome de ${frame} valido." 0 0 ; continue) || break
done
pesquisa_dados_cliente_db ${CLIENTE}
# Se funcao pesquisa_dados_db retornou dados, insere no arquivo produtos.tmp, caso contrario sera vazia. If abaixo testa se o arquivo esta vazio
# para entao montar a tela
if [ -s clientes.tmp ]; then
	 sed  -i '$d;1d' clientes.tmp #Remove a primeira e ultima linha, caso o arquivo tenha dados
	 awk -F"|" 'BEGIN {printf("%-10s %-10s %s %s %s \n" ,"Código", "Tipo Pess.", "Nome", "E-mail", "Telefone" )}
        {printf("%6.0f  %-10s %s %s %s\n", $2, $3, $4, $10, $11)}' clientes.tmp > res

        dialog --title "Lista de Clientes encontrados por Cliente:" \
               --textbox res \
               0 0
else
        dialog --title "Atenção" \
               --msgbox "Nao foi encontrado nenhum ${frame} com esta descrição." \
               0 0
fi

}

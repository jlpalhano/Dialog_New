#!/bin/bash
. ../persistencia.sh
#-------------------------------PESQUISA DADOS------------------------------

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


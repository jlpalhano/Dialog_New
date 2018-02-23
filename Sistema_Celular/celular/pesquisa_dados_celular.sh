#!/bin/bash
#-------------------------------PESQUISA DADOS------------------------------

. ./celular/persistencia_celular.sh
FRAME=Celular
frame=${FRAME,,}

pesquisa_dados_celular(){

CELULAR=""
while [ -z "${CELULAR}" ]
do
        CELULAR=$( dialog --stdout \
                  --title "Pesquisa $FRAME" \
                  --inputbox "Digite o nome do ${frame}" \
                  0 0 )

        [ -z "${CELULAR}" ] && ( dialog --msgbox "Insira um nome de ${frame} valido." 0 0 ; continue) || break
done
pesquisa_dados_celular_db ${CELULAR}
# Se funcao pesquisa_dados_db retornou dados, insere no arquivo produtos.tmp, caso contrario sera vazia. If abaixo testa se o arquivo esta vazio
# para entao montar a tela
if [ -s ${frame}.tmp ]; then
         sed  -i '$d;1d' ${frame}.tmp #Remove a primeira e ultima linha, caso o arquivo tenha dados
         awk -F"|" 'BEGIN {printf("%-10s %-10s %s\n" ,"Código", "Marca", "Modelo" )}
        {printf("%6.0f  %-10s %s\n", $2, $3, $4)}' ${frame}.tmp > res

        dialog --title "Lista de Clientes encontrados por Cliente:" \
               --textbox res \
               0 0
else
        dialog --title "Atenção" \
               --msgbox "Nao foi encontrado nenhum ${frame} com esta descrição." \
               0 0
fi

}


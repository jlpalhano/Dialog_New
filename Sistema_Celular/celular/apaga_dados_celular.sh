#!/bin/bash
#-------------------------------APAGAR DADOS------------------------------

. ./celular/persistencia_celular.sh
FRAME=Celular;
frame=${FRAME,,};

apaga_dados_celular(){
seleciona_itens_delete_${frame}_db
options=()
        while IFS="|" read col1 col2 || [ -n "$col1" ]; do
                options+=("${col1//'"'/}" "${col2//'"'/}" "off")
        done <query.txt

        escolha=$( dialog --separate-output \
                --stdout --title "$FRAME a deletar" \
                --checklist "Escolha um ${frame} da lista:" \
                50 80 10 \
                "${options[@]}"
        )
dialog --stdout --title "Confirmacao" --yesno "Tem certeza que deseja excluir o item?" 0 0
case $? in
0)
ITENS_DELETE=$( echo $escolha | tr -d '[:alpha:]' | sed 's/ *$//g' |  sed 's/\s\s/,/g' ) ;# tr apaga todas as palavras, primeiro sed pega os numeros q sao saida do comando tr e colica ", entre eles". O ultimo sed deleta a ultima virgula da lista, pra ficar no padrao sql 1,2,3,4
if [ ! -z "$ITENS_DELETE" ];
then
apaga_dados_${frame}_db "$ITENS_DELETE";
else
        dialog --title "Erro no Delete" --msgbox "Um erro ocorreu e o item nao foi deletado" 0 0;
fi;;

1) dialog --title "Operacao Cancelada" --msgbox "Foi cancelada a remocao do ${frame}." 0 0 ;;
*) echo "Qual dado em $?"
esac
}


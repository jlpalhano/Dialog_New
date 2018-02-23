#---------------------------------------------LISTA DE CELULARES---------------------------------------------------------
. ./celular/persistencia_celular.sh
FRAME=Celular;
frame=${FRAME,,};
lista_dados_celular(){
lista_dados_celular_db

if [ -s ${frame}.tmp ];
then
sed  -i '$d;1d' ${frame}.tmp # Remove a primeira e ultima linha do arquivo

#O awk asegui precisa ser execudato a com o resultado da execução do comando STRING_CONN_BANCO_TF, que esta definido no arquivo de conexao
#Usando como separador o |
 awk -F"|" 'BEGIN {printf("%-10s %-10s %s %s %s \n" ,"Código", "Tipo Pess.", "Nome", "E-mail", "Telefone" )}
        {printf("%6.0f  %-10s %s %s %s\n", $2, $3, $4, $10, $11)}' ${frame}.tmp > tmp2
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


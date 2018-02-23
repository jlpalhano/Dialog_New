#!/bin/bash
. ./celular/persistencia_celular.sh
#-------------------------------INSERIR DADOS------------------------------
FRAME=Celular;
frame=${FRAME,,};

insere_dados_celular(){

status(){
retorno=$?
case $retorno in
        1) dialog --yesno "Deseja Sair?" 0 0;;
        2) dialog --yesno "Deseja Sair?" 0 0;;
        255) dialog --yesno "Deseja Sair?" 0 0;;
esac
}

marca=$( dialog --stdout                                                        \
                --title "Adicionar $FRAME"                                      \
                --inputbox "Digite a marca do ${frame}:"                        \
                0 0
         )
status

modelo=$( dialog --stdout                                                    	\
                --title "Adicionar $FRAME"                                      \
                --inputbox "Digite o modelo do ${frame}:"                    	\
                0 0
         )
status


insere_dados_celular_db "$marca" "$modelo" 
}


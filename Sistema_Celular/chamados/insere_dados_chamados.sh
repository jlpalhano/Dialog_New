#!/bin/bash
. ./celular/persistencia_chamados.sh
#-------------------------------INSERIR DADOS------------------------------
FRAME=Chamados;
frame=${FRAME,,};

insere_dados_chamados(){

status(){
retorno=$?
case $retorno in
        1) dialog --yesno "Deseja Sair?" 0 0;
	exit 0;;
        2) dialog --yesno "Deseja Sair?" 0 0;
	exit 0;;
        255) dialog --yesno "Deseja Sair?" 0 0;
	exiit 0;;
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


insere_dados_$frame_db "$marca" "$modelo" 
}


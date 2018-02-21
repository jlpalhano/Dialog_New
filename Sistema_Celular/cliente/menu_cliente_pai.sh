#!/bin/bash
. config_programa.txt
manter_cliente_gui(){
while : ; do

OPCAO=$(
        $DIALOG --stdout \
        --title "Manutencao de $FRAME $VERSION" \
        --menu 'Escolha um opcao: ' \
        0 0 0 \
          1 "Adicionar $FRAME"    \
          2 "Listar $FRAME"       \
          3 "Pesquisar $FRAME"    \
          4 "Deletar $FRAME"      \
          5 "Editar $FRAME"       
)

[ $? -ne 0 ] && break
case $OPCAO in
        1)
	. ./cliente/insere_dados_cliente.sh;
        insere_dados_cliente;;
        2) 
        . ./cliente/lista_dados_cliente.sh;
	lista_dados_cliente;;
        3)
	. ./cliente/pesquisa_dados_cliente.sh;
        pesquisa_dados_cliente;;
        4) 
	. ./cliente/apaga_dados_cliente.sh;
        apaga_dados_cliente;;
        5)
	. ./cliente/editar_dados_cliente.sh
	editar_dados_cliente;; 
esac

done
}

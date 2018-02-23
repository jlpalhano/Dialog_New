#!/bin/bash
#FRAME=CHAMADOS


. ./chamados/config_programa_chamados.txt

manter_chamados_gui(){
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
        . ./$frame/insere_dados_$frame.sh;
        insere_dados_${frame};;
        2)
        . ./${frame}/lista_dados_${frame}.sh;
        lista_dados_$frame{};;
        3)
        . ./$frame/pesquisa_dados_${frame}.sh;
        pesquisa_dados_${frame};;
        4)
        . ./${frame}/apaga_dados_${frame}.sh;
        apaga_dados_${frame};;
        5)
        . ./${frame}/editar_dados_${frame}.sh
        editar_dados_${frame};;
esac

done
}


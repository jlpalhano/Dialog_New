manter_cliente_gui(){
. ./menu_cliente_filho.sh
while : ; do

OPCAO=$(
        dialog --stdout \
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
        insere_dados_cliente;;
        2) 
        lista_dados_cliente;;
        3)
        pesquisa_dados_cliente;;
        4) 
        apaga_dados;;
        5) 
        editar_dados;;
esac

done
}

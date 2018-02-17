. ./Persistence.sh
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
	  5 "Editar $FRAME"	  \
)

[ $? -ne 0 ] && break

case $OPCAO in
	1) echo Adicionar contatos;
	insere_dados;
	sleep 5;;
	2) echo 'Listar contatos';
	seleciona_dados;;
	3) echo 'Pesquisar contatos';
	pesquisa_dados;;
	4) echo 'Deletar contatos';
	apaga_dados;;
	5) echo 'Editar Produtos';
	editar_dados;;
esac

done


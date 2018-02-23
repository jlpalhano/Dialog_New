. ./PrincipalDialog.sh
. ./config_programa.txt
while : ; do

OPCAO=$(
        $DIALOG --stdout \
        --title "Nenu Principal $VERSION" \
        --menu 'Escolha um opcao: ' \
        0 0 0 \
          1 "Manter Cliente"    \
          2 "Manter Celular"    \
          3 "Manter Usuario"    \
	  4 "Manter Check-List"  \
	  5 "Manter Chamados"  \
)

[ $? -ne 0 ] && break

case $OPCAO in
        1)
	. ./cliente/menu_cliente_pai.sh;
	manter_cliente_gui;;
        2) echo 'Manter Celular';
	. ./celular/menu_celular_pai.sh;
	manter_celular_gui;;
        3) echo 'Manter Usuarios';
        manter_usuario_gui;;
        4) echo 'Manter Check-List';
        manter_checklist_gui;;
	5) echo "Manter Chamado";
	 . ./chamados/menu_chamados_pai.sh;
	manter_chamados_gui;;
esac

done


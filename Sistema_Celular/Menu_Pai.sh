. ./PrincipalDialog.sh
while : ; do

OPCAO=$(
        dialog --stdout \
        --title "Nenu Principal $VERSION" \
        --menu 'Escolha um opcao: ' \
        0 0 0 \
          1 "Manter Cliente"    \
          2 "Manter Celular"    \
          3 "Manter Usuario"    \
	  4 "Manter Check-List"  \
)

[ $? -ne 0 ] && break

case $OPCAO in
        1)
	. ./menu_cliente_pai.sh
	FRAME=Cliente;
	FNC="_cli";
	manter_cliente_gui;;
        2) echo 'Manter Celular';
        manter_celular_cli;
	FRAME=Cliente;
        FNC="_cel";;
        3) echo 'Manter Usuarios';
        manter_usuario_gui;
	FRAME=Usuarios;
        FNC="_usr";;
        4) echo 'Manter Check-List';
        manter_checklist_gui;
	FRAME=Check-List;
        FNC="_cklist";;
esac

done


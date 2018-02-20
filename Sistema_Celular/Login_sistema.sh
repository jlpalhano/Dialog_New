#!/bin/bash
. ./persistencia.sh

status(){
comando_recebido=$?
case $comando_recebido in
	1) exit 0;;
	255) dialog --defaultno --yesno "Deseja sair?" 0 0;
	[ $? -eq 0 ] && exit 0;;
esac 
}

dialog --sleep 3 --backtitle "$PROGRAMA - $VERSION" --infobox "Bem Vindo \n$PROGRAMA" 5 28


dialog --stdout --yesno "Deseja Logar" 0 0
status $?


i=0
while (( $i < 3))
do
login_user=$(
	dialog --stdout --title "Login Sistema" --backtitle "$PROGRAMA" \
	       --inputbox "Usuario" \
        	0 0 
)

senha=$(
	dialog  --stdout --title "Login Sistema" --backtitle "$PROGRAMA" \
		--insecure --passwordbox "Senha" \
		0 0
)
valida_login_db $login_user $senha
#A variavel RETORNO esta declarada dentro da funcao Valida_login_db e retona 1 para OK e 0 para login nao OK
if [ $RETORNO -eq 1 ];
then
	break
else
	dialog --sleep 3 --backtitle "$PROGRAMA - $VERSION" --title "Login Sistema" --infobox "\nUsuario ou senha invalidos..." 5 35
	let i++
	(( $i == 3 )) && dialog --backtitle "$PROGRAMA - $VERSION" --title "Login Sistema" --sleep 3 --infobox "\nTentativas esgotadas" 5 24 && exit 0
fi 
done #end while



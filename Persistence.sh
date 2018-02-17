#!/bin/bash
VERSION="0.1_b17022018"
FRAME=Produto
frame=produto
export NCURSES_NO_UTF8_ACS=1
. ./fnc_banco.sh
. ./printer.sh

retornos(){
case $1 in
3) imprimir;;
esac
}

insere_dados(){
produto=""
while [ -z "${produto}" ]
do
        produto=$( dialog --stdout \
		--title "Adicionar $FRAME" \
		--inputbox "Digite o nome do ${frame}:" 0 0 )
	[ -z "${produto}" ] && ( dialog --msgbox "Insira um nome de ${frame} valido." 0 0 ; continue) || break

done

preco=""
while [ -z "${preco}" ]
do
        preco=$( dialog --stdout \
		--inputbox 'Digite o preço:' 0 0 )
	[ -z "${preco}" ] && ( dialog --msgbox "Insira um Preco valido." 0 0 ; continue) || break
done
insere_dados_db $produto $preco
}


seleciona_dados(){
seleciona_dados_db 
   
if [ -s produtos.tmp ];
then
	awk 'BEGIN {printf("%s %8s %8s %8s \n" ,"Código", "Nome", "Preco Normal", "Preço Desc.")}
	{printf("%6.0f %8s %8.2f %8.2f\n", $1, $2, $3, $4)}' produtos.tmp > tmp2
	dialog --stdout  --extra-button --extra-label "Imprimir" --title "Lista de Preços" --textbox tmp2 0 0
		retornos $?
else
	dialog --title "Atenção" --msgbox "Nao foi encontrado nenhum ${frame} para exibir." 0 0
fi
#rm produtos.tmp            
}

pesquisa_dados(){
PRODUTO=""
while [ -z "${PRODUTO}" ]
do
	PRODUTO=$( dialog --stdout \
		  --title "Pesquisa $FRAME" \
		  --inputbox "Digite o nome do ${frame}" \
		  0 0 )

	[ -z "${PRODUTO}" ] && ( dialog --msgbox "Insira um nome de ${frame} valido." 0 0 ; continue) || break
done
pesquisa_dados_db ${PRODUTO}
# Se funcao pesquisa_dados_db retornou dados, insere no arquivo produtos.tmp, caso contrario sera vazia. If abaixo testa se o arquivo esta vazio
# para entao montar a tela
if [ -s produtos.tmp ]; then	
awk 'BEGIN {printf("%s %8s %8s %8s \n" ,"Código", "Nome", "Preco Normal", "Preço Desc.")}
{printf("%6.0f %8s %8.2f %8.2f\n", $1, $2, $3, $4)}' produtos.tmp > res

	dialog --title "Lista de Preços encontrados por ${PRODUTO}:" \
		--textbox res 0 0
else
	dialog --title "Atenção" --msgbox "Nao foi encontrado nenhum ${frame} com esta descrição." 0 0
fi
}

apaga_dados(){
seleciona_itens_delete_db
options=()
	while IFS="|" read col1 col2 || [ -n "$col1" ]; do
		options+=("${col1//'"'/}" "${col2//'"'/}" "off")
	done <query.txt

	escolha=$( dialog --separate-output \
		--stdout --title "$FRAME a deletar" \
		--checklist "Escolha um ${frame} da lista:" \
		50 80 10 \
		"${options[@]}"
	)
DELETE=$( echo $escolha | tr -d '[:alpha:]' | sed 's/ *$//g' |  sed 's/\s\s/,/g' ) # tr apaga todas as palavras, primeiro sed pega os numeros q sao saida do comando tr e colica ", entre eles". O ultimo sed deleta a ultima virgula da lista, pra ficar no padrao sql 1,2,3,4
apaga_dados_db $DELETE
}


editar_dados(){
PRODUTO=""
while [ -z "${PRODUTO}" ]
do
	PRODUTO=$( dialog --stdout \
		--title "Informe o ${FRAME}" \
	 	--inputbox "Digite o nome do ${frame} a editar" 0 0 )
	[ -z "${PRODUTO}" ] && ( dialog --msgbox "Insira um nome de ${frame} valido." 0 0 ; continue) || break
done
seleciona_dados_edicao_db ${PRODUTO}
if [ -s produtos.tmp ];
then


	codigo=$( awk '{print $1}' produtos.tmp )
	produto=$( awk '{print $2}' produtos.tmp )
	preco=$( awk '{print $4}' produtos.tmp )

# open file descriptor (fd)
	exec 3>&1

	# Store data to $VALUES variable
	VALUES=$(dialog --ok-label "Envio" \
		--backtitle "Gerenciamento de $FRAME" \
		--title "Atualiza $FRAME" \
		--form "Atualiza $FRAME" \
		15 50 0 \
		"Codigo :" 1 1 "$codigo" 1 10 10 0 \
		"Produto:" 2 1 "$produto" 2 10 40 0 \
		"Preço :" 3 1 "$preco" 3 10 15 0 \
	2>&1 1>&3)

	# close fd
	exec 3>&-

	i=1
	IFSold=$IFS
	export IFS="
	"

		for valores in $VALUES;do
			case $i in
				1)cod_prod="$valores";;
				2)Produto="$valores";;
				3)Preco="$valores";;
			esac
		i=`expr $i + 1`
		done

	export IFS="$IFSold"
	
	dialog --title "Confirmacao" \
		--msgbox "cod_prod: $cod_prod\n \
			 Produto: $Produto\n \
			 Preco: $Preco\n"
			 0 0
	atualiza_dados_db $Produto $Preco $cod_prod


else
	dialog --title "Atenção" --msgbox "Nao foi encontrado nenhum ${frame} com esta descrição." 0 0
fi	

}

codigo=$( awk '{print $1}' produtos.tmp )
produto=$( awk '{print $2 " " $3}' produtos.tmp )
preco=$( awk '{print $4}' produtos.tmp )

# open file descriptor (fd)
exec 3>&1

# Store data to $VALUES variable
VALUES=$(dialog --ok-label "Envio" \
--backtitle "Gerenciamento de Produto" \
--title "Atualiza Produto" \
--form "Atualiza Produto" \
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

i=`expr $i + 1`
export IFS="$IFSold"

dialog --title "Oi" --msgbox "cod_prod: $cod_prod\nProduto:
$Produto\nPreco: $Preco\n" 0 0
#-------------------------_FIM_Script_--------------------------#
echo "UPDATE produto SET nomeProduto='$Produto', precoNormal='$Preco' WHERE idProduto='$cod_prod';"
#UPDATE produto  SET nomeProduto='Queijo Minasqw', precoNormal='1452.49' WHERE idProduto = 52;

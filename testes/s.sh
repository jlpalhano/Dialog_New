while read line
do
codigo_produto=$( echo $line | awk -F "|" '{print $1}' )
nome_produto=$( echo $line | awk -F "|" '{print $2}' )
lista=$( $codigo_produto $nome_produto )

dialog --stdout \
	--checklist 'Você gosta de:' 0 0 0 \
	/bin/echo $lista
done < agua.txt

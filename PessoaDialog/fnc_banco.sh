sql="/usr/bin/mysql -N -uroot -pPa55w.rd db_Biblioteca -e"

insere_dados_db(){
PRODUTO=$1
PRECO=$2
$sql "INSERT INTO produto (
                        nomeProduto, precoNormal
                        )
                        VALUES (
                                '$PRODUTO','$PRECO'
                        );"
}

seleciona_dados_db(){
#GERA A PESQUISA NO BANCO E ENVIA PARA O ARQUIVO produtos.tmp
	$sql "SELECT * FROM produto;" > produtos.tmp
}

pesquisa_dados_db(){
NOME=$1
$sql "SELECT * FROM produto
       	WHERE nomeProduto 
		like '$NOME%';" > produtos.tmp
}

seleciona_itens_delete_db(){
$sql "SELECT idProduto, nomeProduto
        FROM produto;" > query.txt
}

apaga_dados_db(){
DELETE=$1
$sql "DELETE FROM produto
        WHERE idProduto IN ( $DELETE );"
}
seleciona_dados_edicao_db(){
PRODUTO=$1
 $sql 	"SELECT * FROM produto
	WHERE nomeProduto 
		LIKE '$PRODUTO%'
		LIMIT 1;" > produtos.tmp

}
atualiza_dados_db(){
PRODUTO=$1
PRECO=$2
CODIGO=$3
$sql 	"UPDATE produto 
		SET nomeProduto='$PRODUTO',
			precoNormal='$PRECO'
			WHERE idProduto='$CODIGO';"
}

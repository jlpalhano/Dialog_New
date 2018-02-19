MariaDB [db_Biblioteca]> select * from produto;
+-----------+-------------+-------------+---------------+
| idProduto | nomeProduto | precoNormal | precoDesconto |
+-----------+-------------+-------------+---------------+
|        73 | Trigo1      |       10.35 |         10.35 |
|        74 | Marmelada   |       30.34 |         29.73 |
|        75 | Queijo      |        9.67 |          9.48 |
+-----------+-------------+-------------+---------------+


CREATE TABLE produto( 
	idProduto INT NOT NULL AUTO_INCREMENT,
	 nomeProduto VARCHAR(45) NULL,
	 precoNormal DECIMAL(10,2) NULL,
	 precoDesconto DECIMAL(10,2) NULL,
		 PRIMARY KEY(idProduto)
	);


CREATE TRIGGER trig_bef_desconto
	 BEFORE INSERT ON produto FOR EACH ROW 
		SET NEW.precoDesconto = (NEW.precoNormal * 0.98 );


INSERT INTO produto (nomeProduto, precoNormal )
	 VALUES ('Monitor',5.00);



 delete from produto where idProduto in ( 1, 2, 3, 4, 5, )



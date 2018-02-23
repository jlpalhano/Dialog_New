#!/bin/bash
#-------------------------------EDITA DADOS------------------------------


. ./celular/persistencia_celular.sh
FRAME=Celular
frame=${FRAME,,}

editar_dados_celular(){
CELULAR=""
while [ -z "${CELULAR}" ]
do
        CELULAR=$( dialog --stdout \
                --title "Informe a marca ${FRAME}" \
                --inputbox "Digite a marca do ${frame} a editar" \
                0 0
         )

        case $? in
        0) seleciona_dados_edicao_celular_db ${CELULAR};;
        1) dialog --title "Operacao Cancelada" --msgbox "Foi cancelada a edicao do ${frame}." 0 0 ;
        break;;
        *) echo "Qualquer dado vindo na edição";;
        esac

        [ -z "${CELULAR}" ] && ( dialog --msgbox "Insira um nome de ${frame} valido." 0 0 ; continue) || break
done

if [ -s ${frame}.tmp ];
then
sed  -i '$d;1d' ${frame}.tmp # Remove a primeira e ultima linha do arquivo
codigo=$( awk -F"|" '{print $2}'  ${frame}.tmp | sed 's/\s//; s/ *$//' )
marca=$( awk -F"|" '{print $3}'  ${frame}.tmp | sed 's/\s//; s/ *$//' )
modelo=$( awk -F"|" '{print $4}'  ${frame}.tmp | sed 's/\s//; s/ *$//' )
exec 3>&1


formulario=$(
         dialog                                             \
                --title "Atualizar dados do ${FRAME}"                           \
                --form "Atualização"                                   \
0 0 0                                                       \
"Codigo:"       	1  1     "$codigo"              1  10  10  30  \
"Marca ${FRAME}:"  	2  1     "$marca"           	2  10  10  30  \
"Modelo ${FRAME}:"      3  1     "$modelo"              3  10  30  30  \
2>&1 1>&3
)


exec 3>&-

codigo_=$( echo "$formulario" | sed 1!d )
marca_=$( echo "$formulario" | sed 2!d )
modelo_=$( echo "$formulario" | sed 3!d )

echo $telefone_
exec 3>&-
echo "atualiza_dados_${frame}_db codigo_ $codigo_ marca_ $marca_ modelo_ "$modelo_"" 

if [ -z "$codigo_" ] || [ -z "$marca_" ] || [ -z "$modelo_" ]; then
dialog --title "Erro no update" --msgbox "Um erro ocorreu e um dado nao podera ser inserido" 0 0
else
atualiza_dados_${frame}_db "$codigo_" "$marca_" "$modelo_" 
fi

else
        dialog --title "Atenção" \
               --msgbox "Nao foi encontrado nenhum ${frame} com esta descrição."  \
               0 0
fi
}



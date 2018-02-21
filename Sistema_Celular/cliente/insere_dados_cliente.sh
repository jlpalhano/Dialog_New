#!/bin/bash
. ../persistencia.sh
#-------------------------------INSERIR DADOS------------------------------

insere_dados_cliente(){

status(){
retorno=$?
case $retorno in
        1) dialog --yesno "Deseja Sair?" 0 0;;
        2) dialog --yesno "Deseja Sair?" 0 0;;
        255) dialog --yesno "Deseja Sair?" 0 0;;
esac
}

tipoPessoa=$(
dialog                                                                          \
   --stdout                                                                     \
   --title 'Pergunta'                                                           \
   --radiolist "Digite o tipo da pessoa J - Juridica, F - Fisica do ${frame}:"  \
   0 0 0                                                                        \
   J  'Pessoa Juridica'      off                                                \
   F  'Pessoa Fisica'        on                                                 \

         )
status

nome=$( dialog --stdout                                                         \
                --title "Adicionar $FRAME"                                      \
                --inputbox "Digite o nome do ${frame}:"                         \
                0 0
         )
status

sobrenome=$( dialog --stdout                                                    \
                --title "Adicionar $FRAME"                                      \
                --inputbox "Digite o sobrenome do ${frame}:"                    \
                0 0
         )
status

dataNascimento=$( dialog --stdout                                               \
                --title "Adicionar $FRAME"                                      \
                --inputbox "Digite a Data Nascimento do ${frame}:" \
                0 0
         )

cpf_cnpj=$( dialog --stdout \
                --title "Adicionar $FRAME" \
                --inputbox "Digite o cpf/cnpj do ${frame}:" \
                0 0
         )
status

endereco=$( dialog --stdout \
                --title "Adicionar $FRAME" \
                --inputbox "Digite o endereco do ${frame}:" \
                0 0
         )
status

obsPessoa=$( dialog --stdout \
                --title "Adicionar $FRAME" \
                --inputbox "Digite as observaçoes adicionais do ${frame}:" \
                0 0
         )
status

email=$( dialog --stdout \
                --title "Adicionar $FRAME" \
                --inputbox "Digite o e-mail do ${frame}:" \
                0 0
         )
status

telefone=$( dialog --stdout \
                --title "Adicionar $FRAME" \
                --inputbox "Digite o telefone do ${frame}:" \
                0 0
         )
status

insere_dados_cliente_db "$tipoPessoa" "$nome" "$sobrenome" "$dataNascimento" "$cpf_cnpj"  "$endereco" "$obsPessoa" "$email" "$telefone"
}


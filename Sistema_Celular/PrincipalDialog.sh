#!/bin/bash
. ./config_programa.txt
. ./Login_sistema.sh

dialog --backtitle "$PROGRAMA $VERSION" --title "Logado com Sucesso..." --msgbox "\nBem Vindo $NOME_LOGADO" 0 0

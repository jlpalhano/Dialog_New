imprimir(){
#dialog --title "Imprimir " --msgbox `cat tmp2` 0 0
lpr -P cups-pdf tmp2
#return
}


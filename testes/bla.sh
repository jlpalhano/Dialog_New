contact=$(while read -r line
            do

		cod=$(echo $line | awk 'BEGIN { FS="|" } { print $2 }')
                firstname=$(echo $line | awk 'BEGIN { FS="|" } { print $2 }')
                lastname=$(echo $line | awk 'BEGIN { FS="|" } { print $3 }')
                num=$(echo $line | awk 'BEGIN { FS="|" } { print $4 }')
                birthday=$(echo $line | awk 'BEGIN { FS="|" } { print $5 }')
                if [  $firstname != ""  -a  $lastname != "" ] ; then
                    echo "$firstname$lastname"
                else
                    if [ $firstname != "" ] ; then
                        echo "$firstname,"
                    elif [ $lastname != "" ] ; then
                        echo "$lastname"
                    else
                        echo "$num"
                    fi
                fi
	echo "dialog --stdout --no-items --checklist "Contas de e-mail:" 0 0 $contact"
            done < "contactlist.txt" )




#echo "yad --title="Contacts" --width=200 --height=200 --button="DISPLAY:2" --button="ADD:3" --list --separator=""  --column="List" $sortcontact --column="ID:NUM" $idlist "

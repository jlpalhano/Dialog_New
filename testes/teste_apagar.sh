filename="$1"
tags=()

while read -r tag;
do
    tags+=( "${tag} off" )
done < "$filename"

#emails=$(dialog --stdout --no-items --checklist "Contas de e-mail:" 20 50 ${#tags[@]} ${tags[@]})
emails=$(dialog --stdout --no-items --checklist "Contas de e-mail:" 20 50 ${tags[@]})

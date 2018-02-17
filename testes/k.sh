#cod=$( awk '{print $1}' contasemail.txt )
options=$( find . -name '*.sh' | awk '{print $1 $2, "on"}')
cmd=(dialog --stdout --no-items \
        --separate-output \
        --ok-label "Delete" \
        --checklist "Select options:" 22 76 16)
choices=$("${cmd[@]}" ${options})

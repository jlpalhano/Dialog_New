options=()
while IFS="|" read col1 col2 || [ -n "$col1" ]; do
    options+=("$col1" "$col2" "off")  # Note the double-quotes around the variable references
done <query.txt
echo "options:"
printf "  '$s'\n" "${options[@]}"  # This prints each array element on a separate line
dialog --title "Armatures" --checklist "Choose an armature" 50 80 10 "${options[@]}"  # Again, double-quotes around the refe

echo "Mount points on the system"
echo
echo | awk '{ printf "%-35s:\t%s\n", "Mount point", "Type" }'
echo ---------------------------------------------------------

while read line 
	do
		echo $line | awk '{ printf "%-35s:\t%s\n", $3, $5}'
done < <(mount)

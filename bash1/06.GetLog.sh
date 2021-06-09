REQUESTS=$(awk '{ print $9 }' access.log | wc -l)
NON_200=$(awk '{ if ($9 != 200) {print $9}}' access.log | wc -l)
awk '{ print $1 }' access.log | sort | uniq

echo
echo Total $REQUESTS requests
echo Total $NON_200 responses with status != 200

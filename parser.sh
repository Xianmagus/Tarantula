#!/bin/bash
#parses index.html and scrapes for URLs and resolves for IPs for Target nomination while minimizing
#collateral targeting

webpage=$1

RED='\033[1;31m'
NC='\033[0m'

mm_decho ()
{
	local i stepping
	stepping="0.01"

	if [ ! "$1" ]; then
		echo
		return
	fi

	if (( $# > 1 )) &&
		[[ ($2 = $(echo $2 | grep -oE '[[:digit:]]')) ||
			($2 = $(echo $2 | grep -oE '[[:digit:]]+\.[[:digit:]]+')) ]]
		then
			stepping="$2"
	elif (( $# > 1 )); then
		echo "$1"
		echo ".! mm_decho() oops: second argument is invalid!" 1>&2
		echo ".! must be /float but is: \"$2\", leaving function.." 1>&2
		return false 2>/dev/null
	fi

	for i in $(seq 0 $((${#1}-1))); do
		echo -ne "${RED}${1:$i:1}${NC}"
		sleep $stepping
	done
	echo
}


rm -f ./index.html
rm -f ./IPlist.txt
rm -f ./URLlist.txt
rm -f ./TargetList.txt
echo -e "\n"
mm_decho "Cleaned environment. Ready to proceed..." "0.05"
echo -e "\n"
sleep 1s
wget -q $webpage
mm_decho "Web index retrieved..." "0.05"
echo -e '\n'
sleep 1s
cat index.html | grep -o '[a-zA-Z0-9_\.-]'*$webpage | sort -u > URLlist.txt
mm_decho "URLlist.txt created..." "0.05"
sleep 1s
echo -e '\n'
for url in $(cat index.html | grep -o '[a-zA-Z0-9_\.-]'*$webpage | sort -u); do host $url; done | grep "has address" | cut -d " " -f 4 | sort -u > IPlist.txt
mm_decho "IPlist.txt created..." "0.05"
echo -e '\n'
for var in $(cat URLlist.txt); do host $var; done | grep "has address" | sort -u | cut -d " " -f 1,4 | column -t -c 2 > TargetList.txt
mm_decho "Target List created..." "0.05"
echo -e '\n'
sleep 1s
cat TargetList.txt
sleep 2s
echo -e '\n'
mm_decho "Task complete!" "0.19"
echo -e '\n'
sleep 2s

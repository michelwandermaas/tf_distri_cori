#!/bin/bash -l

if [ $# -eq 1 ] && [ $1 == '--help' ]; then

	echo 'USAGE: ./script COMMAND NUMBER_PS_NODES'

	echo "The default NUMBER_PS_NODES is 1."

	exit

elif [ $# -eq 0 ] || [ $# -gt 2 ]; then

	echo 'Wrong number of arguments, use --help to see the usage.'

	exit

elif [ $# -eq 2 ]; then
	
	PS_SIZE=$2	

else

	PS_SIZE=1
fi

scontrol show hostnames > names.txt
COMMAND=$1
NUM=0
NUM_COL=$(cat names.txt | wc -l)
NODES[$NUM_COL]=""
while read p; do
	NUM=$(expr ${NUM} + 1)
	eval NODES[$NUM]=`echo $p`
done <names.txt
PS_LIST=""
WORKER_LIST=""
STANDARD_PORT=":7878"
for (( i=1; i<=$NUM_COL; i++)); do
	if [ $i -le $PS_SIZE ]; then
		if [ "$PS_LIST" == "" ]; then
			PS_LIST="${NODES[$i]}$STANDARD_PORT"
		else
			PS_LIST="$PS_LIST,${NODES[$i]}$STANDARD_PORT"
		fi
	else
		if [ "$WORKER_LIST" == "" ]; then
                        WORKER_LIST="${NODES[$i]}$STANDARD_PORT"
                else
			WORKER_LIST="$WORKER_LIST,${NODES[$i]}$STANDARD_PORT"
		fi
	fi
done	
echo $PS_LIST
echo $WORKER_LIST
ARGUMENT="--ps_hosts=$PS_LIST --worker_hosts=$WORKER_LIST"
FULL_COMMAND="$COMMAND $ARGUMENT"
COMMANDS[$NUM_COL]=""
NUM[$NUM_COL]=-1
for (( i=1; i<=$NUM_COL; i++)); do
	if [ $i -le $PS_SIZE ]; then
		NUM[$i]=$(expr $i - 1)
		COMMANDS[$i]="$FULL_COMMAND --job_name=ps --task_index=${NUM[$i]}"
	else
		NUM[$i]=$(expr $i - $PS_SIZE)
		NUM[$i]=$(expr ${NUM[$i]} - 1)
		COMMANDS[$i]="$FULL_COMMAND --job_name=worker --task_index=${NUM[$i]}"		
	fi
	echo ${COMMANDS[$i]} | ssh ${NODES[$i]}
done

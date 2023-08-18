#!/bin/bash
VM=$1
STAGE=$2
STEP=$3

HUGEPAGES="8192"

if [ "$VM" = "win10" ]
then
        if [ "$STAGE" = "prepare" ] && [ "$STEP" = "begin" ]
        then
                alloc
        elif [ "$STAGE" = "release" ] && [ "$STEP" = "end" ]
        then
                dealloc
        fi
else
        exit 0
fi

function alloc () {
        echo "Allocating hugepages..."
        echo $HUGEPAGES > /proc/sys/vm/nr_hugepages
        ALLOC_PAGES=$(cat /proc/sys/vm/nr_hugepages)
        
        TRIES=0
        while (( $ALLOC_PAGES != $HUGEPAGES && $TRIES < 1000 ))
        do
        echo 1 > /proc/sys/vm/compact_memory            ## defrag ram
        echo $HUGEPAGES > /proc/sys/vm/nr_hugepages
        ALLOC_PAGES=$(cat /proc/sys/vm/nr_hugepages)
        echo "Succesfully allocated $ALLOC_PAGES / $HUGEPAGES"
        let TRIES+=1
        done
        
        if [ "$ALLOC_PAGES" -ne "$HUGEPAGES" ]
        then
        echo "Not able to allocate all hugepages. Reverting..."
        echo 0 > /proc/sys/vm/nr_hugepages
        exit 1
        fi
}

function dealloc () {
        echo 0 > /proc/sys/vm/nr_hugepages
}

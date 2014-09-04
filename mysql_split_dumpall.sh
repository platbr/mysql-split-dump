#!/bin/bash

FILE=$1
if [ "$1"X == "X" ]
then
        echo Usage: $0 file_generated_by_dump.sql
        exit
fi
for BD in $(cat $FILE | grep "^.. Current Database: \`" | cut -d\` -f2)
do
        OUT=$(echo $FILE | sed s/\.sql$/_$BD\.sql/g)
        echo Creating: $OUT
        sed -n "/^-- Current Database: \`$BD\`/,/^-- Current Database:/p" $FILE > $OUT
done

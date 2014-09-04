#!/bin/bash

FILE=$1
if [ "$1"X == "X" ]
then
        echo Usage: $0 file_generated_by_dump_all_databases.sql
        exit
fi
rm $(echo $FILE | sed s/\.sql$/_*\.sql/g)
for BD in $(cat $FILE | grep "^.. Current Database: \`" | cut -d\` -f2)
do
        OUT=$(echo $FILE | sed s/\.sql$/_$BD\.sql/g)
        echo Generating: $OUT
        sed -n "/^-- Current Database: \`$BD\`/,/^-- Current Database:/p" $FILE >> $OUT
done

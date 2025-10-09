#!/bin/bash

INPUT="filtered_data.csv"
OUTPUT="monthly_response.csv"

# Write header
echo "zipcode,month,avg_hours" > "$OUTPUT"

awk -F, '
BEGIN {
    OFS=","
}
NR > 1 {
    created=$2
    closed=$3
    zip=$10

    # skip if no closed date
    if (closed == "") next

    # parse timestamps (needs GNU date!)
    gsub("\"","",created)
    gsub("\"","",closed)

    cmd1="date -d \"" created "\" +%s"
    cmd1 | getline t1
    close(cmd1)

    cmd2="date -d \"" closed "\" +%s"
    cmd2 | getline t2
    close(cmd2)

    if (t2 >= t1) {
        hours=(t2-t1)/3600
        # extract YYYY-MM from created date
        cmdm="date -d \"" created "\" +%Y-%m"
        cmdm | getline month
        close(cmdm)

        key=zip FS month
        sum[key]+=hours
        count[key]++
    }
}
END {
    for (k in sum) {
        split(k,a,FS)
        zip=a[1]; month=a[2]
        avg=sum[k]/count[k]
        print zip, month, avg
    }
}
' "$INPUT" >> "$OUTPUT"


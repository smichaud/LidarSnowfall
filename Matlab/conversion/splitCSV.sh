#!/usr/bin/env bash
# Note: this is a quick script to help me for conversion: MAKE SURE PATHS ARE OK FOR YOUR ENVIRONMENT
# Note: it assumes you have lms151.csv, lms200.csv, hokuyo.csv and create a folder for each

if [ "$#" != 2 ];then
    echo "usage: splitCSV.sh dirWithCSVFiles/ LineCountForSplit"
    echo "ex: ./splitCSV.sh /home/user/data/ 1000"
else
    mkdir "$1/lms151_parts" 
    split --suffix-length 3 -d --lines $2 "$1/lms151.csv" "$1/lms151_parts/lms151_"
     
    mkdir "$1/lms200_parts"
    split --suffix-length 3 -d --lines $2 "$1/lms200.csv" "$1/lms200_parts/lms200_"

    mkdir "$1/hokuyo_parts"
    split --suffix-length 3 -d --lines $2 "$1/hokuyo.csv" "$1/hokuyo_parts/hokuyo_" 
fi

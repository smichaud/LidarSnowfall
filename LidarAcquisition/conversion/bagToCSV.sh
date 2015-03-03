#!/usr/bin/env bash

if [ "$#" != 2 ];then
    echo 'Usage : bagToCSV bagFile.bag outputFolder/'
else
    echo 'Extracting LMS151 data...'
    rostopic echo -p --nostr -b $1 /lms151/scan > "$2lms151.csv"

    echo 'Extracting LMS200 data...'
    rostopic echo -p --nostr -b $1 /lms200/scan > "$2lms200.csv"

    echo 'Extracting Hokuyo data...'
    rostopic echo -p --nostr -b $1 /echoes > "$2hokuyo.csv"

    echo 'Extracting Velodyne data...'
    # Todo: use the node
fi

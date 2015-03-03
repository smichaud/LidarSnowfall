#!/usr/bin/env bash
# Note: this is a quick script to help me for conversion: MAKE SURE PATHS ARE OK FOR YOUR ENVIRONMENT

currentDir=$(pwd)/

echo "Convert lms151"
/usr/local/MATLAB/R2013a/bin/matlab -nojvm -nodisplay -r "cd $currentDir;convertLaserScanCSVToMatFile('$1/lms151.csv');exit;"

echo "Convert lms200"
/usr/local/MATLAB/R2013a/bin/matlab -nojvm -nodisplay -r "cd $currentDir;convertLaserScanCSVToMatFile('$1/lms200.csv');exit;"

echo "Convert hokuyo"
/usr/local/MATLAB/R2013a/bin/matlab -nojvm -nodisplay -r "cd $currentDir;convertLaserScanCSVToMatFile('$1/hokuyo.csv');exit;"

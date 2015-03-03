#!/usr/bin/env bash
# Note: this is a quick script to help me for conversion: MAKE SURE PATHS ARE OK FOR YOUR ENVIRONMENT

currentDir=$(pwd)/

echo "Convert lms151"
/usr/local/MATLAB/R2013a/bin/matlab -nojvm -nodisplay -r "cd $currentDir;convertSplittedLaserScanCSVToMatFiles('$1/lms151_parts/');exit;"

echo "Convert lms200"
/usr/local/MATLAB/R2013a/bin/matlab -nojvm -nodisplay -r "cd $currentDir;convertSplittedLaserScanCSVToMatFiles('$1/lms200_parts/');exit;"

echo "Convert hokuyo"
/usr/local/MATLAB/R2013a/bin/matlab -nojvm -nodisplay -r "cd $currentDir;convertSplittedLaserScanCSVToMatFiles('$1/hokuyo_parts/');exit;"

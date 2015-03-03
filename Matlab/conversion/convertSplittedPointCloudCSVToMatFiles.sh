#!/usr/bin/env bash
# Note: this is a quick script to help me for conversion: MAKE SURE PATHS ARE OK FOR YOUR ENVIRONMENT

currentDir=$(pwd)/

echo "Convert velodyne..."
/usr/local/MATLAB/R2013a/bin/matlab -nojvm -nodisplay -r "cd $currentDir;convertSplittedPointCloudCSVToMatFiles('$1/velodyne_parts/');exit;"


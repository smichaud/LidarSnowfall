clear all;
close all;
clc;

addpath(genpath('.'));

testFile = './data/testVelodyne.csv';
[data header] = parseRawCSV(testFile);
dataStruct = createPointCloudStruct(header, data);

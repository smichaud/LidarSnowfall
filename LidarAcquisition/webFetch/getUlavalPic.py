#!/usr/bin/python
import os, sys, time

def main():
    index = 0;
    while 1:        
        os.system("wget --output-document=/home/edminster/Desktop/Test/pic" + str(index) + ".jpg http://meteo-laval-web.gel.ulaval.ca/getCamera.php");
        time.sleep(5);
        index = index+1;

if __name__=="__main__":
   main()

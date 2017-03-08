#!/bin/bash

set -e

#read output file name
function outputFileName(){
  echo "digit output file name:"
  read -e output
}

#read input files names
function inputFileName(){
  echo "digit input file names:"
  read -e inputs
}

#show the help
function showHelp(){
	echo "
This is a script for help printing operation in laboratories of unipd.
It allows to concatenate multiple PDF files and put 1, 2 or 4 slides per page.

usage: ./perStampaTorre.sh [-h] [<args>]
    where:
          -h show this help
          <args> could be formatted as: 
             1. inputFile1.pdf ... inputFileN.pdf outputFileName.pdf
             2. inputFile1.pdf ... inputFileN.pdf 
                in this case during the script the name of output file is asked
             if no args are passed to the script the name of input and output files are asked during the script

The number of slides per pages is asked during the script. The possibilities are:
1 -> means 1 slide per page

2 -> means 2 slides per pages, with landscape orientation
         |----------|----------|
         |          |          |
         |    S1    |    S2    |
         |          |          |
         |----------|----------|


4 -> means 4 slides per pages, with landscape orientation
         |----------|----------|
         |    S1    |    S2    |
         |----------|----------|
         |    S3    |    S4    |
         |----------|----------|

    "
}

# check if help is wanted or script is runned
if [ "$1" == "-h" ] || [ "$1" == "--help" ]
  then
    showHelp
  else
	#check if there is one or two arguments
	echo $1
	if [ -z "$1" ] || [ -z "$2" ]
	  then
	    #if there is no arguments
	    if [ -z "$1" ]
	      then
	        inputFileName
		outputFileName
	    else
	    #there is only one argument -> assumed that output file name is missing
		outputFileName
	    fi
	  else
	    inputs=""
	    output=""
	    counter=0
	    outputNumber=$(($#-1))
	    for var in "$@"
	    do
	      if [ $counter -eq $outputNumber ]
	        then
	          output=$var
	        else
	          inputs=$inputs" "$var
	      fi
	      counter=$(($counter+1))
	    done
	fi

	echo "insert number of slides for pages (1-2-4):"
	read number
	if [ $number -eq 1 ] || [ -z "$number" ]
	  then
	  	# 1 slide per page -> only concatenation is performed
	    pdftk $inputs cat output $output
	  elif [ $number -eq 2 ]; then
	    # 2 slides per page
	    pdftk $inputs cat output $output
	    temp="temp"$output
	    pdfnup -o $temp $output
	    rm $output
	    pdftk A=$temp shuffle AoddEast AevenWest output $output
	    rm
	  elif [ $number -eq 4 ]; then
	    # 3 slides per page
	    temp="temp"$output
	    pdftk $inputs cat output $temp
	    temp2="temp"$temp
	    pdfjam $temp --nup 2x2 --landscape --outfile $temp2
	    pdftk A=$temp2 shuffle AoddEast AevenWest output $output
	    rm $temp
	    rm $temp2
	  else
	  	# if number different from 1,2 and 4 or a string is inserted
	    echo "Number not supported yet"
	fi
fi





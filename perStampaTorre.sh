#!/bin/bash

set -e

function outputFileName(){
  echo "digit output file name:"
  read output
}

function inputFileName(){
  echo "digit input file names:"
  read inputs
}

if [ -z "$1" ] || [ -z "$2" ]
  then
    if [ -z "$1" ]
      then
        inputFileName
	outputFileName
    else
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
if [ $number -eq 1 ]
  then
    pdftk $inputs cat output $output
  elif [ $number -eq 2 ]
    pdftk $inputs cat output $output
    temp="temp"$output
    pdfnup -o $temp $output
    rm $output
    pdftk A=$temp shuffle AoddEast AevenWest output $output
  elif [ $number -eq 4 ]
    temp="temp"$output
    pdftk $inputs cat output $temp
    temp2="temp"$temp
    pdfjam $temp --nup 2x2 --landscape --outfile $temp2
    pdftk A=$temp2 shuffle AoddEast AevenWest output $output
    rm $temp
    rm $temp2
  else
    echo "Number not supported yet"
fi


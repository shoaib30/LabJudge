#!/usr/bin/env bash

labCode=$1
qno=$2
cd ~/Documents/Programming/JavaProject/LabJudge/data/labs/

g++ -o $labCode/$qno/solutions/source.out $labCode/$qno/solutions/source.cpp
./$labCode/$qno/solutions/source.out < $labCode/$qno/testcases/test1.txt > $labCode/$qno/solutions/1_solution.txt
./$labCode/$qno/solutions/source.out < $labCode/$qno/testcases/test2.txt > $labCode/$qno/solutions/2_solution.txt

rm $labCode/$qno/solutions/source.out

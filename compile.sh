#!/usr/bin/env bash

usn=$1
labCode=$2
qno=$3
cd ~/Documents/Programming/JavaProject/LabJudge/data/labs/

g++ -o $labCode/$qno/submissions/outputs/$usn.out $labCode/$qno/submissions/$usn.cpp
./$labCode/$qno/submissions/outputs/$usn.out < $labCode/$qno/testcases/test1.txt > $labCode/$qno/submissions/outputs/1_$usn.txt
./$labCode/$qno/submissions/outputs/$usn.out < $labCode/$qno/testcases/test2.txt > $labCode/$qno/submissions/outputs/2_$usn.txt

if diff -qs $labCode/$qno/solutions/1_solution.txt $labCode/$qno/submissions/outputs/1_$usn.txt >/dev/null
    then
    if diff -qs $labCode/$qno/solutions/2_solution.txt $labCode/$qno/submissions/outputs/2_$usn.txt >/dev/null
        then
        echo "1"
    else
        echo "0"
    fi
else
    echo "0"
fi

rm $labCode/$qno/submissions/outputs/$usn.out
rm $labCode/$qno/submissions/outputs/1_$usn.txt
rm $labCode/$qno/submissions/outputs/2_$usn.txt

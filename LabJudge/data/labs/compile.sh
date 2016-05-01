#!/usr/bin/env bash
pwd
usn=$1
labCode=$2
qno=$3
cd ~/Documents/Programming/JavaProject/LabJudge/data/labs/
pwd
g++ -o $labCode/$qno/submissions/outputs/1_$usn.out $labCode/$qno/submissions/$usn.cpp < $labCode/$qno/testcases/test1.txt
./$labCode/$qno/submissions/outputs/1_$usn.out > $labCode/$qno/submissions/outputs/1_$usn.txt
g++ -o $labCode/$qno/submissions/outputs/2_$usn.out $labCode/$qno/submissions/$usn.cpp < $labCode/$qno/testcases/test2.txt
./$labCode/$qno/submissions/outputs/2_$usn.out > $labCode/$qno/submissions/outputs/2_$usn.txt

if diff -qs $labCode/$qno/solutions/1_solution.txt $labCode/$qno/submissions/outputs/1_$usn.txt >/dev/null
    then
    if diff -qs $labCode/$qno/solutions/2_solution.txt $labCode/$qno/submissions/outputs/2_$usn.txt >/dev/null
        then
        echo "correct bitches"
    else
        echo "wrong:("
    fi
else
    echo "Wrong"
fi

rm $labCode/$qno/submissions/outputs/1_$usn.out
rm $labCode/$qno/submissions/outputs/1_$usn.txt
rm $labCode/$qno/submissions/outputs/2_$usn.out
rm $labCode/$qno/submissions/outputs/2_$usn.txt

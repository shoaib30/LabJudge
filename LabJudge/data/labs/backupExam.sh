#!/usr/bin/env bash
labCode=$1
cd ~/Documents/Programming/JavaProject/LabJudge/data/labs/

zip -r $labCode $labCode 

rm -R $labCode
mv $labCode.zip ../backups

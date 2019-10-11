#!/bin/bash

PFAD=system/controlDict
EXCL=10

# cat   list a files content on a screen / in a pipeline (using "|")
# grep  returns all lines matching a certain string
# cut   cuts out e.g. fields "-f" (here 3rd until END [-]) specified through delminiter "-d' '" (here blanks)
# sed   remove complete lines containing a certain string (here "ClockTime")
# sed-i includes Header
# head  deletes last 10 lines (for scaling reasons, as last lines are often already diverged)
# tr    remove certain strings (here "(" and ")")
#paste  merge two files line by line



cat $PFAD | grep 'end     (' | tr -d ';'| tr -d '('| tr -d ')' | cut -d' ' -f23- > postProcessing/sensorPos

cat $PFAD | grep 'endTime' | sed '/stopAt/d'| tr -d ';' | cut -d' ' -f10- > test1.dat

cat $PFAD | grep 'writeInterval' |  tr -d ';'  | sed '2d'  | cut -d' ' -f3-> test2.dat



paste test1.dat test2.dat > postProcessing/sensorInfo


rm test1.dat test2.dat 

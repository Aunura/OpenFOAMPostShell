#!/bin/bash

PFAD=log.floatingObject
EXCL=10

# cat   list a files content on a screen / in a pipeline (using "|")
# grep  returns all lines matching a certain string
# cut   cuts out e.g. fields "-f" (here 3rd until END [-]) specified through delminiter "-d' '" (here blanks)
# sed   remove complete lines containing a certain string (here "ClockTime")
# sed-i includes Header
# head  deletes last 10 lines (for scaling reasons, as last lines are often already diverged)
# tr    remove certain strings (here "(" and ")")
#paste  merge two files line by line

################ CLEAR OLD DATA ################
rm -r data
mkdir data
##################### TIME #####################
cat $PFAD | grep 'Time = ' | cut -d' ' -f3- | sed '/ClockTime/d' > Time.dat

##################### TIME #####################
cat $PFAD | grep 'PIMPLE: iteration '| tr -d 'PIMPLE: iteration:'    > Pimple.dat

############### LINEAR VELOCITY ################
cat $PFAD | grep 'Linear velocity: '  | tr -d '(' | tr -d ')'| cut -d' ' -f7- | tr -d '(' | tr -d ')' > LV.dat

awk -F " " '{print $1}' LV.dat > LV21.dat
awk -F " " '{print $2}' LV.dat > LV22.dat
awk -F " " '{print $3}' LV.dat > LV23.dat
paste Pimple.dat LV21.dat LV22.dat LV23.dat > LinearVelocityFinal1.dat
awk '$1==1'  LinearVelocityFinal1.dat > LinearVelocityFinal2.dat
awk '{$1="";print $0}' LinearVelocityFinal2.dat > LinearVelocityFinal3.dat
paste Time.dat LinearVelocityFinal3.dat > data/LinearVelocity.dat

rm LV.dat LV21.dat LV22.dat LV23.dat LinearVelocityFinal1.dat LinearVelocityFinal2.dat LinearVelocityFinal3.dat 

############### ANGULAR VELOCITY ################
cat $PFAD | grep 'Angular velocity: '  | tr -d '(' | tr -d ')'| cut -d' ' -f7- | tr -d '(' | tr -d ')' > AN.dat

awk -F " " '{print $1}' AN.dat > AN21.dat
awk -F " " '{print $2}' AN.dat > AN22.dat
awk -F " " '{print $3}' AN.dat > AN23.dat
paste Pimple.dat AN21.dat AN22.dat AN23.dat > AngularVelocityFinal1.dat
awk '$1==1'  AngularVelocityFinal1.dat > AngularVelocityFinal2.dat
awk '{$1="";print $0}' AngularVelocityFinal2.dat > AngularVelocityFinal3.dat
paste Time.dat AngularVelocityFinal3.dat > data/AngularVelocity.dat

rm AN.dat AN21.dat AN22.dat AN23.dat AngularVelocityFinal1.dat AngularVelocityFinal2.dat AngularVelocityFinal3.dat 

############### CENTEROFROTATION ################
cat $PFAD | grep 'Centre of rotation: '  | tr -d '(' | tr -d ')'| cut -d' ' -f8- | tr -d '(' | tr -d ')' > COR.dat

awk -F " " '{print $1}' COR.dat > COR21.dat
awk -F " " '{print $2}' COR.dat > COR22.dat
awk -F " " '{print $3}' COR.dat > COR23.dat
paste Pimple.dat COR21.dat COR22.dat COR23.dat > CentreOfRotationFinal1.dat
awk '$1==1'  CentreOfRotationFinal1.dat > CentreOfRotationFinal2.dat
awk '{$1="";print $0}' CentreOfRotationFinal2.dat > CentreOfRotationFinal3.dat
paste Time.dat CentreOfRotationFinal3.dat > data/CentreOfRotation.dat

rm COR.dat COR21.dat COR22.dat COR23.dat CentreOfRotationFinal1.dat CentreOfRotationFinal2.dat CentreOfRotationFinal3.dat 

############### ORIENTATION  ###############
cat $PFAD | grep 'Orientation' | tr -d '(' | tr -d ')' | cut -d' ' -f6-> orientationTemp1.dat
awk -F " " '{print $1}' orientationTemp1.dat > OR11.dat
awk -F " " '{print $2}' orientationTemp1.dat > OR12.dat
awk -F " " '{print $3}' orientationTemp1.dat > OR13.dat
awk -F " " '{print $4}' orientationTemp1.dat > OR21.dat
awk -F " " '{print $5}' orientationTemp1.dat > OR22.dat
awk -F " " '{print $6}' orientationTemp1.dat > OR23.dat
awk -F " " '{print $7}' orientationTemp1.dat > OR31.dat
awk -F " " '{print $8}' orientationTemp1.dat > OR32.dat
awk -F " " '{print $9}' orientationTemp1.dat > OR33.dat
paste Pimple.dat OR11.dat OR12.dat OR13.dat OR21.dat OR22.dat OR23.dat OR31.dat OR32.dat OR33.dat> orientationTemp2.dat
awk '$1==1'  orientationTemp2.dat > orientationTemp3.dat
awk '{$1="";print $0}' orientationTemp3.dat > orientationTemp4.dat
paste Time.dat orientationTemp4.dat > data/Orientation.dat

rm OR11.dat OR12.dat OR13.dat OR21.dat OR22.dat OR23.dat OR31.dat OR32.dat OR33.dat orientationTemp1.dat orientationTemp2.dat orientationTemp3.dat orientationTemp4.dat


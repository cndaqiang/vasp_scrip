#!/bin/bash
#清空comment
echo > comment
for i in 0.10 0.12 0.14 0.16 0.18 0.20 0.22 0.24 0.26 0.28 0.30
do
cat >INCAR<<!
SYSTEM = bcc Fe
ENCUT = 450 eV
GGA=91
ISTART=0;ICHARG=2
ISMEAR = 0;SIGMA=$i
PREC=Accurate
!
echo "SIGMA=$i ev";time mpirun -np 2 run_vasp.sh
TS=`grep "EENTRO" OUTCAR | tail -1|awk '{printf"%12.6f \n",$5}'`
#$5表示第5个元素
echo SIGMA = $i TS = $TS >> comment
done
cat comment
#!/bin/bash
#清空comment
echo > comment
for i in 300 350 400 450 500
do
cat >INCAR<<!
SYSTEM = Cu
ENCUT = $i eV
GGA=91
ISTART=0;ICHARG=2
ISMEAR = -5
PREC=Accurate
!
echo "ENCUT=$i ev";time mpirun -np 2 run_vasp.sh > Log
E=`grep "TOTEN" OUTCAR | tail -1|awk '{printf"%12.6f \n",$5}'`
#$5表示第5个元素
echo $i eV $E eV >> comment
done
cat comment
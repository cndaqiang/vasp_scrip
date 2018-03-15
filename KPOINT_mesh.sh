#!/bin/bash
#清空comment
echo > comment
for i in 6 7 8 9 10
do
cat >KPOINT<<!
Auto
0
M
$i $i $i
0 0 0
!
echo "k mesh $i x $i x $i";time mpirun -np 4 run_vasp.sh > log
E=`grep "TOTEN" OUTCAR | tail -1|awk '{printf"%12.6f",$5}'`
KP=`grep "irreducible" OUTCAR | tail -1|awk '{printf"%5i \n",$2}'`
#$2表示第2个元素
echo $i eV $E eV $KP >> comment
done
cat comment
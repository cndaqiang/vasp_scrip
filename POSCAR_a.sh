echo > comment
for i in `seq 3.60 0.05 4.5`
do
#POSCAR修改自VESTA导出的POSCAR,替换缩放系数
cat >POSCAR<<!
Al
$i
        1.0000000000         0.0000000000         0.0000000000
        0.0000000000         1.0000000000         0.0000000000
        0.0000000000         0.0000000000         1.0000000000
   Al
    4
Direct
     0.000000000         0.000000000         0.000000000
     0.000000000         0.500000000         0.500000000
     0.500000000         0.000000000         0.500000000
     0.500000000         0.500000000         0.000000000
!
echo "a=$i";time mpirun -np 4 run_vasp.sh > /tmp/cqiang_Log
E=`grep "TOTEN" OUTCAR | tail -1|awk '{printf"%12.6f \n",$5}'`
#$5表示第5个元素
echo a=$i E=$E eV >> comment
done
cat comment

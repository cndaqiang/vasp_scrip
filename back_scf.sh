#静态自恰scf后备份
mkdir scf
tar czvf chg.tgz CHG*
cp INCAR KPOINTS POSCAR POTCAR OUTCAR chg.tgz scf/.


# 计算能带用
## 费米能级
```
Fermi=`grep "E-fermi" OUTCAR|awk '{print $3}'`
```
4.X的OUTCAR中只会出现一次E-fermi<br>
5.X的fermi每一轮scf都会输出，故需要取最后最后一个。
## NIONS,NELECT
NBANDS（默认值为NELECT/2+NIONS/2，NELECT和NIONS分别为电子数和离子数，可以上一步自洽计算产生的OUTCAR文件中找到这两个参数
```
grep "NIONS" OUTCAR
grep "NELECT" OUTCAR
```

# 优化后体系总能量
## 当ISMEAR = -5时，Free energy TOTEN是与energy without entropy是相等
```
grep "TOTEN" OUTCAR | tail -1
  free  energy   TOTEN  =       -42.90377072 eV
```
只显示能量
```
E=`grep "TOTEN" OUTCAR | tail -1|awk '{printf"%12.6f \n",$5}'`
```
# 每一次自洽计算后的总能量
```
grep "TOTEN" OUTCAR
```
# 
### 当ISMEAR等于其他的值时，Free energy TOTEN是与energy without entropy是不相等，则用
```
grep "energy without entropy" OUTCAR | tail -1
  energy without entropy =      -42.90509080  energy(sigma->0) =      -42.90421075
```
在计算体系的结合能时，体系的总能取为energy without entropy后面的值。

# 体积
```
grep "volume" OUTCAR
  volume/ion in A,a.u.               =      20.80       140.34
  volume of cell :      166.38
  volume of cell :      166.38
```
第一行给出体系的体积分别以Å3/atom, a.u.3/atom为单位给出的<br>
第二行给出体系的体积是以Å3/unit cell为单位给出的

# 体系中原子受力
搜索`TOTAL-FORCE`
# 倒格基失
搜索`reciprocal lattice vectors`

# 判断体系是否收敛
```
grep "reached required accuracy" OUTCAR
 reached required accuracy - stopping structural energy minimisation
```
# 计算用时
```
grep "User" OUTCAR | awk '{print $4}'
```
# K点个数
```
grep "irreducible k-points:" $ROOTDIR/$i/OUTCAR | awk '{print $2}'
```
# 震动频率
以单位提取，包含虚频
```
grep THz OUTCAR
grep 2PiTHz OUTCAR
grep cm-1 OUTCAR
grep meV OUTCAR
```
如
```
grep THz OUTCAR
23 f  =    0.656543 THz     4.125179 2PiTHz   21.899904 cm-1     2.715243 meV
  24 f  =    0.199774 THz     1.255217 2PiTHz    6.663740 cm-1     0.826199 meV
  25 f/i=    0.036471 THz     0.229153 2PiTHz    1.216534 cm-1     0.150831 meV
  26 f/i=    0.831955 THz     5.227327 2PiTHz   27.751028 cm-1     3.440690 meV
  27 f/i=    1.329200 THz     8.351613 2PiTHz   44.337352 cm-1     5.497133 meV
```
不提取虚频
```
grep "f  =    " OUTCAR
```
震动能量求和(需安装yum install bc)
```
grep 'f  =' OUTCAR | awk '{print $10}' |paste -sd+ | bc
```
上调命令计算结果为hv[meV],零点能=1/2hv=计算结果/2000[eV]




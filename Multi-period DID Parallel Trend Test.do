**事件研究平行趋势检验
**打开数据表，做政策前4期，政策后10期的平行趋势检验。

** pm2.5
clear
use"C:\Users\93285\Desktop\论文\地级市县域\地级市县域.dta"

xtset id year

gen event= year - time2
replace event = -4 if event <= -4
replace event=8 if event>8
tab event

**政策前
forvalues i=4(-1)1{
  gen pre`i'=(event==-`i')
}

gen current= (event==0)

**政策后
forvalues i=1(1)8{
  gen post`i'=(event==`i')
}

drop pre4 //将政策前第一期作为基准组，很重要！！！否则会有多重线性

**做回归
global C " lngre lninf lngov lnpop lnedu " //将控制变量集合成X，下面的方法二选一
xtreg epm1 pre* current post* i.year $C, fe vce(cluster id )

*绘图
coefplot, baselevels ///
keep(pre* current post*) ///
vertical ///转置图形
coeflabels( pre10 = "-10" ///
pre9 = "-9" ///
pre8 = "-8" ///
pre7 = "-7" ///
pre6 = "-6" ///
pre5 = "-5" ///
pre4 = "-4" ///
pre3 = "-3" ///
pre2 = "-2" ///
pre1 = "-1" ///
current = "0" ///
post1 = "1" ///
post2 = "2" ///
post3 = "3" ///
post4 = "4" ///
post5 = "5" ///
post5 = "5" ///
post6 = "6" ///
post7 = "7" ///
post8 = "8" ///
post9 = "9" ///
post10 = "10" ///
) ///
yline(0,lcolor(edkblue*0.8)) ///加入y=0这条虚线
ylabel(-0.1(0.05)0.1) ///***根据处理效应估计值【置信区间上限值的大小】设置纵坐标范围和间隔
xline(4, lwidth(vthin) lpattern(dash) lcolor(teal)) ///***画垂直于横轴的基期的虚线，x=10即从最小的年份开始数，到基期的需要10个数
ylabel(,labsize(*0.75)) xlabel(,labsize(*0.75)) ///
ytitle("Coefficient", size(small)) ///加入Y轴标题,大小small
xtitle("Years relative to pilot year", size(small)) ///加入X轴标题，大小small 
addplot(line @b @at) ///增加点之间的连线
ciopts(lpattern(dash) recast(rcap) msize(medium)) ///CI为虚线上下封口
msymbol(circle_hollow) ///plot空心格式
scheme(s1mono)

** co2
clear
use"C:\Users\93285\Desktop\论文\地级市县域\地级市县域.dta"

xtset id year

gen event= year - time2
replace event = -4 if event <= -4
replace event=8 if event>8
tab event

**政策前
forvalues i=4(-1)1{
  gen pre`i'=(event==-`i')
}

gen current= (event==0)

**政策后
forvalues i=1(1)8{
  gen post`i'=(event==`i')
}

drop pre4 //将政策前第一期作为基准组，很重要！！！否则会有多重线性

**做回归
global C " lngre lninf lngov lnpop lnedu "  //将控制变量集合成X，下面的方法二选一
xtreg ece1 pre* current post* i.year $C, fe vce(cluster id )

*绘图
coefplot, baselevels ///
keep(pre* current post*) ///
vertical ///转置图形
coeflabels( pre10 = "-10" ///
pre9 = "-9" ///
pre8 = "-8" ///
pre7 = "-7" ///
pre6 = "-6" ///
pre5 = "-5" ///
pre4 = "-4" ///
pre3 = "-3" ///
pre2 = "-2" ///
pre1 = "-1" ///
current = "0" ///
post1 = "1" ///
post2 = "2" ///
post3 = "3" ///
post4 = "4" ///
post5 = "5" ///
post5 = "5" ///
post6 = "6" ///
post7 = "7" ///
post8 = "8" ///
post9 = "9" ///
post10 = "10" ///
post10 = "11" ///
post10 = "12" ///
) ///
yline(0,lcolor(edkblue*0.8)) ///加入y=0这条虚线
ylabel(-0.1(0.05)0.1) ///***根据处理效应估计值【置信区间上限值的大小】设置纵坐标范围和间隔
xline(4, lwidth(vthin) lpattern(dash) lcolor(teal)) ///***画垂直于横轴的基期的虚线，x=10即从最小的年份开始数，到基期的需要10个数
ylabel(,labsize(*0.75)) xlabel(,labsize(*0.75)) ///
ytitle("Coefficient", size(small)) ///加入Y轴标题,大小small
xtitle("Years relative to pilot year", size(small)) ///加入X轴标题，大小small 
addplot(line @b @at) ///增加点之间的连线
ciopts(lpattern(dash) recast(rcap) msize(medium)) ///CI为虚线上下封口
msymbol(circle_hollow) ///plot空心格式
scheme(s1mono)

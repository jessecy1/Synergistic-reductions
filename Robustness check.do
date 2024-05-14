
*-数据缩尾处理
use "C:\Users\93285\Desktop\论文\地级市县域\地级市县域.dta", replace
winsor2 epm1 ece1 lngre lninf lngov lnpop lnedu, replace cuts(1 99)
xtset id year
global C " lngre lninf lngov lnpop lnedu "

reghdfe epm1 did2 , absorb(id year) vce(cluster id )
outreg2 using"1235.doc", replace se bdec(3) tdec(3) ctitle(PM2.5) addtext(yearfix,YES,idfix,YES)
reghdfe epm1 did2 $C, absorb(id year) vce(cluster id )
outreg2 using"1235.doc", append se bdec(3) tdec(3) ctitle(PM2.5) addtext(yearfix,YES,idfix,YES)
reghdfe ece1 did2 , absorb(id year) vce(cluster id )
outreg2 using"1235.doc", append se bdec(3) tdec(3) ctitle(CO2)  addtext(yearfix,YES,idfix,YES)
reghdfe ece1 did2 $C, absorb(id year) vce(cluster id )
outreg2 using"1235.doc", append se bdec(3) tdec(3) ctitle(CO2)  addtext(yearfix,YES,idfix,YES)

*-剔除特殊样本
*-包头 辽源 南平 东莞2015年批设，批设时间较迟，政策时间短
use "C:\Users\93285\Desktop\论文\地级市县域\地级市县域.dta", replace
drop if id == 4
drop if id == 6
drop if id == 14
drop if id == 19

xtset id year
global C " lngre lninf lngov lnpop lnedu "

reghdfe epm1 did2 , absorb(id year) vce(cluster id )
outreg2 using"1235.doc", replace se bdec(3) tdec(3) ctitle(PM2.5) addtext(yearfix,YES,idfix,YES)
reghdfe epm1 did2 $C, absorb(id year) vce(cluster id )
outreg2 using"1235.doc", append se bdec(3) tdec(3) ctitle(PM2.5) addtext(yearfix,YES,idfix,YES)
reghdfe ece1 did2 , absorb(id year) vce(cluster id )
outreg2 using"1235.doc", append se bdec(3) tdec(3) ctitle(CO2)  addtext(yearfix,YES,idfix,YES)
reghdfe ece1 did2 $C, absorb(id year) vce(cluster id )
outreg2 using"1235.doc", append se bdec(3) tdec(3) ctitle(CO2)  addtext(yearfix,YES,idfix,YES)


*-排除2010和2012低碳城市试点
use "C:\Users\93285\Desktop\论文\地级市县域\地级市县域.dta", replace

gen carbon = 0
replace carbon = 1 if id == 10 & year > 2012
replace carbon = 1 if id == 14 & year > 2012
replace carbon = 1 if id == 25 & year > 2010
replace carbon = 1 if id == 27 & year > 2012
replace carbon = 1 if id == 49 & year > 2012
replace carbon = 1 if id == 63 & year > 2012
replace carbon = 1 if id == 65 & year > 2012
replace carbon = 1 if id == 68 & year > 2012
replace carbon = 1 if id == 73 & year > 2012
replace carbon = 1 if id == 84 & year > 2010
replace carbon = 1 if id == 85 & year > 2012
replace carbon = 1 if id == 117 & year > 2010
replace carbon = 1 if id == 150 & year > 2012
replace carbon = 1 if id == 162 & year > 2012
replace carbon = 1 if id == 174 & year > 2012
replace carbon = 1 if id == 176 & year > 2012
replace carbon = 1 if id == 194 & year > 2012
replace carbon = 1 if id == 206 & year > 2012
replace carbon = 1 if id == 211 & year > 2012
replace carbon = 1 if id == 194 & year > 2012

xtset id year
global C " lngre lninf lngov lnpop lnedu "

reghdfe epm1 did2 carbon, absorb(id year) vce(cluster id )
outreg2 using"1235.doc", replace se bdec(3) tdec(3) ctitle(PM2.5) addtext(yearfix,YES,idfix,YES)
reghdfe epm1 did2 carbon $C, absorb(id year) vce(cluster id )
outreg2 using"1235.doc", append se bdec(3) tdec(3) ctitle(PM2.5) addtext(yearfix,YES,idfix,YES)
reghdfe ece1 did2 carbon, absorb(id year) vce(cluster id )
outreg2 using"1235.doc", append se bdec(3) tdec(3) ctitle(CO2)  addtext(yearfix,YES,idfix,YES)
reghdfe ece1 did2 carbon $C, absorb(id year) vce(cluster id )
outreg2 using"1235.doc", append se bdec(3) tdec(3) ctitle(CO2)  addtext(yearfix,YES,idfix,YES)


*-排除2013年智慧城市(排除市级的试点)
use "C:\Users\93285\Desktop\论文\地级市县域\地级市县域.dta", replace

gen smart = 0
replace smart = 1 if id == 3 & year > 2012
replace smart = 1 if id == 18 & year > 2012
replace smart = 1 if id == 23 & year > 2012
replace smart = 1 if id == 54 & year > 2012
replace smart = 1 if id == 74 & year > 2012
replace smart = 1 if id == 83 & year > 2012
replace smart = 1 if id == 88 & year > 2012
replace smart = 1 if id == 108 & year > 2012
replace smart = 1 if id == 132 & year > 2012
replace smart = 1 if id == 137 & year > 2012
replace smart = 1 if id == 149 & year > 2012
replace smart = 1 if id == 151 & year > 2012
replace smart = 1 if id == 174 & year > 2012
replace smart = 1 if id == 176 & year > 2012
replace smart = 1 if id == 177 & year > 2012
replace smart = 1 if id == 185 & year > 2012
replace smart = 1 if id == 186 & year > 2012
replace smart = 1 if id == 188 & year > 2012
replace smart = 1 if id == 189 & year > 2012
replace smart = 1 if id == 191 & year > 2012
replace smart = 1 if id == 194 & year > 2012
replace smart = 1 if id == 196 & year > 2012
replace smart = 1 if id == 199 & year > 2012
replace smart = 1 if id == 206 & year > 2012
replace smart = 1 if id == 212 & year > 2012
replace smart = 1 if id == 220 & year > 2012
replace smart = 1 if id == 222 & year > 2012
replace smart = 1 if id == 223 & year > 2012
replace smart = 1 if id == 225 & year > 2012

xtset id year
global C " lngre lninf lngov lnpop lnedu "

reghdfe epm1 did2 smart, absorb(id year) vce(cluster id )
outreg2 using"1235.doc", replace se bdec(3) tdec(3) ctitle(PM2.5) addtext(yearfix,YES,idfix,YES)
reghdfe epm1 did2 smart $C, absorb(id year) vce(cluster id )
outreg2 using"1235.doc", append se bdec(3) tdec(3) ctitle(PM2.5) addtext(yearfix,YES,idfix,YES)
reghdfe ece1 did2 smart, absorb(id year) vce(cluster id )
outreg2 using"1235.doc", append se bdec(3) tdec(3) ctitle(CO2)  addtext(yearfix,YES,idfix,YES)
reghdfe ece1 did2 smart $C, absorb(id year) vce(cluster id )
outreg2 using"1235.doc", append se bdec(3) tdec(3) ctitle(CO2)  addtext(yearfix,YES,idfix,YES)


*-排除2013年资源型城市可持续发展
use "C:\Users\93285\Desktop\论文\地级市县域\地级市县域.dta", replace

gen energy = 0
replace energy = 1 if id == 2 & year > 2012
replace energy = 1 if id == 3 & year > 2012
replace energy = 1 if id == 4 & year > 2012
replace energy = 1 if id == 6 & year > 2012
replace energy = 1 if id == 13 & year > 2012
replace energy = 1 if id == 14 & year > 2012
replace energy = 1 if id == 15 & year > 2012
replace energy = 1 if id == 16 & year > 2012
replace energy = 1 if id == 17 & year > 2012
replace energy = 1 if id == 21 & year > 2012
replace energy = 1 if id == 22 & year > 2012
replace energy = 1 if id == 23 & year > 2012
replace energy = 1 if id == 24 & year > 2012
replace energy = 1 if id == 28 & year > 2012
replace energy = 1 if id == 30 & year > 2012
replace energy = 1 if id == 32 & year > 2012
replace energy = 1 if id == 33 & year > 2012
replace energy = 1 if id == 34 & year > 2012
replace energy = 1 if id == 38 & year > 2012
replace energy = 1 if id == 40 & year > 2012
replace energy = 1 if id == 41 & year > 2012
replace energy = 1 if id == 44 & year > 2012
replace energy = 1 if id == 47 & year > 2012
replace energy = 1 if id == 48 & year > 2012
replace energy = 1 if id == 49 & year > 2012
replace energy = 1 if id == 50 & year > 2012
replace energy = 1 if id == 52 & year > 2012
replace energy = 1 if id == 56 & year > 2012
replace energy = 1 if id == 57 & year > 2012
replace energy = 1 if id == 58 & year > 2012
replace energy = 1 if id == 59 & year > 2012
replace energy = 1 if id == 60 & year > 2012
replace energy = 1 if id == 61 & year > 2012
replace energy = 1 if id == 62 & year > 2012
replace energy = 1 if id == 70 & year > 2012
replace energy = 1 if id == 71 & year > 2012
replace energy = 1 if id == 72 & year > 2012
replace energy = 1 if id == 73 & year > 2012
replace energy = 1 if id == 77 & year > 2012
replace energy = 1 if id == 80 & year > 2012
replace energy = 1 if id == 85 & year > 2012
replace energy = 1 if id == 86 & year > 2012
replace energy = 1 if id == 88 & year > 2012
replace energy = 1 if id == 89 & year > 2012
replace energy = 1 if id == 91 & year > 2012
replace energy = 1 if id == 92 & year > 2012
replace energy = 1 if id == 99 & year > 2012
replace energy = 1 if id == 103 & year > 2012
replace energy = 1 if id == 106 & year > 2012
replace energy = 1 if id == 110 & year > 2012
replace energy = 1 if id == 115 & year > 2012
replace energy = 1 if id == 139 & year > 2012
replace energy = 1 if id == 140 & year > 2012
replace energy = 1 if id == 141 & year > 2012
replace energy = 1 if id == 147 & year > 2012
replace energy = 1 if id == 148 & year > 2012
replace energy = 1 if id == 150 & year > 2012
replace energy = 1 if id == 153 & year > 2012
replace energy = 1 if id == 155 & year > 2012
replace energy = 1 if id == 158 & year > 2012
replace energy = 1 if id == 159 & year > 2012
replace energy = 1 if id == 160 & year > 2012
replace energy = 1 if id == 163 & year > 2012
replace energy = 1 if id == 169 & year > 2012
replace energy = 1 if id == 170 & year > 2012
replace energy = 1 if id == 174 & year > 2012
replace energy = 1 if id == 176 & year > 2012
replace energy = 1 if id == 177 & year > 2012
replace energy = 1 if id == 178 & year > 2012
replace energy = 1 if id == 179 & year > 2012
replace energy = 1 if id == 182 & year > 2012
replace energy = 1 if id == 183 & year > 2012
replace energy = 1 if id == 186 & year > 2012
replace energy = 1 if id == 186 & year > 2012
replace energy = 1 if id == 188 & year > 2012
replace energy = 1 if id == 189 & year > 2012
replace energy = 1 if id == 190 & year > 2012
replace energy = 1 if id == 191 & year > 2012
replace energy = 1 if id == 192 & year > 2012
replace energy = 1 if id == 193 & year > 2012
replace energy = 1 if id == 194 & year > 2012
replace energy = 1 if id == 201 & year > 2012
replace energy = 1 if id == 203 & year > 2012
replace energy = 1 if id == 208 & year > 2012
replace energy = 1 if id == 211 & year > 2012
replace energy = 1 if id == 214 & year > 2012
replace energy = 1 if id == 215 & year > 2012
replace energy = 1 if id == 216 & year > 2012
replace energy = 1 if id == 217 & year > 2012
replace energy = 1 if id == 224 & year > 2012
replace energy = 1 if id == 228 & year > 2012
replace energy = 1 if id == 231 & year > 2012
replace energy = 1 if id == 232 & year > 2012

xtset id year
global C " lngre lninf lngov lnpop lnedu "

reghdfe epm1 did2 energy, absorb(id year) vce(cluster id )
outreg2 using"1235.doc", replace se bdec(3) tdec(3) ctitle(PM2.5) addtext(yearfix,YES,idfix,YES)
reghdfe epm1 did2 energy $C, absorb(id year) vce(cluster id )
outreg2 using"1235.doc", append se bdec(3) tdec(3) ctitle(PM2.5) addtext(yearfix,YES,idfix,YES)
reghdfe ece1 did2 energy, absorb(id year) vce(cluster id )
outreg2 using"1235.doc", append se bdec(3) tdec(3) ctitle(CO2)  addtext(yearfix,YES,idfix,YES)
reghdfe ece1 did2 energy $C, absorb(id year) vce(cluster id )
outreg2 using"1235.doc", append se bdec(3) tdec(3) ctitle(CO2)  addtext(yearfix,YES,idfix,YES)

*-安慰剂检验pm2.5
  cd "C:\Users\93285\Desktop\论文\地级市县域"

**# 基础回归

  use 地级市县域.dta, clear

  global C " lngre lninf lngov lnpop lnedu " 
  reghdfe ece1 did2 $C , absorb(id year) vce(cluster id )

*- 基础回归中核心变量dudt的真实系数与真实t值分别为：
*- 真实系数 = 0.030(pm2.5) 0.015(co2)
*- 真实t值  = 
  cd "C:\Users\93285\Desktop\论文\地级市县域"

clear
set matsize 5000
mat b = J(500,1,0)
mat se = J(500,1,0)
mat p = J(500,1,0)

forvalues i=1/500{
	use 地级市县域.dta, clear 
	xtset id year
	keep if year==2004
	sample 65, count
	keep id
	save "atchcity.dta",replace
	merge 1:m id using 地级市县域.dta
	gen groupnew=(_merge==3) //生成伪处理组的虚拟变量
	save "matchcity`i'.dta",replace
		
	*伪政策虚拟变量
	use 地级市县域.dta,clear 
	bsample 1, strata(id)
	keep year
	save "matchyear.dta", replace
	mkmat year, matrix(sampleyear)
	use "matchcity`i'.dta",replace
	xtset id year
	gen time = 0
	foreach j of numlist 1/280 {
		replace time = 1 if (id == `j' & year >= sampleyear[`j',1])
	}	
	gen  did=time*groupnew
	global C " lngre lninf lngov lnpop lnedu " 
	xtreg epm1 did  $C  i.year, fe robust
	
	mat b[`i',1] = _b[did]
	mat se[`i',1] = _se[did]
	scalar df_r = e(N) - e(df_m) -1
	mat p[`i',1] = 2*ttail(df_r,abs(_b[did]/_se[did]))
}
svmat b, names(coef)
svmat se, names(se)
svmat p, names(pvalue)

drop if pvalue1 == .
label var pvalue1 p值
label var coef1 估计系数

*-P值图

sum coef1, detail

  twoway(scatter pvalue1 coef1,                                                  ///
             msy(oh) mcolor(black)                                              ///
             xline(`r(mean)', lpattern(dash)      lcolor(black))                ///
             xline(0.028  , lpattern(solid)     lcolor(black))                ///
             yline( 0.1     , lpattern(shortdash) lcolor(black))                ///
             scheme(s1mono)                                                  ///
             xtitle("Cofficient" , size(medlarge))                 ///
             ytitle("P_value" , size(medlarge))  ///
             saving(placebo_test_Pvalue2, replace)),                            ///
         xlabel(-0.05(0.01)0.05, labsize(medlarge) format(%03.2f))                     ///
         ylabel(0(0.25)1, labsize(medlarge) format(%03.2f))

  graph export "placebo_test_Pvalue2.png", replace

 *-删除临时文件
forvalue i=1/500{
    erase  "matchcity`i'.dta"
}


*-安慰剂检验co2
  cd "C:\Users\93285\Desktop\论文\地级市县域"

**# 基础回归

  use 地级市县域.dta, clear

  global C " lngre lninf lngov lnpop lnedu " 
  reghdfe ece1 did2 $C , absorb(id year) vce(cluster id )

*- 基础回归中核心变量dudt的真实系数与真实t值分别为：
*- 真实系数 = 0.050(pm2.5) 0.025(co2)
*- 真实t值  = 
cd "C:\Users\93285\Desktop\论文\地级市县域"

clear
set matsize 5000
mat b = J(500,1,0)
mat se = J(500,1,0)
mat p = J(500,1,0)

forvalues i=1/500{
	use 地级市县域.dta, clear 
	xtset id year
	keep if year==2004
	sample 65, count
	keep id
	save "atchcity.dta",replace
	merge 1:m id using 地级市县域.dta
	gen groupnew=(_merge==3) //生成伪处理组的虚拟变量
	save "matchcity`i'.dta",replace
		
	*伪政策虚拟变量
	use 地级市县域.dta,clear 
	bsample 1, strata(id)
	keep year
	save "matchyear.dta", replace
	mkmat year, matrix(sampleyear)
	use "matchcity`i'.dta",replace
	xtset id year
	gen time = 0
	foreach j of numlist 1/280 {
		replace time = 1 if (id == `j' & year >= sampleyear[`j',1])
	}	
	gen  did=time*groupnew
	global C " lngre lninf lngov lnpop lnedu " 
	xtreg ece1 did  $C  i.year, fe robust
	
	mat b[`i',1] = _b[did]
	mat se[`i',1] = _se[did]
	scalar df_r = e(N) - e(df_m) -1
	mat p[`i',1] = 2*ttail(df_r,abs(_b[did]/_se[did]))
}
svmat b, names(coef)
svmat se, names(se)
svmat p, names(pvalue)

drop if pvalue1 == .
label var pvalue1 p值
label var coef1 估计系数

*-P值图

sum coef1, detail

  twoway(scatter pvalue1 coef1,                                                  ///
             msy(oh) mcolor(black)                                              ///
             xline(`r(mean)', lpattern(dash)      lcolor(black))                ///
             xline(0.015  , lpattern(solid)     lcolor(black))                ///
             yline( 0.1     , lpattern(shortdash) lcolor(black))                ///
             scheme(s1mono)                                                  ///
             xtitle("Cofficient" , size(medlarge))                 ///
             ytitle("P_value" , size(medlarge))  ///
             saving(placebo_test_Pvalue2, replace)),                            ///
         xlabel(-0.05(0.01)0.05, labsize(medlarge) format(%03.2f))                     ///
         ylabel(0(0.25)1, labsize(medlarge) format(%03.2f))

  graph export "placebo_test_Pvalue2.png", replace

 *-删除临时文件
forvalue i=1/500{
    erase  "matchcity`i'.dta"
}
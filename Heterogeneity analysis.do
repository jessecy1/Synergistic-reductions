*-按是否为资源型城市分类
*-资源
use "C:\Users\93285\Desktop\论文\地级市县域\异质性分析\资源.dta", replace
xtset id year
global C " lngre lninf lngov lnpop lnedu "

reghdfe epm1 did2 $C , absorb(id year) vce(cluster id )
outreg2 using"1235.doc", replace se bdec(3) tdec(3) ctitle(PM2.5) addtext(yearfix,YES,idfix,YES)

reghdfe ece1 did2 $C , absorb(id year) vce(cluster id )
outreg2 using"1235.doc", append se bdec(3) tdec(3) ctitle(CO2)  addtext(yearfix,YES,idfix,YES)

*-非资源
use "C:\Users\93285\Desktop\论文\地级市县域\异质性分析\非资源.dta", replace
xtset id year
global C " lngre lninf lngov lnpop lnedu "

reghdfe epm1 did2 $C , absorb(id year) vce(cluster id )
outreg2 using"1235.doc", append se bdec(3) tdec(3) ctitle(PM2.5) addtext(yearfix,YES,idfix,YES)

reghdfe ece1 did2 $C , absorb(id year) vce(cluster id )
outreg2 using"1235.doc", append se bdec(3) tdec(3) ctitle(CO2)  addtext(yearfix,YES,idfix,YES)

*-按南北方
*-南方
use "C:\Users\93285\Desktop\论文\地级市县域\异质性分析\南方.dta", replace
xtset id year
global C " lngre lninf lngov lnpop lnedu "

reghdfe epm1 did2 $C , absorb(id year) vce(cluster id )
outreg2 using"1235.doc", replace se bdec(3) tdec(3) ctitle(PM2.5) addtext(yearfix,YES,idfix,YES)

reghdfe ece1 did2 $C , absorb(id year) vce(cluster id )
outreg2 using"1235.doc", append se bdec(3) tdec(3) ctitle(CO2)  addtext(yearfix,YES,idfix,YES)

*-北方
use "C:\Users\93285\Desktop\论文\地级市县域\异质性分析\北方.dta", replace
xtset id year
global C " lngre lninf lngov lnpop lnedu "

reghdfe epm1 did2 $C , absorb(id year) vce(cluster id )
outreg2 using"1235.doc", append se bdec(3) tdec(3) ctitle(PM2.5) addtext(yearfix,YES,idfix,YES)

reghdfe ece1 did2 $C , absorb(id year) vce(cluster id )
outreg2 using"1235.doc", append se bdec(3) tdec(3) ctitle(CO2)  addtext(yearfix,YES,idfix,YES)


*成长周期的异质性（按六年）
*-成熟
use "C:\Users\93285\Desktop\论文\地级市县域\异质性分析\成熟.dta", replace
xtset id year
global C " lngre lninf lngov lnpop lnedu "

reghdfe epm1 did2 $C , absorb(id year) vce(cluster id )
outreg2 using"1234.doc", replace se bdec(3) tdec(3) ctitle(PM2.5) addtext(yearfix,YES,idfix,YES)

reghdfe ece1 did2 $C , absorb(id year) vce(cluster id )
outreg2 using"1234.doc", append se bdec(3) tdec(3) ctitle(CO2)  addtext(yearfix,YES,idfix,YES)

*-成长
use "C:\Users\93285\Desktop\论文\地级市县域\异质性分析\成长.dta", replace
xtset id year
global C " lngre lninf lngov lnpop lnedu "

reghdfe epm1 did2 $C , absorb(id year) vce(cluster id )
outreg2 using"1234.doc", append se bdec(3) tdec(3) ctitle(PM2.5) addtext(yearfix,YES,idfix,YES)

reghdfe ece1 did2 $C , absorb(id year) vce(cluster id )
outreg2 using"1234.doc", append se bdec(3) tdec(3) ctitle(CO2)  addtext(yearfix,YES,idfix,YES)
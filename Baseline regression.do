******************************************附录1.描述性统计**************************************


use "C:\Users\93285\Desktop\论文\地级市县域\地级市县域.dta", replace

xtset id year

global C " lngre lninf lngov lnpop lnedu "

reghdfe epm1 did2, absorb(id year) vce(cluster id )
outreg2 using"1235.doc", replace se bdec(3) tdec(3) ctitle(PM2.5) addtext(yearfix,YES,idfix,YES)

reghdfe epm1 did2 $C , absorb(id year) vce(cluster id )
outreg2 using"1235.doc", append se bdec(3) tdec(3) ctitle(PM2.5) addtext(yearfix,YES,idfix,YES)

reghdfe ece1 did2, absorb(id year) vce(cluster id )
outreg2 using"1235.doc", append se bdec(3) tdec(3) ctitle(CO2)  addtext(yearfix,YES,idfix,YES)

reghdfe ece1 did2 $C , absorb(id year) vce(cluster id )
outreg2 using"1235.doc", append se bdec(3) tdec(3) ctitle(CO2)  addtext(yearfix,YES,idfix,YES)


********************************************PSM-did*********************
** pm2.5

*****************************逐年匹配********************************************

use"C:\Users\93285\Desktop\论文\地级市县域\地级市县域.dta", clear
xtset id year 
global xlist  " lngre lninf lngov lnpop lnedu "


**# 2.1 卡尺最近邻匹配（1:2）

forvalue i = 2003/2017{
      preserve
          capture {
              keep if year == `i'
              set seed 0000
              gen  norvar_2 = rnormal()
              sort norvar_2

              psmatch2 treatment $xlist , outcome(epm1) logit neighbor(2)  ///
                                        ties common ate caliper(0.05)

              save `i'.dta, replace
              }
      restore
      }

clear all

use 2003.dta, clear

forvalue k =2004/2017 {
      capture {
          append using `k'.dta
          }
      }

save ybydata.dta, replace

**# 2.2 倾向得分值的核密度图

sum _pscore if treatment == 1, detail  // 处理组的倾向得分均值为0.1793


*- 匹配前

sum _pscore if treatment == 0, detail

twoway(kdensity _pscore if treatment== 1, lpattern(solid)                     ///
              lcolor(black)                                                  ///
              lwidth(thin)                                                   ///
              scheme(s1mono)                                              ///
              ytitle("Kernel density",                ///
                     size(medlarge) )                          ///
              xtitle("Before matching",                          ///
                     size(medlarge))                                         ///
              xline(0.1793   , lpattern(solid) lcolor(black))                ///
              xline(`r(mean)', lpattern(dash)  lcolor(black))                ///
              saving(kensity_yby_before, replace))                           ///
      (kdensity _pscore if treatment == 0, lpattern(dash)),                    ///
      xlabel(     , labsize(medlarge) format(%02.1f))                        ///
      ylabel(0(1)3, labsize(medlarge))                                       ///
      legend(label(1 "Treat")                                      ///
             label(2 "Control")                                      ///
             size(medlarge) position(1) symxsize(10))

graph export "kensity_yby_before.emf", replace

discard

*- 匹配后

sum _pscore if treatment == 0 & _weight != ., detail

twoway(kdensity _pscore if treatment == 1, lpattern(solid)                     ///
              lcolor(black)                                                  ///
              lwidth(thin)                                                   ///
              scheme(s1mono)                                              ///
              ytitle("Kernel density",                ///
                     size(medlarge) )                          ///
              xtitle("After matching",                          ///
                     size(medlarge))                                         ///
              xline(0.1793   , lpattern(solid) lcolor(black))                ///
              xline(`r(mean)', lpattern(dash)  lcolor(black))                ///
              saving(kensity_yby_after, replace))                            ///
      (kdensity _pscore if treatment == 0 & _weight != ., lpattern(dash)),     ///
      xlabel(     , labsize(medlarge) format(%02.1f))                        ///
      ylabel(0(1)3, labsize(medlarge))                                       ///
      legend(label(1 "Treat")                                      ///
             label(2 "Control")                                      ///
             size(medlarge) position(1) symxsize(10))

graph export "kensity_yby_after.emf", replace

discard

**# 2.3 逐年平衡性检验

*- 匹配前

forvalue i = 2003/2017 {
          capture {
              qui: logit treatment $xlist if year == `i',  vce(cluster id)
              est store ybyb`i'
              }
          }

local ybyblist ybyb2003 ybyb2004 ybyb2005 ybyb2006 ybyb2007 ybyb2008 ybyb2009 ybyb2010 ybyb2011 ybyb2012 ybyb2013                  ///
               ybyb2014 ybyb2015 ybyb2016 ybyb2017

reg2docx `ybyblist' using 逐年平衡性检验结果_匹配前.docx, b(%6.4f) t(%6.4f)  ///
         scalars(n r2_p(%6.4f)) noconstant replace                           ///
         mtitles("2003b""2004b" "2005b" "2006b" "2007b" "2008b" "2009b" "2010b" "2011b" "2012b"                     ///
                 "2013b" "2014b" "2015b" "2016b" "2017b")                    ///
         title("逐年平衡性检验_匹配前")

*- 匹配后

forvalue i = 2003/2017 {
          capture {
              qui: logit treatment $xlist                                ///
                       if year == `i' & _weight != ., vce(cluster id)
              est store ybya`i'
              }
          }

local ybyalist ybya2003 ybya2004 ybya2005 ybya2006 ybya2007 ybya2008 ybya2009 ybya2010 ybya2011 ybya2012 ybya2013                  ///
               ybya2014 ybya2015 ybya2016 ybya2017

reg2docx `ybyalist' using 逐年平衡性检验结果_匹配后.docx, b(%6.4f) t(%6.4f)  ///
         scalars(n r2_p(%6.4f)) noconstant replace                           ///
         mtitles("2003a" "2004a" "2005a" "2006a" "2007a" "2008a" "2009a" "2010a" "2011a" "2012a"                     ///
                 "2013a" "2014a" "2015a" "2016a" "2017a")                    ///
         title("逐年平衡性检验_匹配后")

**# 2.4 回归结果对比

use ybydata.dta, clear
duplicates drop id year, force

*- psm-did221（使用权重不为空的样本）
xtset id year 
qui: xtreg epm1 did2  $xlist  i.year if _weight != ., fe robust
est store m6

*- psm-inno_policy（使用满足共同支撑假设的样本）

qui: xtreg epm1 did2  $xlist  i.year if _support == 1, fe robust
est store m7

*- psm-did223（使用频数加权回归）
gen     weight  = _weight * 2
replace weight  = 1 if treatment == 1 & _weight != .
keep if weight != .
expand  weight
xtreg epm1 did2  $xlist  i.year ,fe robust 
est store m8

*- 回归结果输出

local mlist_2 " m6 m7 m8"
reg2docx `mlist_2' using 逐年匹配回归结果对比.docx, b(%6.4f) t(%6.4f)        ///
         scalars(n r2_a(%6.4f)) noconstant  replace                          ///
         mtitles("weight!=." "on_support" "weight_reg")           ///
         title("逐年psm-did2结果")

********第二列即满足共同支撑的逐年psm估计结果。mdid2

** co2

*****************************逐年匹配********************************************

use"C:\Users\93285\Desktop\论文\地级市县域\地级市县域.dta", clear
xtset id year 
global xlist  " lngre lninf lngov lnpop lnedu "


**# 2.1 卡尺最近邻匹配（1:2）

forvalue i = 2003/2017{
      preserve
          capture {
              keep if year == `i'
              set seed 0000
              gen  norvar_2 = rnormal()
              sort norvar_2

              psmatch2 treatment $xlist , outcome(epm1) logit neighbor(2)  ///
                                        ties common ate caliper(0.05)

              save `i'.dta, replace
              }
      restore
      }

clear all

use 2003.dta, clear

forvalue k =2004/2017 {
      capture {
          append using `k'.dta
          }
      }

save ybydata.dta, replace

**# 2.2 倾向得分值的核密度图

sum _pscore if treatment == 1, detail  // 处理组的倾向得分均值为0.1793


*- 匹配前

sum _pscore if treatment == 0, detail

twoway(kdensity _pscore if treatment== 1, lpattern(solid)                     ///
              lcolor(black)                                                  ///
              lwidth(thin)                                                   ///
              scheme(s1mono)                                              ///
              ytitle("Kernel density",                ///
                     size(medlarge) )                          ///
              xtitle("Before matching",                          ///
                     size(medlarge))                                         ///
              xline(0.1793   , lpattern(solid) lcolor(black))                ///
              xline(`r(mean)', lpattern(dash)  lcolor(black))                ///
              saving(kensity_yby_before, replace))                           ///
      (kdensity _pscore if treatment == 0, lpattern(dash)),                    ///
      xlabel(     , labsize(medlarge) format(%02.1f))                        ///
      ylabel(0(1)3, labsize(medlarge))                                       ///
      legend(label(1 "Treat")                                      ///
             label(2 "Control")                                      ///
             size(medlarge) position(1) symxsize(10))

graph export "kensity_yby_before.emf", replace

discard

*- 匹配后

sum _pscore if treatment == 0 & _weight != ., detail

twoway(kdensity _pscore if treatment == 1, lpattern(solid)                     ///
              lcolor(black)                                                  ///
              lwidth(thin)                                                   ///
              scheme(s1mono)                                              ///
              ytitle("Kernel density",                ///
                     size(medlarge) )                          ///
              xtitle("After matching",                          ///
                     size(medlarge))                                         ///
              xline(0.1793   , lpattern(solid) lcolor(black))                ///
              xline(`r(mean)', lpattern(dash)  lcolor(black))                ///
              saving(kensity_yby_after, replace))                            ///
      (kdensity _pscore if treatment == 0 & _weight != ., lpattern(dash)),     ///
      xlabel(     , labsize(medlarge) format(%02.1f))                        ///
      ylabel(0(1)3, labsize(medlarge))                                       ///
      legend(label(1 "Treat")                                      ///
             label(2 "Control")                                      ///
             size(medlarge) position(1) symxsize(10))

graph export "kensity_yby_after.emf", replace

discard

**# 2.3 逐年平衡性检验

*- 匹配前

forvalue i = 2003/2017 {
          capture {
              qui: logit treatment $xlist if year == `i',  vce(cluster id)
              est store ybyb`i'
              }
          }

local ybyblist ybyb2003 ybyb2004 ybyb2005 ybyb2006 ybyb2007 ybyb2008 ybyb2009 ybyb2010 ybyb2011 ybyb2012 ybyb2013                  ///
               ybyb2014 ybyb2015 ybyb2016 ybyb2017

reg2docx `ybyblist' using 逐年平衡性检验结果_匹配前.docx, b(%6.4f) t(%6.4f)  ///
         scalars(n r2_p(%6.4f)) noconstant replace                           ///
         mtitles("2003b""2004b" "2005b" "2006b" "2007b" "2008b" "2009b" "2010b" "2011b" "2012b"                     ///
                 "2013b" "2014b" "2015b" "2016b" "2017b")                    ///
         title("逐年平衡性检验_匹配前")

*- 匹配后

forvalue i = 2003/2017 {
          capture {
              qui: logit treatment $xlist                                ///
                       if year == `i' & _weight != ., vce(cluster id)
              est store ybya`i'
              }
          }

local ybyalist ybya2003 ybya2004 ybya2005 ybya2006 ybya2007 ybya2008 ybya2009 ybya2010 ybya2011 ybya2012 ybya2013                  ///
               ybya2014 ybya2015 ybya2016 ybya2017

reg2docx `ybyalist' using 逐年平衡性检验结果_匹配后.docx, b(%6.4f) t(%6.4f)  ///
         scalars(n r2_p(%6.4f)) noconstant replace                           ///
         mtitles("2003a" "2004a" "2005a" "2006a" "2007a" "2008a" "2009a" "2010a" "2011a" "2012a"                     ///
                 "2013a" "2014a" "2015a" "2016a" "2017a")                    ///
         title("逐年平衡性检验_匹配后")

**# 2.4 回归结果对比

use ybydata.dta, clear
duplicates drop id year, force

*- psm-did221（使用权重不为空的样本）
xtset id year 
qui: xtreg ece1 did2  $xlist  i.year if _weight != ., fe robust
est store m6

*- psm-inno_policy（使用满足共同支撑假设的样本）

qui: xtreg ece1 did2  $xlist  i.year if _support == 1, fe robust
est store m7

*- psm-did223（使用频数加权回归）
gen     weight  = _weight * 2
replace weight  = 1 if treatment == 1 & _weight != .
keep if weight != .
expand  weight
xtreg ece1 did2  $xlist  i.year ,fe robust 
est store m8

*- 回归结果输出

local mlist_2 " m6 m7 m8"
reg2docx `mlist_2' using 逐年匹配回归结果对比.docx, b(%6.4f) t(%6.4f)        ///
         scalars(n r2_a(%6.4f)) noconstant  replace                          ///
         mtitles("weight!=." "on_support" "weight_reg")           ///
         title("逐年psm-did2结果")

********第二列即满足共同支撑的逐年psm估计结果。mdid2
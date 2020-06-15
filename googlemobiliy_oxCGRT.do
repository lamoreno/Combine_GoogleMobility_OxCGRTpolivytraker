*==============================================================
*project:       Global_Mobility_Report
*Author:        Laura Moreno 
*Dependencies:  WB
*--------------------------------------------------------------
*Creation Date:    05052020
*Modification Date:   
*Do-file version:    01
*References:          
*Output:             NA
*==============================================================
set trace off
version 16
*------------------------------
*        0: Set up
*------------------------------
local path "P:\SAR\2.GoogleMobility"
local googlecsv "Global_Mobility_Report.csv"
local oxCGRT "OxCGRT_latest.csv"
local link_oxCGRT "https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/OxCGRT_latest.csv"
*https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/OxCGRT_latest.csv
*https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/OxCGRT_latest.csv
*https://github.com/OxCGRT/covid-policy-tracker/blob/master/data/OxCGRT_latest.csv
*Cite as: Thomas Hale, Sam Webster, Anna Petherick, Toby Phillips, and Beatriz Kira. (2020). Oxford COVID-19 Government Response Tracker. Blavatnik School of Government.
local link_googledata "https://www.gstatic.com/covid19/mobility/Global_Mobility_Report.csv?cachebust=9cfdda8c20841ad1"
*------------------------------
*        1: Download and save
*------------------------------
clear
import delimited "`link_googledata'"
export delimited using "`path'\\`googlecsv'", datafmt replace

clear
import delimited "https://rawgithub.com/OxCGRT/covid-policy-tracker/master/data/OxCGRT_latest.csv"
*shell git pull "https://github.com/OxCGRT/covid-policy-tracker.git"
*shell wget -O "`path'\\`oxCGRTv'" "`link_oxCGRT'" 

*"`path'\\`oxCGRT'"
*------------------------------
*        2: Organize
*------------------------------
clear all

import delimited "`path'\\`oxCGRT'"

gen sar=.
replace sar=1 if countrycode=="AFG"
replace sar=1 if countrycode=="BGD"
replace sar=1 if countrycode=="IND"
replace sar=1 if countrycode=="NPL"
replace sar=1 if countrycode=="PAK"
replace sar=1 if countrycode=="LKA"
keep if sar==1
tostring date, gen(date3)
gen date2=date(date3,"YMD")
form date2 %td
drop date date3
order countryname countrycode date2
gen country_region_code=""
replace country_region_code="AF"  if countrycode=="AFG" 
replace country_region_code="BD"  if countrycode=="BGD" 
replace country_region_code="BT"  if countrycode=="BTN" 
replace country_region_code="IN"  if countrycode=="IND" 
replace country_region_code="NP"  if countrycode=="NPL" 
replace country_region_code="PK"  if countrycode=="PAK" 
replace country_region_code="LK"  if countrycode=="LKA" 

rename ??_flag flag??
la var c1_schoolclosing					"school closing"					
la var c2_workplaceclosing                "workplace closing"               
la var c3_cancelpublicevents              "cancel public events"              
la var c4_restrictionsongatherings        "restrictions on gatherings"        
la var c5_closepublictransport            "close public transport"            
la var c6_stayathomerequirements          "stay at home requirements"          
la var c7_restrictionsoninternalmovemen  "restrictions on internal movement" 
la var c8_internationaltravelcontrols     "international travel controls"    
la var e1_incomesupport                    "income support"                   
la var e2_debtcontractrelief              "debt contract relief"              
*la var e3_fiscalmeasures                  "fiscal measures"                 
*la var e4_internationalsupport            "international support"            
la var h1_publicinformationcampaigns      "public information campaigns"     
la var h2_testingpolicy                    "testing policy"                   
la var h3_contacttracing                  "contact tracing"                 
la var h4_emergencyinvestmentinhealthca  "emergency investment in health"             
drop h5* e3* e4*

la def flag	0 "targeted" 1 "general" 
la def c1_schoolclosing 0 "no measures" 1 "recommend closing" 	2 "require closing some levels"  3 "require closing all levels" 
la def c2_workplaceclosing	0 "no measures" 1 "recommend closing or work from home" 2 "require closing for some" 3 "require closing for all-but-essential workplaces"
la def c3_cancelpublicevents	0 "no measures" 1 "recommend cancelling" 2 "require cancelling"
la def c4_restrictionsongatherings	0 "no restrictions" 1 "no very large gatherings (1000up)" 2 "no large gatherings (101up)" 3 "no group gatherings (11up)" 4 "no gatherings" 
la def c5_closepublictransport	0 "no measures" 1 "recommend closing" 	2 "require closing"
la def c6_stayathomerequirements	0 "no measures" 1 "recommend not leaving house" 2 "require not leaving house with exceptions" 	3 "require not leaving house with minimal exceptions"
la def c7_restrictionsoninternalmovemen	0 "no measures" 1 "recommend not to travel between regions/cities" 2 "internal movement restrictions in place"
la def c8_internationaltravelcontrols	0 "no restrictions" 1 "screening arrivals" 	2 "quarantine arrivals from some or all regions" 	3 "ban arrivals from some regions" 	4 "ban on all regions or total border closure"

la def h1_publicinformationcampaigns 0 "no Covid-19 public information campaign" 1 "public officials urging caution about Covid-19" 2 "coordinated public information campaign (eg across traditional and social media)"      
la def h2_testingpolicy 0 "no testing policy" 1 "only those who both (a) have symptoms AND (b) meet specific criteria (eg key workers, admitted to hospital, came into contact with a known case, returned from overseas)" 2 "testing of anyone showing Covid-19 symptoms" 3 "open public testing (eg drive through testing available to asymptomatic people)"                              
la def h3_contacttracing 0 "no contact tracing" 1 "limited contact tracing; not done for all cases" 2 "comprehensive contact tracing; done for all identified cases"                      


la val c1_schoolclosing					c1_schoolclosing					
la val c2_workplaceclosing                c2_workplaceclosing                
la val c3_cancelpublicevents              c3_cancelpublicevents              
la val c4_restrictionsongatherings        c4_restrictionsongatherings      
la val c5_closepublictransport            c5_closepublictransport            
la val c6_stayathomerequirements          c6_stayathomerequirements         
la val c7_restrictionsoninternalmovemen  c7_restrictionsoninternalmovemen 
la val c8_internationaltravelcontrols    c8_internationaltravelcontrols  
la val flagc1 flag
la val flagc2 flag
la val flagc3 flag
la val flagc4 flag
la val flagc5 flag
la val flagc6 flag
la val flagc7 flag
la val flagh1 flag
la val h1_publicinformationcampaigns h1_publicinformationcampaigns
la val h2_testingpolicy h2_testingpolicy 
la val h3_contacttracing h3_contacttracing

keep country_region_code date2 c* flagc? h1* h2* h3* m1* flagh1
cap export delimited using "`path'\\oxCGRTdataSAR.csv", datafmt replace
tempfile oxCGRTdata  
save `oxCGRTdata', replace

* long
gen lc1=c1_schoolclosing					
gen lc2=c2_workplaceclosing                
gen lc3=c3_cancelpublicevents              
gen lc4=c4_restrictionsongatherings       
gen lc5=c5_closepublictransport            
gen lc6=c6_stayathomerequirements         
gen lc7=c7_restrictionsoninternalmovemen  
gen lc8=c8_internationaltravelcontrols    
gen lh1=h1_publicinformationcampaigns 
gen lh2=h2_testingpolicy 
gen lh3=h3_contacttracing 

rename c1_schoolclosing					   vc1
rename c2_workplaceclosing                vc2
rename c3_cancelpublicevents              vc3
rename c4_restrictionsongatherings       vc4
rename c5_closepublictransport            vc5
rename c6_stayathomerequirements         vc6
rename c7_restrictionsoninternalmovemen  vc7
rename c8_internationaltravelcontrols    vc8
rename h1_publicinformationcampaigns vh1
rename h2_testingpolicy vh2
rename h3_contacttracing vh3

decode vc1, gen(ec1)
decode vc2, gen(ec2)
decode vc3, gen(ec3)
decode vc4, gen(ec4)
decode vc5, gen(ec5)
decode vc6, gen(ec6)
decode vc7, gen(ec7)
decode vc8, gen(ec8)
decode vh1, gen(eh1)
decode vh2, gen(eh2)
decode vh3, gen(eh3)

reshape long e v l flag , i(country_region_code date2) j(value) string

*csv long with labels
gen meassure=""
replace meassure="school closing"							if value=="c1"
replace meassure="workplace closing"                       if value=="c2" 
replace meassure="cancel public events"                    if value=="c3" 
replace meassure="restrictions on gatherings"              if value=="c4"
replace meassure="public transport"                  if value=="c5" 
replace meassure="stay at home requirements"               if value=="c6"
replace meassure="restrictions on internal movement"       if value=="c7" 
replace meassure="international travel controls"           if value=="c8"
replace meassure="income support"                          if value=="e1" 
replace meassure="debt contract relief"                    if value=="e2"
replace meassure="public information campaigns"            if value=="h1" 
replace meassure="testing policy"                          if value=="h2"
replace meassure="contact tracing"                         if value=="h3" 
replace meassure="emergency investment in health"          if value=="h4"
gen meassure_flag="" 
replace meassure_flag="flag: school closing"						if value=="c1"
replace meassure_flag="flag: workplace closing"                  if value=="c2"
replace meassure_flag="flag: cancel public events"               if value=="c3"
replace meassure_flag="flag: restrictions on gatherings"         if value=="c4"
replace meassure_flag="flag: close public transport"             if value=="c5"
replace meassure_flag="flag: stay at home requirements"          if value=="c6"
replace meassure_flag="flag: restrictions on internal movement"  if value=="c7"
replace meassure_flag="flag: public information campaigns" 		if value=="h1"
rename flag auxflag
gen target=""
replace target="targeted" if auxflag==0
replace target="general" if auxflag==1
rename countryname country
export delimited using "`path'\\oxCGRTdataSAR_long.csv", datafmt replace
clear
*export delimited using "`path'\\oxCGRTdataSAR_long.csv", datafmt replace
mmm

import delimited "`path'\\`googlecsv'"
*rename
rename retail_and_recreation_percent_ch   pcretail_and_recreation 
rename grocery_and_pharmacy 				pcgrocery_and_pharmacy
rename parks_percent_change_from_baseli   pcparks
rename transit_stations_percent_change_   pctransit_stations
rename workplaces_percent_change_from_b   pcworkplaces
rename residential pcresidential
*reshape
reshape long pc, i(country_region_code country_region sub_region_1 sub_region_2 date) j(place) string
*weekday
gen mydate = subinstr(date, "-", "", .)
gen date2=date(mydate,"YMD")
form date2 %td
gen week_days = dow(date2)
drop mydate
la def week_days 0 "Sunday" 1 "Monday" 2 "Tuesday" 3 "Wednesday" 4 "Thursday" 5 "Friday" 6 "Saturday"
la val week_days week_days

replace place = subinstr(place, "_", " ", .)
replace sub_region_1=country_region if sub_region_1==""
replace sub_region_2=country_region if sub_region_2==""

rename country_region country
drop date
export delimited using "`path'\\Global_Mobility_ReportLong.csv", datafmt replace
gen sar=.
replace sar=1 if country_region_code=="AF"
replace sar=1 if country_region_code=="BD"
replace sar=1 if country_region_code=="IN"
replace sar=1 if country_region_code=="NP"
replace sar=1 if country_region_code=="PK"
replace sar=1 if country_region_code=="LK"
keep if sar==1

preserve
keep country country_region_code
duplicates drop
merge 1:m country_region_code using `oxCGRTdata'
drop _merge
save `oxCGRTdata', replace
restore
merge m:1 country_region_code date2 using `oxCGRTdata'
export delimited using "`path'\\Global_Mobility_ReportLongSAR.csv", datafmt replace



exit
*Thanks



reshape long v flag, i(countryname country_region_code date2) j(type) string
gen measure=""
replace measure="school closing" if type=="c1"
replace measure="work place closing"  if type=="c2"
replace measure="cancel public events" if type=="c3"
replace measure="restrictions on gatherings"   if type=="c4"
replace measure="close public transport" if type=="c5"
replace measure="stay at home requirements"   if type=="c6"
replace measure="restrictions on internal movement" if type=="c7"
replace measure="international travel controls"   if type=="c8"
replace measure="income support" if type=="e1"
replace measure="debt contract relief"  if type=="e2"
replace measure="fiscal measures" if type=="e3"
replace measure="international support"  if type=="e4"
replace measure="public information campaigns" if type=="h1"
replace measure="testing policy"  if type=="h2"
replace measure="contact tracing" if type=="h3"
replace measure="emergency investment in health"  if type=="h4"
replace measure="investment invaccines" if type=="h5"


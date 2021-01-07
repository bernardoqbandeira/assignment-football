* Importing the dataset and adjusting some of the variables already, for example transforming strings in numbers.
clear
import delimited "\\tsclient\C\Users\Bernardo Bandeira\Documents\CEU\Courses\Coding for Economists\Assignment\Final Assignment\data\raw\Life Expectancy -Gdp per capita.csv", varnames(1) encoding(UTF-8) bindquotes(strict) numericcols(5 6 7 8 9 10 11 12 13 14 15 16)

* Correcting the data, dropping the unused variables and transforming some of them in to the correct format
drop seriescode
drop yr2019 yr2020
describe
drop seriesname countryname
drop if missing(yr1990)
drop if missing(yr2000)
drop if missing(yr2011)
drop if missing(yr2012)
drop if missing(yr2013)
drop if missing(yr2014)
drop if missing(yr2015)
drop if missing(yr2016)
drop if missing(yr2017)
drop if missing(yr2018)

* Droping the GDP per capita so I can isolate the Life Expectancy and removing the aggregate regions.
drop in 196/454
reshape long yr, i(countrycode) j(year)
rename yr LifeExpectancy
label variable LifeExpectancy "Life Expectancy since birth"
label variable year "Year"

* Saving the transformed data as dta and csv.
save "\\tsclient\C\Users\Bernardo Bandeira\Documents\CEU\Courses\Coding for Economists\Assignment\Final Assignment\data\derived\LEreshaped.csv", replace
save "\\tsclient\C\Users\Bernardo Bandeira\Documents\CEU\Courses\Coding for Economists\Assignment\Final Assignment\data\derived\LEreshaped.dta", replace

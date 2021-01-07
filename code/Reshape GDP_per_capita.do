* Restarting for the GDP
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

* Droping the LifeExpectancy so I can isolate the GDP_per_capita and removing the aggregate regions.
drop in 1/241
drop in 170/213
reshape long yr, i(countrycode) j(year)
rename yr GDP_per_capita
label variable GDP_per_capita "GDP per capita per country"
label variable year "Year"

* Saving the transformed data.
save "\\tsclient\C\Users\Bernardo Bandeira\Documents\CEU\Courses\Coding for Economists\Assignment\Final Assignment\data\derived\GDP_per_capita_reshaped.csv", replace
save "\\tsclient\C\Users\Bernardo Bandeira\Documents\CEU\Courses\Coding for Economists\Assignment\Final Assignment\data\derived\GDP_per_capita_reshaped.dta", replace

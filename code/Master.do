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

* Saving the transformed data.
save "\\tsclient\C\Users\Bernardo Bandeira\Documents\CEU\Courses\Coding for Economists\Assignment\Final Assignment\data\derived\LEreshaped.csv", replace

* Restarting for the GDP per capita
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

* Now we need to isolate for only one specific year so we merge the files.

*First for the Life Expectancy
use "\\tsclient\C\Users\Bernardo Bandeira\Documents\CEU\Courses\Coding for Economists\Assignment\Final Assignment\data\derived\LEreshaped.csv", clear

*Let`s say we will compare for the year 2018
keep if year == 2018
save "\\tsclient\C\Users\Bernardo Bandeira\Documents\CEU\Courses\Coding for Economists\Assignment\Final Assignment\data\derived\LE2018reshaped.csv", replace

*Now for the GDP per Capita
use "\\tsclient\C\Users\Bernardo Bandeira\Documents\CEU\Courses\Coding for Economists\Assignment\Final Assignment\data\derived\GDP_per_capita_reshaped.csv", clear
keep if year == 2018
save "\\tsclient\C\Users\Bernardo Bandeira\Documents\CEU\Courses\Coding for Economists\Assignment\Final Assignment\data\derived\GDP2018reshaped.csv", replace

*Now we merge the two datas and clear for any missing variables
merge 1:1 countrycode using "\\tsclient\C\Users\Bernardo Bandeira\Documents\CEU\Courses\Coding for Economists\Assignment\Final Assignment\data\derived\LE2018reshaped.csv"
drop if missing(GDP_per_capita)
drop if missing(LifeExpectancy)

*Here we will install the packages for the extractions of the regression and graph
ssc install outreg2

*Now the data is organized correctly and we can analyze through regressions and later a graph.
reg LifeExpectancy GDP_per_capita

*To export the table of the regression
outreg2 using reg_table_2018.doc, replace

*To create the graph
scatter LifeExpectancy GDP_per_capita

*To export the graph
graph export graph2018.png, replace

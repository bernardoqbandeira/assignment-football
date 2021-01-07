* Now we need to isolate for only one specific year so we merge the files.

*First for the Life Expectancy
use "\\tsclient\C\Users\Bernardo Bandeira\Documents\CEU\Courses\Coding for Economists\Assignment\Final Assignment\data\derived\LEreshaped.csv", clear

*Let`s say we will compare for the year 2018
keep if year == 2018
save "\\tsclient\C\Users\Bernardo Bandeira\Documents\CEU\Courses\Coding for Economists\Assignment\Final Assignment\data\derived\LE2018reshaped.csv", replace
save "\\tsclient\C\Users\Bernardo Bandeira\Documents\CEU\Courses\Coding for Economists\Assignment\Final Assignment\data\derived\LE2018reshaped.dta", replace

*Now for the GDP per Capita
use "\\tsclient\C\Users\Bernardo Bandeira\Documents\CEU\Courses\Coding for Economists\Assignment\Final Assignment\data\derived\GDP_per_capita_reshaped.csv", clear
keep if year == 2018
save "\\tsclient\C\Users\Bernardo Bandeira\Documents\CEU\Courses\Coding for Economists\Assignment\Final Assignment\data\derived\GDP2018reshaped.csv", replace
save "\\tsclient\C\Users\Bernardo Bandeira\Documents\CEU\Courses\Coding for Economists\Assignment\Final Assignment\data\derived\GDP2018reshaped.dta", replace

*Now we merge the two datas and clear for any missing variables
merge 1:1 countrycode using "\\tsclient\C\Users\Bernardo Bandeira\Documents\CEU\Courses\Coding for Economists\Assignment\Final Assignment\data\derived\LE2018reshaped.csv"
drop if missing(GDP_per_capita)
drop if missing(LifeExpectancy)

*Here we will install the packages for the extractions of the regression and graph
ssc install outreg2

*Now the data is organized correctly and we can analyze through regressions and later a graph.
reg LifeExpectancy GDP_per_capita

*To export the table of the regression
outreg2 using reg_table_2018.docx

*To create the graph
scatter LifeExpectancy GDP_per_capita

*To export the graph
graph export graph2018.png
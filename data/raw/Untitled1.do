* Importing the dataset
import delimited "\\tsclient\C\Users\Bernardo Bandeira\Documents\CEU\Courses\Coding for Economists\Assignment\Final Assignment\data\raw\Life Expectancy -Gdp per capita.csv", varnames(1) encoding(UTF-8) bindquotes(strict) 

* Correcting the data, dropping the unused variables and transforming some of them in to the correct format
drop seriescode
drop yr2019 yr2020
describe


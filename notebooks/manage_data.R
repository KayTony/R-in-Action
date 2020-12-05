
## create leadership dataframe
manager = c(1, 2, 3, 4, 5)
date = c("10/24/08", "10/28/08", "10/1/08", "10/12/08", "5/1/09")
country = c("US", "US", "UK", "UK", "UK")
gender = c("M", "F", "F", "M", "F")
age = c(32, 45, 25, 39, 99)
q1 = c(5, 3, 3, 3, 2)
q2 = c(4, 5, 5, 3, 2)
q3 = c(5, 2, 5, 4, 1)
q4 = c(5, 5, 5, NA, 2)
q5 = c(5, 5, 2, NA, 1)
## create data by columns
leadership = data.frame(manager, date, country, gender, age, 
                        q1, q2, q3, q4, q5, stringsAsFactors = FALSE)


## create new column
mydata = data.frame(x1 = c(2, 2, 6, 4),
                    x2 = c(3, 4, 2, 8))
### method 1
mydata$sumx = mydata$x1 + mydata$x2
mydata$meanx = (mydata$x1 + mydata$x2)/2
### method 2
attach(mydata)
mydata$sumx = x1 + x2
mydata$meanx = (x1 + x2) / 2
detach(mydata)
### method 3
mydata = transform(mydata, sumx = x1 + x2, meanx = (x1 + x2) / 2)


## recode
leadership$agecat[leadership$age > 75] = "Elder"
leadership$agecat[leadership$age >= 55 & leadership$age <=75] = "Middle Aged"
leadership$agecat[leadership$age < 55] = "Young"

## rename
library(reshape)
leadership = rename(leadership, c(manager='managerID', date='testDate'))

## NA
y = c(1, 2, 3, NA)
is.na(y)
is.na(leadership)
### recode some point as NA
leadership$age[leadership$age == 99] = NA
### remove NA
x = c(1, 2, NA, 3)
y = x[1] + x[2] + x[3] + x[4]
z = sum(x, na.rm = TRUE)
new_data = na.omit(leadership)

## date data
mydates = as.Date(c("2007-06-22", "20004-02-13"))
strDates = c("01/05/1965", "08/16/1975")
dates = as.Date(strDates, "%m/%d/%Y")
### date calculate
startdate = as.Date("2004-02-13")
enddate = as.Date("2011-01-22")
days = enddate - startdate
print(days)
diff_weeks = difftime(enddate, startdate, units = "weeks")
print(diff_weeks)

## change type of data
a = c(1, 2, 3)
is.numeric(a)         # judge data type
is.vector(a)
a = as.character(a)   # change data type
is.numeric(a)
is.vector(a)
is.character(a)

## sort data
newdata = leadership[order(leadership$age),]
### sort by more than one index
attach(leadership)
newdata = leadership[order(gender, -age), ]
detach(leadership)

## merge data
### add columns
total = merge(dataframeA, dataframeB, by=c("ID", "Country"))  # inner join
total = cbind(A, B)   # merge A and B ignoring index
### add rows
total = rbind(dataframeA, datarameB)

## get sub-data
newdata = leadership[, c(6:10)]
### other method
myvars = paste("q", 1:5, sep = "")
newdata = leadership[myvars]
### discard some var in dataframe
myvars = names(leadership) %in% c("q3", "q4")
newdata = leadership[!myvars]
### choose some data following rules
newdata = leadership[1:3, ]
newdata = leadership[, which(leadership$gender=="M" & leadership$age>30), ]
#### or
attach(leadership)
newdata = leadership[which(gender=="F" & age>30), ]
detach(leadership)
### subset()
newdata = subset(leadership, age >= 35 | age < 24, select = c(q1, q2, q3, q4))
newdata = subset(leadership, gender=="M" & age > 25, select = gender:q4)
### random sampling
mysample = leadership[sample(1:nrow(leadership), 3, replace = FALSE)]

## using sql in R
library(sqldf)



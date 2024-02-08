#### STAT 4050/7050 Homework 2, SPRING 2024
#### Name: Kevin Yao
#### Please list all external sources you have consulted for completing this assignment:

#### Instructions:
#### 1. If a question refers to a function not seen in class, 
#### 	use the help functionality in R to learn about it.
#### 2. Insert your answers and the R code you used to generate them, below each question.
#### 	Even though for some questions you can find the answer "by inspection", for this homework you need
#### 	to write code to get the answers, unless it is explicitly stated that no code is required.
#### 3. When you are asked to print an answer, it is NOT ENOUGH to simply write a print statement, 
#### 	for example print(2^3) as an answer, you also need to 
#### 	cut and paste into this document the value(s) that is actually printed.
#### 4. When submitting to Canvas, please change the file extension to .txt or.PDF, otherwise it cannot be submitted.


#### Q1. Logistic regression (30 points)

##Read the HR.data csv file as a dataframe into R for Q1.

#a  Using the hr.data data frame, create a data frame called "hr.data.train" consisting of all 
#   rows of hr.data with an odd-numbered EmployeeID,
#   and a data frame called "hr.data.test" consisting of all rows with even numbered EmployeeID.
#   You do not need to print anything yet.
hr.data = read.csv("./STAT4050/hr_data.csv")
hr.data.train = hr.data[hr.data$EmployeeId %% 2 == 0, ]
hr.data.test = hr.data[hr.data$EmployeeId %% 2 != 0, ]
#b  Count how many employees in hr.data.train have volturn equal to 1 and how many have volturn
#   equal to 0. Include your code and result.
nrow(hr.data.train[hr.data.train$volturn == 1,])
nrow(hr.data.train[hr.data.train$volturn == 0,])

303
2520
#c  Using the hr.data.train data frame, run a logistic regression of volturn 
#   against age, gender and salary, and store the resulting *output object* of the regression as a new variable.
hdt.glm = glm(volturn ~ age + Gender + salary, data = hr.data.train)
#d  Write code to extract and print the coefficient and significance level of salary. 
hdt.glm$coefficients["salary"]
#e  Write code to predict the *probabilities* of volturn being 1 for all rows in hr.data.test,
#   and store them in a vector named "predicted.prob". Do not print anything.   
#   (Hint: ?predict.glm, and study the "type" parameter.)
predicted.prob = predict(hdt.glm, type = "response")
#f  Now we convert the predicted probabilities into actual predictions for volturn (0 or 1), 
#   on the basis of whether the probability is greater than 0.15 (1 if >= 0.15, 0 if < 0.15). Store these predicted values
#   in a vector named "predicted.volturn". Do not print anything.

#g  We would like to evaluate the quality of predicted.volturn. 
#   Read https://en.wikipedia.org/wiki/Confusion_matrix and write R code to compute
#   the confusion matrix, named "confusion.matrix.volturn", between the actual volturn variable
#   in hr.data.test and your predicted.volturn. Include your code and print the matrix.
#   The placement of TP, FP, FN, TN in your matrix must be identical to the Wikipedia page.
#   It is probably easier to calculate these four numbers one by one and then fill the matrix.
#   For the definitions of each of these 4 terms, please see the Wikipedia page cancer example - which is pretty intuitive. 

##### Q2. 30 points
#### When fitting regression models (lm or glm) skewed predictor (x-variables) can give rise to highly leveraged
#### data points which may dominate the regression. One approach to dealing with this problem is to transform the
#### skewed x-variables.

#a.  Write a function in R that takes a single numeric vector as argument, and finds the skewness of the vector.
# The definition of skewness we will use is in the document "skewness.pdf" on Canvas.
# Call your function "skewness" and cut and paste your function here.
# As a test case skewness(c(1:10,50)) should report 3.053661. 


#b. Use your skewness function on the following vector and report the result:

my.vec <- c(0.538,  0.990,  0.531, -2.015,  0.015,  0.262, -0.342, -0.804,  1.501,  1.934)


#c. Refine your skewness function, so that if it is called with anything other than a numeric argument
# it stops and produces an informative error message. Use the "if", "is.numeric" and "stop" functions to achieve this goal.
# Cut and paste your refined function here and show that the function works as intended by passing the following vector as input
# c("Adam","Eve")


##### Q3. 40 points

# You are a risk manager at an insurance company with major operations in Miami, London and
# Tokyo. The number of hurricanes hitting the Eastern US each year averages 1.75, 1.1 in the UK and 3 in Japan.
# Assume that these follow independent Poisson distribution in each country
# Depending on the demand, You will be out of business if there exceeds a certain number of hurricanes in total 
# next year. 


# a. Write an R function called "my.hurricane.calc" that takes in the following inputs:
#   1. a dataframe with 'US','UK','JP' as the 3 column names and the number of hurricanes as the data in the rows
#   2. a number (call it "Max_H") for the maximum limit of hurricanes that your business can sustain without going under.

#   It should output a probability of your business going under, based on the dataframe and the Max_H threshold
#   

# For example, if you input this data frame into the function along with a Max_H value = 8, 
# US UK JP
# 2  2  5
# 1  0  6
# 3  2  5
# 1  1  2
# you should get a probability of 0.5 as output, since the 2 of the 4 rows (Rows 1 and 3) have a total hurricane number > max_H 
# and 2 of 4 rows (Rows 2 and 4) are <= Max_H total hurricanes.
# For example, row 1 is greater than the max_H threshold since 2+2+5 = 9, which is > 8


# b. Set seed to 2024 Create a data frame called my.data.hurricane with 100000 replicates of hurricane counts in each country next 
#  year. Do this for all 3 countries. This data frame should have a dimension of 100000 X 3 and the column names should be
# 'US', 'JP', 'UK'. Each column data should be generated with the respective country's Poisson mean. 

#   c. Using this data, estimate the probability of your business going under if the maximum number of total hurricanes you can sustain 
#      next year across all your business locations combined is:
#   1. 10 hurricanes
#   2. 5 hurricanes

# d. Compute the amount of time in seconds it takes you to perform the calculation for Question C.1 (10 hurricanes)
#    Output this answer in a neatly formatted sentence that reads as follows:
#    Eg: "I took a total of 0.5 seconds to compute the probability of going bankrupt if > 10 hurricanes hit next year"
#    Both the compute time (0.5 seconds) and max number of hurricanes (10) should be assigned via variables in a paste statement. 


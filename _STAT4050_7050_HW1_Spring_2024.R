#### STAT 4050/7050 Spring 2024 ASSIGNMENT 1, 100 max. possible points
#### NAME: Kevin Yao

#### If in a question I refer to a function that we have not seen in class, 
#### then use the help facility in R to find out about it.
#### Insert your answers and the R code you used to generate them, beneath each question.
#### Even though for some questions you could find the answer "by inspection", for this  homework you need
#### to write code to explicitly get the answers.
#### When you are asked to find an answer, it is NOT ENOUGH to simply write a print statement, 
#### for example print(2^3) as an answer, you also need to 
#### cut and paste into this document the value(s) that is actually printed.

# My birthday is September 2nd, 1999 (I wish).
# Using the convention MMDDYYYY, then my birthday number is
# 09021999

#### Q1. [10 pts. 2 each]

#a Store the due date of this Assignment (Feb 5) into a variable "dday" using MMDDYYYY format.
#  (It doesn't matter if number starts with a leading 0 - include it.)
dday <- 02052024
# Now write code to find and print the answer for all parts:
#b The cube root of dday.
print()
#c The log base 12 of dday.

#d dday modulo 9. (That's the remainder, after dividing by 9. Use the "%%" operator.)
print(dday %% 9)
#e Is dday greater than 03000000? Use comparison operators and return TRUE or FALSE.
print(dday > 03000000)
#### Q2.[14 pts. 2 each]

#a  Create the two vectors of numbers alpha = (250, 290, 330,..., 1410)
#                                     beta  = (2400, 2320, 2240, ..., 80)  
alpha <- (c(1:35) * 40 + 10)[-c(1:5)]
#b Create a new vector gamma that is the elementwise products of alpha and beta.

#c What is the sum of the elementwise product of the two vectors?

#d What is the maximum value in gamma?

#e What is/are the indices (position in the vector) of the maximum value found in part d?
# The command which may be helpful here. 

#f How many of the elements of gamma are strictly greater (>) than 520520?

#g How many of the elements of gamma are strictly (i.e. > and <) between the median and the mean of gamma?

#### Q3. [10 pts. 2 each]

#a Set the random number seed to 2024. - No points
set.seed(2024)
#b Create two vectors, named x and y of standard normal random variables, each of length 100000.
x <- rnorm(100000)
y <- rnorm(100000)
#c Create a third vector, called z, containing the square root of the element-wise sum
#  of the squares of the elements of x and y.
#  That is, each element in z is the square root of the corresponding x_squared + y_squared

#d  Find the median of the elements in the z vector. Print the result. 

#e Write code to create and store in a variable (vector) the first 100000 terms in the sequence: (no need to print this one)
# {1/3, 1/9, 1/27, 1/81, 1/243, ... } 

#f Take the sequence in part e and sum all the elements. Find the product of this sum and the median of z?

#### Q5. [10 pts. 2 each] A political polling company asked voters:
#### "How likely are you to vote in the next election?" 
#### People answered on a 1 through 5 numeric scale, where: 
#### 1 was "definitely no"
#### 2 was "probably no"
#### 3 was "maybe" 
#### 4 was "probably yes" 
#### 5 was "definitely yes" 
####
#### Analysts needed to recode this numeric variable into a
#### two-level ordered factor, with levels:
#### "Inactive voter" if they had answered with a 1 or 2,
#### and "Active voter" if they had answered with a 3, 4 or 5.

#### Here's the raw data:
raw.scores <- c(5, 3, 1, 4, 4, 5, 2, 1, 1, 5,
                5, 1, 3, 4, 4, 1, 4, 2, 3, 2, 
                3, 1, 1, 1, 3, 2, 3, 1, 4, 5)

#a Write code to create and store a logical vector that takes on the value TRUE if
#  the raw score was 3, 4, or 5, and FALSE otherwise.	You dont have to use an"if" command. You can manually type in

#b Using the logical vector from part a, replace the values 1 and 2 in raw.scores with the
#  value 1 and the values 3, 4, and 5 with the value 5. You can do this in multiple steps if you want.
#  Call this new numeric vector "mod.scores". At this point
#  mod.scores should only contain the values 1 and 5.

#c Create and store from "mod.scores" an ordered factor variable from the modified data with the 
#  labels "Inactive", and "Active".
#  "Inactive" should be the lower of the two levels in the ordered factor. 
#  Hint: See Class 1 slides. 

#d  Summarize the new data with the "table" command. Store the table and paste it below.

#e  Write code to identify and only print the new level that occurred most frequently and how often it occurred.

#### Q6. [12 pts. 2 each for a-c; 3 each for d,e]

#a What is a key difference between the list extraction operators [ and $?

#b Reset the random number seed to 2024. 

# Paste the following code into R

my.list <- list(X = c(sample(x=100,size=100,replace=TRUE)), B = matrix(data=rnorm(36),ncol=6), 
                ZETA = list(ALPHA = matrix(data = sample(x=10,size=64,replace=TRUE),ncol=8), 
                            BETA = matrix(data = rnorm(64),ncol=8)))

#c Write code to extract and print the value of the [2,4] element in the B matrix.

#d Write code to extract and find the sum of all of the elements in the 
#  matrix product (%*%) of the two matrices ALPHA and BETA.

#e Rename the element called "B", as "Y", and paste both the command you used 
#  and the output from the names() command to show that you did it successfully.   

#### Q7. [21 pts; 3 each]
## For this question, no need to print the resulting matrices unless specifically asked for.

#a Set the random number seed to 2024 again. - No points

#b Create a 1000 x 1000 matrix of standard normals (mean = 0, sd = 1). (No need to print the matrix)

#c Store the transpose of the matrix created in part b (the transpose swaps the rows and columns).  

#d  Multiple the original matrix (on the left) by its transpose (on the right) 
#  (use, matrix multiplication, "%*%", not element-wise) and store the result.

#e  Find and store the inverse of the matrix created in part d.  

#f  Find and print the sum of the elements of the leading diagonal (top left to bottom right)
#   of the inverse matrix. (The command "diag" is very useful here).

#g Using the apply function, store the mean of each row of the original matrix from part b in a vector .
# (No need to print the vector)

#h Find and print the standard deviation (R command "sd") of these 10000 row means.
#  What you have just done is empirically estimate the standard error of the sample mean.

#### For Q8 below, download (using 'load' or 'Open' menu function)the .Rdata file called "hw1_spring_2024.Rdata" available on Canvas and read it in to R using R-studio.
#### This will bring all the objects you need for the homework straight into R-studio.

#### Q8 [23 pts; 3 each for a-f; 5 for g]

#a. What is a key difference between a list and a data frame?

# You will have read in a data frame called "waystar.df" which contains information on the price of Waystar Royco stock for 2018-19.

#b How many rows and columns does this data frame have? (Write code to extract the answer).

#c What was Waystar Royco's lowest daily trading volume and on what day did this occur? Show your code that identifies the min volume day. 
#  The function "which.min" can also be very useful if you want to try something new.

#d Create and add to the data frame a new column called "Return" that calculates the intraday return
#  of Waystar Royco stock. The intraday Return is defined as (Closing Price - Opening Price). Closing Price is represented by the Price column.
#  Use the "head" function to print the first 5 rows of the data frame that now includes the Return variable.

#e. What was Waystar Royco's average daily return over this time period? 

#f. What was the standard deviation of Waystar Royco's daily return over this time period (use the "sd" function)?

#g. There is a column in the data frame called "MonthOfYear". It has been entered numerically, 1 for January etc.
#   Turn "MonthOfYear" into an *unordered* factor (with labels "Jan", "Feb" etc.) 
#   and overwrite the old MonthOfYear variable in the data frame.
#   Show your code that creates and inserts the factor month-of-year variable.
#  Hint: See Class 1 slides. 

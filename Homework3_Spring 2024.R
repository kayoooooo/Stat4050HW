#### STAT 4050/7050 Homework 3, SPRING 2024
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


#### Q1. (30 points)

#a 10 points
# Write a function called "skew.transform" that takes a numerical vector input (x), and if the input is both
# non-negative AND highly skewed, it returns the natural log of the input vector.
# If the input, x, doesn't satisfy both these conditions then skew.transform should just return x itself. 

# The function should have two arguments in addition to x, each with default values.
# The first additional argument should be called "thresh" which takes a single non-negative numeric value.
# Default its value to 1.5.
# The role of "thresh" is so that the user can decide for themselves the cut-off level of skewness at which they will transform. 

# The second additional argument should be called "offset" which accepts a single non-negative numeric value.
# Default its value to 0.5.
# The offset argument will be added to the entire input vector before the log is taken. The reason for this is  
# that the log of 0 is -Infinity, so that the role of the offset is to add a positive constant to the data 
# prior to the log transform. This way, there will be no -Infinity results.  
# Note that the constant is added to every element in the vector, not just those with a zero value.

# Paste your "skew.transform" function here:
# Hint: You can start with the skewness function you created for the previous homework

skewness <- function(vec) {
  vmean <- mean(vec)
  vdev <- sd(vec)
  n <- length(vec)
  skew <- 0
  for (x in vec) {
    skew <- skew + ((x - vmean)/vdev) ** 3
  }
  return ((n / (n-1) / (n-2)) * skew)
}

skew.transform <- function(vec, thresh = 1.5, offset = 0.5) {
  if (!is.numeric(vec)) {
    stop("invalid")
  }
  if (thresh < 0) {
    stop("invalid")
  }
  if (offsetd < 0) {
    stop("invalid")
  }
  for (x in vec) {
    if (x < 0) {
      return (vec)
    }
  }
  skewn <- skewness(vec)
  if (skewn > thresh) {
    return (log(vec + offset))
  }
  return (vec)
}


# 5 points
#b For the PRSM data set calculate mean of the skew.transform values for the column "Num.of.Legal.Items"
# in the PRSM dataset and paste the result below.
# To load the PRSM data into R, simply downlaod the file from Canvas
# and double click to open.

legal.mean <- mean(skew.transform(PRSM$Num.of.Legal.Items))
legal.mean

# [1] 0.4581759


# 15 points
#c Extract just the numeric columns of PRSM Data into their own new data frame, called PRSM.num 
#  Apply the skew.transform function to this new dataset
# and display the mean of the transformed values. Also make sure to Paste the code that you used for the extraction.
# Hint: to determine which columns are numeric, follow the same logic as the Infection data is.dichotomous function

PRSM.num <- PRSM[sapply(PRSM, is.numeric)]
PRSM.transformed <- sapply(PRSM.num, function(x) mean(skew.transform(x)))
PRSM.transformed

# Amt.Repaid.at.6.Months                     Nominal.Loan.Amount                  Total.Amt.to.be.Repaid 
# 9.0689876                              10.0227054                              10.2072404 
# Repayment.Percentage                      Commission.Upfront                 Validated.Monthly.Batch 
# 12.1891892                               7.7404094                               9.9392291 
# Historical.Monthly.Credit.Card.Receipts                       Months.of.History                                    FICO 
# 9.9223130                               5.0730731                             572.1061061 
# Years.In.Business                     Num.of.Credit.Lines                      Satisfied.Accounts 
# 1.9618922                              26.0270270                              17.4504505 
# Num.of.Paid.off.Credit.Lines         Current.Delinquent.Credit.Lines        Previous.Delinquent.Credit.Lines 
# 13.2942943                               0.7162872                               1.3228351 
# Years.in.File                      Num.of.Legal.Items                      Num.of.Trade.Lines 
# 6.8078078                               0.4581759                               0.3438051 
# Num.of.Derog.Legal.Item                      Two.Digit.SIC.Code                  Population.in.Zip.Code 
# -0.1905868                              61.0940941                           28469.6706707 
# Male.Population.in.Zip.Code           Female.Population.in.Zip.Code         Average.House.Value.in.Zip.Code 
# 14003.4054054                           14504.2532533                              11.8169968 
# Income.Per.Household.in.Zip....                  Median.Age.in.Zip.Code                               Time.Zone 
# 45824.9449449                              35.9357357                               5.9939940 
# Bus.Establishments.in.Zip.Code                  Employment.in.Zip.Code              Annual.Payroll.in.Zip.Code 
# 6.4094068                               9.0017540                              12.2837667 
# PO.Residential.Count.in.Zip                PO.Business.Count.in.Zip                          Delivery.Total 
# 10142.8098098                               6.3439598                           11004.2222222


#### Q2. (30 points)

# Imagine a game (like Powerball), which has marble balls with different colors and numbers. This version of the game has
# Red Blue and Green colors and numbers from 1 to 5 for each color (a total of 15 possible marbles).
# You draw 2 marbles each turn and if you draw a '5' of any color or a Green marble of any value, 
# then you win. Else you lose.



#a (5 points)
# Create a full set of 15 marbles using the rep and paste commands. Sample 2 random marbles from this set and show the output.
# The format of the hand should be "number-color". So, a green marble with a number 3 should be denoted by "3-G"

marbles <- paste(rep(c(1:5), 3), rep(c("R", "G", "B"),3), sep = "-")

marbles
# [1] "1-R" "2-G" "3-B" "4-R" "5-G" "1-B" "2-R" "3-G" "4-B" "5-R" "1-G" "2-B" "3-R" "4-G" "5-B"

print(sample(marbles, 2))
# [1] "3-R" "4-G"


#b (15 points)
# Write a function did.I.win that calculates whether you won a game or not. It should take in a hand and return TRUE (win) or FALSE (lost)
# Eg: did.I.win(c("3-R" ,"5-G")) should return TRUE
# Eg: did.I.win(c("1-R","2-B")) should return False

did.I.win <- function(vec) {
  return (substring(vec[1],1,1) == "5" | substring(vec[2],1,1) == "5" | substring(vec[1],3,3) == "G" | substring(vec[2],3,3) == "G")
}

did.I.win(c("3-R" ,"5-G"))
# [1] TRUE

did.I.win(c("1-R","2-B"))
# [1] FALSE


# c (15 points)
# Write code that simulates playing this imaginary game (drawing 2 marbles each time and determining whether you win or lose)
# and calculate the average probability of winning over 100K simulation runs. Set random number seed at 2024 before simulating.

set.seed(2024)
rolls <- rep(NA, 100000)
for (i in 1:100000) {
  draw <- sample(marbles,2)
  rolls[i] <- did.I.win(draw)
}
prob <- sum(rolls) / 100000
prob
# [1] 0.73427


##Q3 Dice probabilities (30 points)

## WE will simulate playing a game of dice with R. Each time you play this game, you will roll 3 independent dice 
## at the same time. 

# a. (7.5 points) Using the sample command, create a function that simulates the results of a throw from 3 independent dice.
# Call it threedice and it doesn't need to take in any arguments. For example, when I run this in R, I get:
# > threedice()
# > 3 2 6  # Three random values
# Hint: for the next 3 questions, please note that the output of the threedice() function can be manipulated
# as a vector. For example, you can get the following for the above random values:
# > sum(threedice())
# > 11

threedice <- function() {
  return (sample(1:6, 3, replace = TRUE))
}


# Using the threedice function, now perform 100000 iterations of throwing the three imaginary dice and 
# Calculate the probabilities of the following (Set seed to 2024 before each of these 3 calculations):

# b.(2.5 pts) The probability that the sum of the numbers on the dice is greater than 10 and less than 15.
set.seed(2024)
rolls <- rep(NA, 100000)
for (i in 1:100000) {
  rolls[i] <- sum(threedice())
}
prob <- sum(rolls > 10 & rolls < 15)/100000
prob

# [1] 0.40625


# c.(2.5 pts) The probability that the sum of the dice is divisible by 6
set.seed(2024)
rolls <- rep(NA, 100000)
for (i in 1:100000) {
  rolls[i] <- sum(threedice())
}
prob <- sum(rolls %% 6 == 0)/100000
prob

# [1] 0.16666


# d. (2.5 pts) The probability that the mean of the numbers thrown is exactly 3
set.seed(2024)
rolls <- rep(NA, 100000)
for (i in 1:100000) {
  rolls[i] <- mean(threedice())
}
prob <- sum(rolls == 3)/100000
prob

# [1] 0.11561


# e. STRETCH: (15 pts; 5 for simply attempting and some semblance of logic) Imagine you are playing this game 
# at a casino, involving no $. If you roll "three dice that sum to 6 or less" 
# 2 consecutive times, then you will need to go home. Otherwise you get to keep playing and have fun.
# Calculate (using 10K simulations and a seed of 2024)
# the average number of games you expect to play that night before you need to go home.
# Remember that you will play at least 2 games and that will be your starting point.

# Hint: Refer to the in class example where we evaluated how many cards we need to draw until we see an ace.

set.seed(2024)
rolls <- rep(NA, 10000)
for (i in 1:10000) {
  prev <- FALSE
  count <- 0
  while (TRUE) {
    x <- sum(threedice())
    count <- count + 1
    if (x <= 6) {
      if (prev) {
        break
      }
      prev <- TRUE
    } else {
      prev <- FALSE
    }
  }
  rolls[i] <- count
}

expected <- mean(rolls)
expected

# [1] 126.6267


# Q4. 10 points
# Write a function called "is.perf.sq.matrix" that takes a matrix and prints out all the perfect squares* from 
# that matrix. You will likely benefit from using nested for loops. Also take a look at the commands nrow and ncol.
# Copy and paste your code for defining the function is.non.negative.matrix below.
# Use the function on the following matrix and report the output
# My.Mat<-matrix(c(3,4,2,2,3,4,5,9,8),3,3)
# Perfect Square = an integer that is the square of an integer
# You can write your own function to check if a number is a perfect square or not.

is.perf.sq.matrix <- function(matr) {
  for (i in 1:nrow(matr)) {
    for (j in 1:ncol(matr)) {
      if (sqrt(matr[i,j]) == floor(sqrt(matr[i,j]))) {
        print(matr[i,j])
      }
    }
  }
}

My.Mat<-matrix(c(3,4,2,2,3,4,5,9,8),3,3)

is.perf.sq.matrix(My.Mat)

# [1] 4 
# [1] 9
# [1] 4

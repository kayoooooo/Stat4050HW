#### STAT 4050/7050 Take-Home Final, SPRING 2024
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
#### 4. When submitting to Canvas/Gradescope, please change the file extension to .txt or.PDF, otherwise it cannot be submitted.

## ------------------------------------------------------------------------
# Q1. Helicopters (15 points)

# You are the commander of a squadron that consists of 20 helicopters. Unfortunately helicopters can break down and                                                                                                                   be out of action)
# be out of action due to maintenance.
# In this question you will estimate the probability that at some point over the course of the next year at least
# 6 of the helicopters are inoperable.

# a. Start by setting the random number seed to 2024 and show the code you use to do this. (No points)

# The first step is to create a container (matrix) that will indicate the status of the helicopters on each day 
# over the course of a year.
# The matrix will have 20 rows and 365 columns.
set.seed(2024)

# b. Create a matrix of the correct dimensions, but initially populate it entirely with NAs. Call it "helihist"
# You don't have to print it. (2)
helilist = matrix(nrow = 20, ncol = 365)

# c. Create a function that returns the maintenance history, called "mainthist" of one helicopter.
# This function will take three arguments:
# 1. numdays: the number of days of history to generate (default to 365)
# 2. maintlength: the length of days that a helicopter is out of action for maintenance (default to 7)
# 3. meanfail: the average time until the next failure for a working helicopter (default to 56)

# The function should return a numeric vector of length "numdays" populated with 0's and 1's. 
# 0's indicate days that the helicopter is operational, and 1's indicate the days on which the 
# helicopter is undergoing maintenance.

# Use an exponential distribution to generate the time until the next failure occurs.
# The command "rexp(1, rate = 1/meanfail)" will generate an appropriate exponential random variable.
# This type of variable is continuous, so round it up to a whole number (integer) by using the "ceiling" command.

# It is probably easiest to generate the yearly history sequentially.
# First generate the integer failure time random variable and start a vector with that many 0's (use the rep function). 
# Then immediately attach a vector of length "maintlength" of 1's to the vector.
# Continue this process using a *while* loop until the vector has at least "numdays" entries. If your vector ends up larger than "numdays" you can 
# shorten it to the right number of days before returning it.

# By way of example, when I run my mainthist function with some random seed and default values, it returns:

# print(mainthist())
#  [1] 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 0 1 1 1 1 1 1 1 0 0
# [73] 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 0 0 0 0 0 0
#[145] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
#[217] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0
#[289] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
#[361] 0 0 0 0 0
# this means that the helicopter was fine for the first 12 days, then went into maintenance for the next 7 and so on.

# Show your function together with the result of running it with default argument values. (5)
mainthist <- function(numdays = 365, maintlength = 7, meanfail = 56) {
  maint <- rep(NA, numdays)
  working <- FALSE
  daysuntil <- ceiling(rexp(1, rate = 1/meanfail))
  workcounter <- 0
  for (i in 1:numdays) {
    if (working) {
      maint[i] <- 1
      workcounter <- workcounter + 1
      if (workcounter == maintlength) {
        daysuntil <- ceiling(rexp(1, rate = 1/meanfail))
        working <- FALSE
      }
    } else {
      maint[i] <- 0
      daysuntil <- daysuntil - 1
      if (daysuntil == 0) {
        workcounter <- 0
        working = TRUE
      }
    }
  }
  return (maint)
}

# d. Using a for loop, populate the helihist matrix for all 20 helicopters. Show your code and print out the last row of the helihist matrix. (2) 
for (i in 1:20) {
  helilist[i,] = mainthist()
}
helilist[20,]

#  [1] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
# [56] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
#[111] 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
#[166] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 0 0 1 1 1 1 1 1 1 0 0 1 1 1
#[221] 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
#[276] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
#[331] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0


# e. Using the apply and sum functions, create a vector that contains the counts of how many 
# helicopters are in maintenance for each day of the year. Show your code and print the vector of counts. (3)
maint <- apply(helilist, 2, sum)
maint

#  [1] 0 0 0 0 0 0 1 1 1 1 1 1 2 1 1 2 2 4 4 3 3 3 2 2 2 2 2 3 3 4 5 3 3 4 3 5 4 3 4 4 4 4 3 3 3 2 2 1 1 2 2 2 2 2 4
# [56] 4 2 2 3 3 4 2 2 2 2 1 1 0 0 1 2 2 2 3 3 3 4 3 3 3 2 3 3 1 3 3 3 4 3 3 3 1 1 1 1 2 2 2 2 3 4 3 2 2 2 3 2 1 1 2
#[111] 2 2 2 3 3 3 2 2 2 3 2 2 2 2 3 3 1 2 3 3 3 2 2 2 1 0 0 0 0 0 1 1 1 1 1 1 1 0 0 1 1 1 1 1 2 2 2 2 3 3 3 2 2 2 2
#[166] 1 1 1 1 1 1 1 1 1 1 2 2 1 1 1 1 1 0 0 0 1 1 1 2 2 2 2 1 2 2 1 1 2 2 3 2 2 2 2 1 1 0 0 1 2 3 3 3 3 4 3 2 2 2 2
#[221] 4 3 3 3 2 2 2 0 0 0 1 1 1 1 1 1 1 0 1 1 1 1 1 2 3 3 3 3 3 3 2 2 1 2 4 4 4 4 3 3 2 0 0 0 0 0 0 1 1 1 1 2 2 2 1
#[276] 2 3 4 4 4 4 4 3 2 1 1 1 1 2 3 5 5 4 4 4 3 2 0 2 3 3 3 3 3 3 1 0 0 0 0 0 0 0 0 0 0 0 1 2 2 3 3 3 3 4 4 4 3 3 3
#[331] 3 1 0 0 1 2 2 2 2 2 2 1 1 1 1 1 1 2 2 1 1 1 2 2 1 1 1 1 1 0 0 0 0 0 0


# f. Create a variable (flag) that takes on the value 1 if at any point in the year the number of out-of-action helicopters is greater
#    than or equal to 6, and takes on the value 0 otherwise. (The "ifelse" command is a nice way to do this.). Show your code and
#    print the value of the flag variable. (3)
flag <- ifelse(max(maint>=6), 1, 0)

# [1] 1


#Q2. With all the above pieces in place, you can now estimate the probability that at some point in the year at least 6 
#   helicopters are out-of-action. (30 points)

#a. Create a variable (numits) containing the number of iterations for the simulation, set at a value of 1000. (2)
numits <- 1000

#b. Create a vector (called results) of length numits initially full of NAs to hold the outcomes from each iteration. 
# There is no need to print it. (2)
results <- rep(NA, numits)

#c. Create and run a for loop of numits iterations, inside of which is the code you built in 
# the previous question. Remember that this is a nested for loop, one level for each of the simulations 
# and the second level for each of the helicopters within each simulation (18)

for (i in 1:numits) {
  helihist <- matrix(nrow = 20, ncol = 365)
  for (j in 1:20) {
    helilist[j,] <- mainthist()
  }
  maint <- apply(helilist, 2, sum)
  flag <- ifelse(max(maint>=6), 1, 0)
  results[i] <- flag
}
prob <- mean(results)
prob

#e. After running the for loop, what is your estimate of the probability that at least 6 helicopters are out-of-action
# at some point during the year? Make sure you print this value and paste the output below. (8)


## ------------------------------------------------------------------------
#Q3. 30 points 
# Read in the outpatient.csv dataset
# And create the SchedLag variable as follows
# This code creates this new variable that calculates
# the time in days between calling for an appointment and 
# your schedule appointment date. This kind of data cleaning and wrangling
# will be part of all your real world data analytics projects.

outpatient <- read.csv("STAT4050/Outpatient.csv")
outpatient$SchedDate <- strptime(outpatient$SchedDate, format="%m/%d/%Y")
outpatient$ApptDate <- strptime(outpatient$ApptDate, format="%m/%d/%Y")
outpatient$SchedLag <- (outpatient$ApptDate - outpatient$SchedDate)
outpatient$SchedLag <- as.numeric(outpatient$SchedLag)/(60 * 60 * 24) 

summary(outpatient$SchedLag)

#3a. Delete all rows with SchedLag values <0 and > 300 (2)
outpatient <- outpatient[(outpatient$SchedLag >= 0 & outpatient$SchedLag <= 300),]

# 3b. Using ggplot2, Create a histogram of Schedule Lag
# with bin width of 20 from 0-300 and solid red 
# fill and black borders, Frequency on Y-axis
#Capture the output in a JPG or PDF file (6)
library(ggplot2)
library(dplyr)

g1 <- ggplot(outpatient, aes(x = SchedLag, xmax = 300)) + geom_histogram(binwidth = 20, fill = "red", color = "black")
g1

#3c. Create a Pie chart of the frequent races
# and all other races other than the Top 3 should be lumped
# into fourth ("OTHER") category
# Capture the output in a JPG or PDF file (6)
# There should only be 4 total categories shown in the pie chart. 
top_races <- names(sort(table(outpatient$Race), decreasing = TRUE))[1:3]
outpatient$Race <- ifelse(outpatient$Race %in% top_races, outpatient$Race, "OTHER")

g2 <- ggplot(outpatient, aes(x = "", y = "", fill = Race)) +
  geom_col() +
  coord_polar(theta = "y", start = 0)
g2
# Hint: The command %in% may be useful

# 3d. Using ggplot2, create a Box plot of the 
# SchedLag by Race (with 4 categories - The Top 3 & other)
# Capture the output in a JPG or PDF file (6)

g3 <- ggplot(outpatient, aes(x=Race, y=SchedLag)) + 
  geom_boxplot(fill="slateblue", alpha=0.2) + 
  xlab("Race")
g3

# 3e. Create scatterplot of patient Schedule Lag times on Y axis 
# and age on horizontal axis with
# points color coded based on what their appointment 
# status was.
#Capture the output in a JPG or PDF file (10)
outpatient$Status <- as.factor(outpatient$Status)
g4 <- ggplot(outpatient, aes(x = Age, y = SchedLag, color = Status)) + geom_point()
g4

##Q4. Bootstrap and animation 25 points
## Load the boot and animation libraries

# 4a. From the dataset, 
# Further delete patients with ages <5 and Ages > 79
# And convert Age to numeric by coercion. (2)
outpatient <- outpatient[(outpatient$Age >= 5 & outpatient$Age <= 79),]
outpatient$Age <- as.numeric(outpatient$Age)

# 4b. Create a new dataframe subsetting just Schedule Lag
# and Age, i.e., Two columns only. Name the df dboot (4)
dboot <- outpatient[,c("SchedLag", "Age")]
dboot

#4c. 
# Write a function called beta_coef that can be input
# to the boot command. It takes in the data and the random index for 
# bootstrap samples and output the regression coefficient 
# estimate of the slope when the SchedLag
# (Y) is regressed on to the Age (X) of the patient. (5)
library(boot)
beta_coef <- function(data, index) {
  bootstrap_data <- data[index,]
  model <- lm(SchedLag ~ Age, data = bootstrap_data)
  slope <- coef(model)["Age"]
  return(slope)
}


# 4d
# Create a 95% confidence interval for beta_coef
# using bootstrapped samples from dboot for a total of
# 100 replicates. Also plot the histogram and the Normal QQ plot
# Remember to set the seed to 2024 first (8)

set.seed(2024)

boot_results <- boot(dboot, beta_coef, R = 100)
conf_interval <- boot.ci(boot_results, type = "perc")$percent[,4:5]
hist(boot_results$t, main = "Histogram", xlab = "Beta Coefficient")

qqnorm(boot_results$t)
qqline(boot_results$t)


#4e. 
# Create an animation that shows the 
# 100 estimates of the beta_coef in a dynamic plot?
# Please capture a screenshot of the animation as 
# a JPG or PDF file at the point when all 100 points are shown (6)
library(animation)
estimate_beta <- function(n) {
  x <- rnorm(n)
  y <- 0.5 * x + rnorm(n)
  beta_coef <- cov(x, y) / var(x)
  return(beta_coef)
}
num_estimates <- 100
plot.new()
plot.window(xlim = c(1, num_estimates), ylim = c(-0.5, 0.5),
            xlab = "Estimate Number", ylab = "Beta Coefficient",
            main = "Estimation of Beta Coefficient")
beta_estimates <- numeric(num_estimates)
ani.record(reset = TRUE)
for (i in 1:num_estimates) {
  beta_estimates[i] <- estimate_beta(100)
  points(i, beta_estimates[i], pch = 19, col = "blue")
  ani.record()
}

saveHTML(ani.replay(), img.name = "beta_coef")


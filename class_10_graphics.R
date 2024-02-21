# Start by inspecting prev class plots: hist, ecdf, lm plots (actual accidents!pers.acc.rate) etc)

# Basic syntax of a 2D plot
?plot

#Some Simple commands
x<-c(1,3,5,7,9)
y<-c(2,4,6,9,21)
plot(x,y)
plot(x,y,type='l')
plot(x,y,type='l',lwd=3)
plot(x,y,type='l',lwd=3,col=2)


plot(x = c(0,1), y = c(0,1), # this gives the unit square as a canvas
     main = "My plot title", # add a title 
     xlab = "X-axis title",  # add an x-axis label
     ylab = "Y-axis title",  # add a y-axis label
     type = "n")             # don't actually plot anything yet	 

points(x = c(0.25,0.75), y = c(0.5,0.75)) # Add a couple of points to the graph
lines(x=c(0.25,0.75), y = c(0.5,0.75))    # Join them up with a line
polygon(x = c(0.25,0.6,0.35), y = c(0.25, 0.45, 0.4)) # A polygon
text(x = c(0.7),y = c(0.8), labels = c("Here is some text")) # Add text

# now with some visual enhancements to lines 11-14 using options
points(x = c(0.25,0.75), y = c(0.5,0.75),pch=17,col="red")
# using red triangles at vertices
lines(x=c(0.25,0.75), y = c(0.5,0.75),lwd=3,lty=4,col="blue")
#blue lines (thicker using a larger lwd)
polygon(x = c(0.25,0.6,0.35), y = c(0.25, 0.45, 0.4),col="green")
# Filled polygon with green color
text(x = c(0.7),y = c(0.8), labels = c("Here is some text"),
     col="orange",cex=2.0)# Changing text to orange

dev.off()



par(mfrow=c(2,2)) # Set up a two-by-two grid of plots

# Now make  a series of plots:

plot(x = c(0,1), y = c(0,1), # this gives the unit square as a canvas
     main = "Plot 1")

plot(x = c(0,1), y = c(0,1), # this gives the unit square as a canvas
     main = "Plot 2",type='n')

plot(x = c(0,1), y = c(0,1), # this gives the unit square as a canvas
     main = "Plot 3",type='l',lty=1)

plot(x = c(0,1), y = c(0,1), # this gives the unit square as a canvas
     main = "Plot 4",type='l',lty=2)

dev.off()

## ----Plotting the first 20 colors

plot(x = c(0,1), y = c(0,1), # this gives the unit square as a canvas
     xlab="",ylab="",main = "Colors",type="n")
for(i in 1 :20){
  lines(x = c(0.05,0.95),
        y = c(i/20,i/20),
		col=i, # The numbered colors
		lwd=7) # line width 
}
	 
## ------------------------------------------------------------------------
length(colors())  # There are plenty of colors 
colors()[1:30] #Here are the names of the first 30; colors[1:30] wont work since colors is a function.

#### View all the colors available by name:
plot(x = c(1,26), y = c(1,26), # this gives a square as a canvas
# Why did I choose a 26x26 square?     
       xlab="",ylab="",main = "Colors by name",type="n")
counter <- 1 # Keep track of the latest color
for(i in 1:26){ # Loop over the x-axis
  for(j in 1:26){ # Loop over the y-axis
    polygon(  # We will fill a square with each color in turn
	        x = c(i,(i+1), (i+1), i),
            y = c(j, j,(j+1), (j+1)),
            col=colors()[counter] #Specify the color by name
            )
    counter <- counter + 1         			
  }
}


## ------------------------------------------------------------------------

data("mtcars")

hist(x = mtcars$disp) # A basic histogram

hist(x = mtcars$disp, # A more custom histogram
     breaks=seq(60,500,40), # Choose break points
     # Plot probabilities
     # Control shading
     # Specify color
     # Specify border
     freq=FALSE,
     density=72,
     col=2,
     border=1,
     xlab="Dispacement", # Create x-axis label
     main = "Histogram of Engine Dispacement"# Plot title
)

#Exercise: Create a frequency histogram of number of cylinders.
# Title = "Cylinder Distribution", X-axis should be labeled "Num Cyl"
#  bar colors red .

## ----basic-Scatter-plots
plot(x = mtcars$hp, y = mtcars$mpg,
     main="Engine Power vs MPG",
     xlab="HP (Power)",
     ylab = "MPG",
     col=2)

# exercise: Create a scatterplot of the 1/4 mile times
# size of points = 2x magnification, color of points = orange
# shape of points is a triangle;

#http://www.sthda.com/english/wiki/r-plot-pch-symbols-the-different-point-shapes-available-in-r
#
#Barplot
barplot(sort(table(mtcars$gear),decreasing=TRUE),
        # The top gear types
        cex.names=1.5, # Make the names larger to view
        col=c(1:3), # Specify the color palette
        main="Gear frequency") # Add a title


#Pie chart of Top 3 carburetor frequencies


pie(sort(table(mtcars$carb),decreasing=TRUE)[1:3],
    # The top 3 types
    col=c(1:3), # Specify the color palette
    main="Number of carburetors") # Add a title

# add labels
label <- rownames(sort(table(mtcars$carb),decreasing=TRUE)[1:3])
pie(sort(table(mtcars$carb),decreasing=TRUE)[1:3],
    # The top 3 types
    col=c(1:3), # Specify the color palette
    main="Number of carburetors", # Title
    labels=(as.numeric(label))) # Add a label

#Exercise: Create a pie chart of the number of gears
# make the number of colors equal to the number of distinct gears
# Title is "Num Gears", also the X-axis title
# Add labels next to each color that says "Gears =  ..."


## ------------------------------------------------------------------------
# Read in the library
# First need to install the package

library(ggplot2)

diamonds <- read.csv("Diamonds.csv")
dim(diamonds)
head(diamonds)

plot(diamonds$Carat,diamonds$Price,main="Price v. Carat",xlab="Carat") #Plot the data
abline(lm(Price ~ Carat, data = diamonds),col=2,lwd=2) # Add the LS line

qplot(x = Carat, y = Price, data = diamonds,  geom="point")

qplot(x = Carat, y = Price, data = diamonds,  color = Color, geom="point")

qplot(x = Carat, y = Price, color = Color, 
      facets = ~ Clarity, data = diamonds,  geom="point")

dev.off()


# Now lets use the gpplot function

# This defines the features in the plot (but shows nothing)
my.plot <- ggplot(data = diamonds, 
                  aes(x = Color, y = log(Price), fill = Color)) 
 # Now add a layer
my.plot + geom_boxplot()

#Exercise: make the box-plot horizontal:

# Refine the vertical boxplot more.
my.plot + 
  geom_boxplot() + # Now add a layer and some thematic elements
  ggtitle("A new title") +
  theme(plot.title=element_text(face="bold.italic", size="24", color="black")) + 
  theme(axis.title=element_text(size="18", color="black")) + 
  theme(axis.text=element_text(size="14", color="black")) + 
  theme(panel.background = element_rect(fill = "#BFD0DF"))


 # A basic histogram  
ggplot(data = diamonds, aes(x = log(Price))) + 
       geom_histogram(binwidth=0.5,col=1,fill=19)


#Overlaying a transparent density	   
ggplot(data = diamonds, aes(x = log(Price))) + 
      geom_histogram(binwidth=0.5,col=1,fill=19,aes(y=..density..)) +
      geom_density(alpha=.2, fill=2) 		  

#STOP and quick review others?

# Stacked histogram
ggplot(data = diamonds, aes(x = log(Price),fill=Color)) + 
      geom_histogram(binwidth=0.5) 	   


# Price densities for each color
ggplot(data = diamonds, aes(x = log(Price),fill=Color)) + 
       geom_density(alpha=.3)
   


# Add Cut as a facet
 ggplot(data = diamonds, aes(x = log(Price),fill=Color)) + 
       geom_density(alpha=.3) + 
	   facet_grid(~ Cut)


# Add Cut and Polish as a facet
# Turn off warnings
options(warn = -1)
 ggplot(data = diamonds, aes(x = log(Price),fill=Color)) + 
       geom_density(alpha=.3) + 
	   facet_grid(Polish ~ Cut)


## How to save a graph to PC?

 
 
#Done
 
 
 
 
 
 
 #https://rpubs.com/GinaMoreno__/course1_4
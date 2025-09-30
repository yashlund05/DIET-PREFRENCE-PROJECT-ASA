# Create the scatter plot
plot(x = df$What.is.your.age., 
     y = df$How.confident.are.you.that.your.current.diet.meets.your.nutritional.needs...1..not.at.all.confident..5..extremely.confident.,
     main = "Age vs. Nutritional Confidence with Regression Line",
     xlab = "Age",
     ylab = "Confidence Rating (1-5)",
     pch = 19,
     col = "lightblue")

# Add the regression line to the plot
abline(regression_result, col = "red", lwd = 2)

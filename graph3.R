# Step 1: Install and load the corrplot package (only need to install once)
install.packages("corrplot")
library(corrplot)

# Step 2: Select only the numerical columns from your dataframe
numerical_data <- df[, c("What.is.your.age.", 
                         "How.confident.are.you.that.your.current.diet.meets.your.nutritional.needs...1..not.at.all.confident..5..extremely.confident.",
                         "How.important.are.ethical.or.environmental.concerns.in.your.food.choices...1..not.important..5..extremely.important.")]

# Step 3: Calculate the correlation matrix
cor_matrix <- cor(numerical_data)

# Step 4: Create the correlation plot
corrplot(cor_matrix, method = "color", 
         addCoef.col = "black", # Add correlation coefficients
         tl.col = "black", tl.srt = 45, # Text label color and rotation
         main = "Correlation Matrix of Numerical Variables",
         mar=c(0,0,1,0)) # Adjust margin


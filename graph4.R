# STEP 1: Start with a clean slate
rm(list = ls())

# STEP 2: Load your data from the CSV file. This creates the 'df' data frame.
# (Make sure the path is correct)
df <- read.csv("D:/yash python/synthetic_diet_responses.csv")

# STEP 3: Now that 'df' is a data frame, select the numerical columns
numerical_data <- df[, c("What.is.your.age.", 
                         "How.confident.are.you.that.your.current.diet.meets.your.nutritional.needs...1..not.at.all.confident..5..extremely.confident.",
                         "How.important.are.ethical.or.environmental.concerns.in.your.food.choices...1..not.important..5..extremely.important.")]

# STEP 4: Proceed with the rest of the plotting code
data_for_plot <- numerical_data
colnames(data_for_plot) <- c("Age", "Nutritional_Confidence", "Ethical_Concerns")
cor_matrix_short <- cor(data_for_plot)

library(corrplot)
corrplot(cor_matrix_short, 
         method = "color", 
         addCoef.col = "black",
         tl.col = "black",
         tl.cex = 0.8,
         main = "Correlation Matrix of Numerical Variables",
         mar = c(0,0,1,0))

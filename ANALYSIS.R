# --- SETUP: INSTALL AND LOAD PACKAGES ---
# (You only need to run install.packages once)
install.packages("corrplot")
library(corrplot)

# --- PROJECT I ---

# 1. DATA PREPROCESSING
# Load the dataset
# Make sure the CSV file is in the same folder as this script
df <- read.csv("synthetic_diet_responses.csv")

# Standardize numerical data
df_scaled <- df
df_scaled$Age_Z <- scale(df_scaled$What.is.your.age.)
df_scaled$Confidence_Z <- scale(df_scaled$How.confident.are.you.that.your.current.diet.meets.your.nutritional.needs...1..not.at.all.confident..5..extremely.confident.)

# 2. EXPLORATORY DATA ANALYSIS (EDA)
# Get summary statistics
summary(df)

# Get frequency table for diet type
table(df$Which.of.the.following.best.describes.your.current.diet.)

# Create a histogram of Age
hist(df$What.is.your.age.,
     main = "Histogram of Participant Age",
     xlab = "Age",
     ylab = "Frequency",
     col = "lightgreen",
     breaks = 10)

# 3. VISUALIZATION
# Create a scatter plot
plot(x = df$What.is.your.age., 
     y = df$How.confident.are.you.that.your.current.diet.meets.your.nutritional.needs...1..not.at.all.confident..5..extremely.confident.,
     main = "Age vs. Nutritional Confidence",
     xlab = "Age",
     ylab = "Confidence Rating (1-5)",
     pch = 19,
     col = "steelblue")

# Create a box plot
boxplot(df$What.is.your.age. ~ df$Which.of.the.following.best.describes.your.current.diet.,
        main = "Age Distribution by Diet Type",
        xlab = "Diet Type",
        ylab = "Age",
        col = "skyblue",
        border = "black")

# Create a correlation matrix plot
numerical_data <- df[, c("What.is.your.age.", 
                         "How.confident.are.you.that.your.current.diet.meets.your.nutritional.needs...1..not.at.all.confident..5..extremely.confident.",
                         "How.important.are.ethical.or.environmental.concerns.in.your.food.choices...1..not.important..5..extremely.important.")]
data_for_plot <- numerical_data
colnames(data_for_plot) <- c("Age", "Nutritional_Confidence", "Ethical_Concerns")
cor_matrix_short <- cor(data_for_plot)
corrplot(cor_matrix_short, 
         method = "color", 
         addCoef.col = "black",
         tl.col = "black",
         tl.cex = 0.8,
         main = "Correlation Matrix of Numerical Variables",
         mar = c(0,0,1,0))

# --- PROJECT II ---

# 1. STATISTICAL TESTING
# T-test
df_filtered <- subset(df, What.is.your.Gender == "Male" | What.is.your.Gender == "Female")
t.test(What.is.your.age. ~ What.is.your.Gender, data = df_filtered)

# ANOVA
anova_result <- aov(What.is.your.age. ~ Which.of.the.following.best.describes.your.current.diet., data = df)
summary(anova_result)

# Chi-Square Test
contingency_table <- table(df$What.is.your.Gender, df$Which.of.the.following.best.describes.your.current.diet.)
chisq.test(contingency_table)

# Regression Analysis
regression_result <- lm(How.confident.are.you.that.your.current.diet.meets.your.nutritional.needs...1..not.at.all.confident..5..extremely.confident. ~ What.is.your.age., data = df)
summary(regression_result)

# 2. RESULTS VISUALIZATION
# Scatter plot with regression line
plot(x = df$What.is.your.age., 
     y = df$How.confident.are.you.that.your.current.diet.meets.your.nutritional.needs...1..not.at.all.confident..5..extremely.confident.,
     main = "Age vs. Nutritional Confidence with Regression Line",
     xlab = "Age",
     ylab = "Confidence Rating (1-5)",
     pch = 19,
     col = "lightblue")
abline(regression_result, col = "red", lwd = 2)

# Diagnostic plots
plot(regression_result)

print("✅ All analysis complete.")
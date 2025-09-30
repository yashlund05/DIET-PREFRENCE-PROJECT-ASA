# Step 1: Create a contingency table of the two categorical variables
contingency_table <- table(df$What.is.your.Gender, df$Which.of.the.following.best.describes.your.current.diet.)

# Step 2: Perform the Chi-Square test on the table
chi_square_result <- chisq.test(contingency_table)

# Step 3: Print the results
print(chi_square_result)

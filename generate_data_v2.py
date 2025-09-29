import pandas as pd
import random
from datetime import datetime, timedelta

# --- Configuration ---
# CORRECTED: Hardcoded the full path to your Excel file.
# The 'r' before the string is important; it tells Python to treat backslashes as regular characters.
INPUT_FILE_PATH = r"D:\yash python\Diet Preference (Responses).xlsx"

# Name for the output file with the new synthetic data
OUTPUT_CSV_FILE = "synthetic_diet_responses.csv"

# Number of synthetic responses to generate
NUM_RESPONSES_TO_GENERATE = 1000


def generate_synthetic_data(df, num_responses):
    """
    Generates synthetic data based on the distributions of the original dataframe.
    """
    synthetic_data = []
    original_columns = df.columns.tolist()

    # Create cleaned-up column names for easier processing
    df.columns = [str(col).replace(' ', '_').replace('?', '').replace('(', '').replace(')', '').replace('/', '_').lower() for col in df.columns]

    # --- Build probability distributions from original data ---
    categorical_cols_dist = {}
    for col in df.columns:
        if df[col].dtype == 'object' or df[col].nunique() < 15:
            categorical_cols_dist[col] = df[col].value_counts(normalize=True)

    # --- Generate the new data row by row ---
    for _ in range(num_responses):
        row = {}
        
        # Timestamp (generating a random timestamp within the last year)
        start_date = datetime.now() - timedelta(days=365)
        row['timestamp'] = start_date + timedelta(seconds=random.randint(0, 31536000))
        
        # Age (using a reasonable range)
        row['what_is_your_age'] = random.randint(18, 65)
        
        # City (assuming a constant value)
        row['what_is_your_current_city_town_of_residence'] = 'Pune'

        # Categorical columns (selected based on original distribution)
        for col, dist in categorical_cols_dist.items():
            if col not in row and not dist.empty:
                row[col] = random.choices(dist.index, dist.values)[0]

        # Numerical Likert-scale columns
        row['how_confident_are_you_that_your_current_diet_meets_your_nutritional_needs_1=_not_at_all_confident_5=_extremely_confident'] = random.randint(1, 5)
        row['how_important_are_ethical_or_environmental_concerns_in_your_food_choices_1=_not_important_5=_extremely_important'] = random.randint(1, 5)
        
        synthetic_data.append(row)

    # Create DataFrame and map cleaned column names back to original ones
    final_df = pd.DataFrame(synthetic_data)
    rename_map = {clean: orig for clean, orig in zip(df.columns, original_columns)}
    final_df = final_df.rename(columns=rename_map)
    
    # Ensure all original columns are present
    for col in original_columns:
        if col not in final_df.columns:
            final_df[col] = None

    return final_df[original_columns]


def main():
    """ Main function to run the script """
    try:
        # --- Use the hardcoded path directly ---
        df = pd.read_excel(INPUT_FILE_PATH)
        print("✅ Successfully loaded the original data file.")

        synthetic_df = generate_synthetic_data(df, NUM_RESPONSES_TO_GENERATE)
        print(f"✅ Successfully generated {NUM_RESPONSES_TO_GENERATE} synthetic responses.")
        
        # The output file will be saved in the same directory as the script
        synthetic_df.to_csv(OUTPUT_CSV_FILE, index=False)
        print(f"✅ Synthetic data saved to '{OUTPUT_CSV_FILE}'")

    except FileNotFoundError:
        print(f"❌ ERROR: The file was not found at '{INPUT_FILE_PATH}'")
        print("Please make sure the file path is correct and the file exists.")
    except Exception as e:
        print(f"❌ An error occurred: {e}")

if __name__ == "__main__":
    main()
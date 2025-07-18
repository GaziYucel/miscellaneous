import os
import shutil

# Define input and output directories
dir_in = "cache_in"
dir_out = "cache_out"

# Ensure the output directory exists
os.makedirs(dir_out, exist_ok=True)

# Iterate through all files in the input directory
for filename in os.listdir(dir_in):
    # Create the full path to the input file
    file_path = os.path.join(dir_in, filename)

    # Check if it's a file (not a directory)
    if os.path.isfile(file_path):
        # Define the new filename (you can customize this as needed)
        new_filename = f"done_{filename}"

        # Create the full path for the output file
        output_file_path = os.path.join(dir_out, new_filename)

        # Copy and rename the file to the output directory
        shutil.copy(file_path, output_file_path)

        print(f"Copied and renamed: {filename} to {new_filename}")
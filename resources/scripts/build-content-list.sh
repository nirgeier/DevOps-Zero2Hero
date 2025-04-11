#!/bin/bash

# ###
# ### This script will create the tests for this repository
# ### @Author: Nir Geier
# ### 

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Get the root folder of our demo folder
ROOT_FOLDER=$(git rev-parse --show-toplevel)

# Normalize the search directory path (remove trailing slash if present)
LOGOS_DIR=$(realpath "$ROOT_FOLDER/resources/images/logos/")
CONTENT_DIR=$(realpath "$ROOT_FOLDER/Content/")
NUMBER_OF_COLUMNS=8

# Check if logos directory exists
if [ ! -d "$LOGOS_DIR" ]; then
  echo "Error: '$LOGOS_DIR' directory not found!"
  exit 1
fi

# Get all SVG files in the logos directory
logo_files=($(find "$LOGOS_DIR" -name "logos_*.svg" | sort))

# Count total files
total_files=${#logo_files[@]}

if [ $total_files -eq 0 ]; then
  echo "No logo files found matching the pattern 'logos_*.svg'"
  exit 1
fi

# Calculate rows needed with columns
rows=$(( (total_files + $NUMBER_OF_COLUMNS - 1) / $NUMBER_OF_COLUMNS ))

# Start markdown file
LOGOS_FILE="logo_table.md"
echo "<!-- LOGOS START -->" > "$LOGOS_FILE"

# Count total number of files found
TOTAL_FILES=$(find "$CONTENT_DIR" -type f -name "*.md" | wc -l)
echo "Total markdown files found: $TOTAL_FILES" >> "$LOGOS_FILE"
echo ""

echo "<div style=\"text-align: center; display: inline-block;\">" >> "$LOGOS_FILE"
echo "" >> "$LOGOS_FILE"

# Create the header row
HEADER="| "
# Create the separator row
SEPARATOR="| "

# Build the header row with column 
for i in $(seq 1 $NUMBER_OF_COLUMNS); do
    HEADER+="   | "
    SEPARATOR+="--- | "
done
echo "$HEADER" >> "$LOGOS_FILE"
echo "$SEPARATOR" >> "$LOGOS_FILE"

# Function to extract folder name from filename
get_folder_name() {
  filename=$(basename "$1")
  
  # Remove logos_ prefix and .svg extension
  name_part=${filename#logos_}
  name_part=${name_part%.svg}
  
  echo "$name_part"
}

update_readme_with_logos() {

  # The target file is the README.md file in the Content folder
  TARGET_FILE=$(realpath "$ROOT_FOLDER/Content/README.md")

  # Read the content from the content file
  CONTENT_FILE=$(realpath "$LOGOS_FILE")

  # Create a temporary file
  TEMP_FILE=$(mktemp)

  # Read the content from the content file
  CONTENT=$(cat "$CONTENT_FILE")

  # Create another temporary file for the content with proper line handling
  CONTENT_TEMP=$(mktemp)
  echo "$CONTENT" > "$CONTENT_TEMP"

  # Escape special characters AND preserve newlines for sed
  ESC_TEXT=$(sed -e 's/[\/&]/\\&/g' -e '$!s/$/\\/' <<< "$CONTENT")

  # Replace the content between the navigation comments with dynamic content
  sed -i "/<!-- LOGOS START -->/,/<!-- LOGOS END -->/c\\
$ESC_TEXT" "$TARGET_FILE"
}

generate_logos(){
  # Generate table rows
  current_col=1
  echo -n "|" >> "$LOGOS_FILE"

  for logo_file in "${logo_files[@]}"; do
    # Extract the folder name
    folder_name=$(get_folder_name "$logo_file")

    # Reset total markdown files counter for each new folder
    total_md_files=""

    # Reset the folder link
    folder_url="#"

    # Check if the content directory exists and contains markdown files
    if [ -d "$CONTENT_DIR/$folder_name" ]; then
      
      # Count total markdown files in the content folder
      total_md_files=$(find "$CONTENT_DIR/$folder_name" -type f -name "*.md" | wc -l)
    
      # For some reason we have to trim the results
      total_md_files="[${total_md_files#"${total_md_files%%[![:space:]]*}"}]"

      # Set the folder link
      folder_url="./$folder_name"

    fi  
    
    # Capitalize first letter
    folder_name="$(tr '[:lower:]' '[:upper:]' <<< ${folder_name:0:1})${folder_name:1}"
    
    # Add the image with link
    echo -n "<a href=\"./$folder_url\">" >> "$LOGOS_FILE"
    echo -n "<img src=\"../resources/images/logos/$(basename "$logo_file")\" style=\"border-radius: 20px; padding: 10px; width:75px;height:75px;\"/>" >> "$LOGOS_FILE"
    echo -n "</a><br/> $folder_name&nbsp;$total_md_files|" >> "$LOGOS_FILE"

    #echo -n " ![$ROOT_FOLDER/resources/images/logos/$(basename "$logo_file")]($CONTENT_DIR/$folder_name) |" >> "$LOGOS_FILE"
    
    # Check if we need to start a new row
    if [ $current_col -eq $NUMBER_OF_COLUMNS ]; then
      echo "" >> "$LOGOS_FILE"
      if [ $((total_files - (current_col * (rows - 1) + current_col))) -gt 0 ]; then
        echo -n "|" >> "$LOGOS_FILE"
      fi
      current_col=1
    else
      ((current_col++))
    fi
  done

  # Fill remaining cells in the last row if needed
  while [ $current_col -le $NUMBER_OF_COLUMNS ] && [ $current_col -ne 1 ]; do
    echo -n " |" >> "$LOGOS_FILE"
    ((current_col++))
  done

  # Add a final newline if we didn't just add one
  if [ $((total_files % $NUMBER_OF_COLUMNS)) -ne 0 ]; then
    echo "" >> "$LOGOS_FILE"
  fi

  echo "</div>" >> "$LOGOS_FILE"
  echo "" >> "$LOGOS_FILE"
  echo "<!-- LOGOS END -->" >> "$LOGOS_FILE"

  echo "Markdown table generated in '$LOGOS_FILE'"
  update_readme_with_logos
  rm -rf $LOGOS_FILE

}


generate_logos

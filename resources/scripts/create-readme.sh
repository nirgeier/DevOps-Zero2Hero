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
CONTENT_FOLDER=$(realpath "$ROOT_FOLDER/Content/")

# Set the README with the labs list
CONTENT_LIST=$SCRIPT_DIR/README.md

# Copy the template 
cp $SCRIPT_DIR/README-template.md $SCRIPT_DIR/README.md

# Count total number of files found
TOTAL_FILES=$(find "$CONTENT_FOLDER" -type f -name "*.md" | wc -l)
echo "Total markdown files found: $TOTAL_FILES" >> $CONTENT_LIST

# Loop over the content directories and search for markdown files
# Returns 1 if the directory contains md files (directly or in subdirectories), 0 otherwise
process_directory() {

  # Local variables for indentation and base directory
  local dir="$1"
  local indent="$2"
  local base_dir=$(basename "$dir")
  local has_md_files=0
  local md_files=()
  local subdirs=()
  local subdirs_with_md=()
    
  # Find all markdown files in the current directory (not in subdirectories)
  while IFS= read -r FILE_PATH; do
    md_files+=("$FILE_PATH")
  done < <(find "$dir" -maxdepth 1 -type f -name "*.md" | sort)
    
  # Check if there are any markdown files in this directory
  if [ ${#md_files[@]} -gt 0 ]; then
    has_md_files=1
  fi
    
  # Process each subdirectory
  while IFS= read -r subdir; 
  do
    # Collect sub directories 
    # and Skip directories that start with .
    if [[ $(basename "$subdir") != .* ]]; then
      subdirs+=("$subdir")
    fi
  done < <(find "$dir" -maxdepth 1 -type d -not -path "$dir" | sort)
    
  # Check subdirectories for md files
  for subdir in "${subdirs[@]}"; do
    if process_directory_check "$subdir"; then
        subdirs_with_md+=("$subdir")
        has_md_files=1
    fi
  done
    
  # If there are md files in this directory or subdirectories, print the structure
  if [ $has_md_files -eq 1 ]; then
    # Print the directory name (but not for the root directory if we're starting from current directory)
    if [ "$dir" != "$START_DIR" ] || [ "$START_DIR" != "." ]; then
      if [ ${#indent} -eq 2 ]; then
        # Count total pages under each subject
        TOTAL_CONTENT_FILES=$(find "$CONTENT_FOLDER"/$base_dir -type f -name "*.md" | wc -l)
        # For some reason we have to trim the results
        TOTAL_CONTENT_FILES="${TOTAL_CONTENT_FILES#"${TOTAL_CONTENT_FILES%%[![:space:]]*}"}"
        echo "" >> $CONTENT_LIST
        echo "---" >> $CONTENT_LIST
        echo "" >> $CONTENT_LIST
        echo "## ${base_dir} [${TOTAL_CONTENT_FILES}]" >> $CONTENT_LIST
      fi
    fi
    
    # Print each markdown file
    for FILE_PATH in "${md_files[@]}"; do
        echo "${indent}- [$(basename "$FILE_PATH")](${FILE_PATH#$ROOT_FOLDER})" >> $CONTENT_LIST
    done
    
    # Process subdirectories with md files
    for subdir in "${subdirs_with_md[@]}"; do
        process_directory "$subdir" "${indent}  "
    done
  fi
    
  return $has_md_files
}

# Function that checks if a directory has md files without printing anything
process_directory_check() {
    local dir="$1"
    # Check subdirectories
    local subdirs=()
    
    # Check if there are any markdown files directly in this directory
    if [ $(find "$dir" -maxdepth 1 -type f -name "*.md" | wc -l) -gt 0 ]; then
        return 0
    fi
    
    while IFS= read -r subdir; do
        subdirs+=("$subdir")
    done < <(find "$dir" -maxdepth 1 -type d -not -path "$dir")
    
    for subdir in "${subdirs[@]}"; do
        if process_directory_check "$subdir"; then
            return 0
        fi
    done
    
    return 1
}

# Start processing from the provided directory
process_directory "$CONTENT_FOLDER" ""

# Add the closing section to the README
echo "" >> $CONTENT_LIST
echo "---" >> $CONTENT_LIST
echo "" >> $CONTENT_LIST
echo "Total markdown files found: $TOTAL_FILES" >> $CONTENT_LIST
echo '-------'
mv $CONTENT_LIST $ROOT_FOLDER/Content/


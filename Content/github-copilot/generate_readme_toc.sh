#!/bin/bash

# Check if directory path is provided
if [ $# -ne 1 ]; then
  echo "Usage: $0 <directory_path>"
  exit 1
fi

DIRECTORY="$1"

# Initialize README with a header
echo "# Section Documentation" > TOC.md
echo -e "\n" >> TOC.md

# Process each markdown file except README.md
find "$DIRECTORY" -maxdepth 1 -name "*.md" ! -name "README.*" -print0 | while IFS= read -r -d '' file; do
    # Extract filename without path
    filename=$(basename "$file")
    
    # Extract title from first heading and clean list markers
    title=$(grep -m 1 '^# ' "$file" | sed -e 's/^# //' -e 's/^[[:space:]]*-[[:space:]]*//')
    [ -z "$title" ] && title=$filename  # Use filename if no title found
    
    # Add file title to README
    echo "## [$title]($filename)" >> TOC.md
    
    # Extract and format TOC items
    grep -E '^(\s*)-\s*\[.*\]\(#.*\)' "$file" | while read -r line; do
        # Capture indentation and clean numbering
        whitespace=$(echo "$line" | sed -E 's/^(\s*)-\s*\[.*/\1/')
        # link_text=$(echo "$line" | sed -E '
        #     s/^\s*-\s*\[([^]]+)\].*/\1/;
        #     s/^[0-9]+\.?[[:space:]]*//
        # ')
        link_text=$(echo $line | sed 's/.*\[\([^]]*\)\].*/\1/')
        echo $link_text
        anchor=$(echo "$line" | sed -E 's/.*\((#[^)]+)\).*/\1/')
        
        # Write formatted entry
        echo " - [$link_text]($filename$anchor)" >> TOC.md
    done
    
    echo -e "\n" >> TOC.md
done
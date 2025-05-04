#!/bin/bash
# git_history_script.sh - Script to analyze git commit history with line changes

# Get the root folder of our demo folder
ROOT_FOLDER=$(git rev-parse --show-toplevel)

# Help function to display usage information
show_help() {
  echo "Usage: $0 [options]"
  echo
  echo "This script summarizes git commit history by author, showing commit counts and line changes."
  echo
  echo "Options:"
  echo "  -r, --repo PATH       Path to git repository (default: current directory)"
  echo "  -s, --since DATE      Show commits after date (e.g., '2023-01-01' or '1 year ago')"
  echo "  -u, --until DATE      Show commits before date"
  echo "  -b, --branch NAME     Analyze specific branch (default: current branch)"
  echo "  -f, --format FORMAT   Output format: text, csv, json (default: text)"
  echo "  -o, --output FILE     Output file (default: stdout)"
  echo "  -e, --email           Show email addresses instead of names"
  echo "  -t, --top NUMBER      Show only the top N contributors"
  echo "  -h, --help            Display this help and exit"
  echo
  echo "Examples:"
  echo "  $0 --since '6 months ago' --format csv --output committers.csv"
  echo "  $0 --top 5 --email"
}

# Default values
REPO_PATH=$ROOT_FOLDER
FORMAT="text"
OUTPUT=""
USE_EMAIL=0
TOP_N=""

# Parse command-line options
while [[ $# -gt 0 ]]; do
  case $1 in
    -r|--repo)
      REPO_PATH="$2"
      shift 2
      ;;
    -o|--output)
      OUTPUT="$2"
      shift 2
      ;;
    -e|--email)
        USE_EMAIL=1
        shift
        ;;
    -t|--top)
        TOP_N="$2"
        shift 2
        ;;
    -h|--help)
        show_help
        exit 0
        ;;
    *)
        echo "Unknown option: $1"
        show_help
        exit 1
        ;;
    esac
done

# Check if the repository exists
if [ ! -d "$REPO_PATH/.git" ]; then
    echo "Error: Not a git repository: $REPO_PATH"
    exit 1
fi

# Create temporary directory for our work
TEMP_DIR=$(mktemp -d)
COMMIT_DATA="$TEMP_DIR/commit_data.txt"
AUTHOR_STATS="$TEMP_DIR/author_stats.txt"

# Run git log and process the output
process_git_log() {
    local git_cmd="git -C \"$REPO_PATH\" log --pretty=format:'COMMIT%n%H%n%an%n%ae%n%s' --numstat"
    eval "$git_cmd" > "$COMMIT_DATA"
    
    # Process the git log output to extract author stats
    awk '
    BEGIN {
      FS = "\n"; RS = "COMMIT\n"
    }
    NF > 1 {
      hash = $1
      author_name = $2
      author = author_name
      
      # Count the commit for this author
      commits[author]++
      
      # Process the numstat lines to count insertions and deletions
      for (i = 5; i <= NF; i++) {
        split($i, stats, "\t")
        if (stats[1] ~ /^[0-9]+$/ && stats[2] ~ /^[0-9]+$/) {
            insertions[author] += stats[1]
            deletions[author] += stats[2]
        }
      }
    }
    END {
      # Create an array for sorting
      n = 0
      for (author in commits) {
        total = insertions[author] + deletions[author]
        author_data[n] = sprintf("|%-25s|%8d|%12d|%12d|%10d|", author, commits[author], insertions[author], deletions[author], total)
        author_commits[n] = commits[author]
        n++
      }
      
      # Sort by number of commits (descending)
      for (i = 0; i < n; i++) {
        for (j = i + 1; j < n; j++) {
          if (author_commits[i] < author_commits[j]) {
            # Swap commits count
            temp = author_commits[i]
            author_commits[i] = author_commits[j]
            author_commits[j] = temp
            
            # Swap data line
            temp = author_data[i]
            author_data[i] = author_data[j]
            author_data[j] = temp
          }
        }
      }
            
      # Determine how many authors to show
      limit = n
      if (top_n != "" && top_n < n) {
          limit = top_n
      }
            
      printf "\nTotal Contributors: %d\n\n", n
      # Output the results in the desired format
      # Default text format
      printf "|%-25s|%8s|%12s|%12s|%10s|\n", "Author                   ", "Commits ", "Insertions  ", "Deletions   ", "Total"
      printf "|%-25s|%8s|%12s|%12s|%10s|\n", "-------------------------", "--------", "------------", "------------", "----------"
      
      
      # Print sorted data
      for (i = 0; i < limit; i++) {
          print author_data[i]
      }
            
      # Calculate and print totals
      total_commits = 0
      total_insertions = 0
      total_deletions = 0
            
      for (author in commits) {
        total_commits += commits[author]
        total_insertions += insertions[author]
        total_deletions += deletions[author]
      }
      
      printf "|%-25s|%8s|%12s|%12s|%10s|\n", "-------------------------", "--------", "------------", "------------", "----------"
      printf "|%-25s|%8s|%12s|%12s|%10s|\n", "TOTAL ", total_commits, total_insertions, total_deletions, total_insertions + total_deletions, "|"
      printf "|%-25s|%8s|%12s|%12s|%10s|\n", "-------------------------", "--------", "------------", "------------", "----------"
        
    }
    ' use_email=$USE_EMAIL format=$FORMAT top_n=$TOP_N "$COMMIT_DATA" > "$AUTHOR_STATS"
    
    # Output to the desired destination
    if [ -n "$OUTPUT" ]; then
        cat "$AUTHOR_STATS" > "$OUTPUT"
        echo "Committer statistics saved to $OUTPUT"
    else
        cat "$AUTHOR_STATS"
    fi
}

# Process the git log
process_git_log

# Clean up temporary files
rm -rf "$TEMP_DIR"
# Vim Hands-on Lab

This lab will help you practice essential Vim commands and features through practical exercises.

## Prerequisites
- Vim installed on your system
- Basic understanding of command line interface
- A terminal or command prompt

## Lab Exercises

### Exercise 1: Basic Navigation and Editing

1. Create a new file:
   ```bash
   vim practice.txt
   ```

2. Enter the following text (press `i` for insert mode):
   ```
   Line 1: This is a practice file
   Line 2: We will edit this file
   Line 3: Using various Vim commands
   Line 4: To become more proficient
   Line 5: In using this powerful editor
   ```

3. Practice these commands:
   - Press `Esc` to enter normal mode
   - Move to line 3 using `3G`
   - Change "various" to "different" using `cw`
   - Copy line 4 using `yy`
   - Paste it below line 5 using `p`
   - Delete line 2 using `dd`
   - Save the file using `:w`

### Exercise 2: Search and Replace

1. Add more text to your file:
   ```
   The quick brown fox jumps over the lazy dog
   The quick brown fox jumps over the lazy cat
   The quick brown fox jumps over the lazy rat
   ```

2. Practice these operations:
   - Search for "lazy" using `/lazy`
   - Replace all "fox" with "wolf" using `:%s/fox/wolf/g`
   - Replace "lazy" with "sleeping" but with confirmation using `:%s/lazy/sleeping/gc`

### Exercise 3: Visual Mode and Block Operations

1. Create this text block:
   ```
   item1 = value1
   item2 = value2
   item3 = value3
   item4 = value4
   ```

2. Practice these operations:
   - Enter visual block mode with `Ctrl-v`
   - Select the numbers after "item"
   - Press `g Ctrl-a` to increment numbers
   - Use visual line mode `V` to select multiple lines
   - Indent selected lines with `>`

### Exercise 4: Working with Multiple Windows

1. Open multiple files:
   ```bash
   vim -O file1.txt file2.txt
   ```

2. Practice:
   - Switch between windows using `Ctrl-w h` and `Ctrl-w l`
   - Copy text from one window to another
   - Resize windows using `Ctrl-w +` and `Ctrl-w -`
   - Close one window using `:q`

### Exercise 5: Macros

1. Create a list:
   ```
   apple
   banana
   orange
   grape
   ```

2. Record and play a macro:
   - Start recording with `qa`
   - Go to start of line with `0`
   - Add "- " at start with `i- Esc`
   - Go to end of line with `$`
   - Add "fruit" with `afruit`
   - Move to next line with `j`
   - Stop recording with `q`
   - Apply to all lines with `3@a`

Expected result:
```
- apple fruit
- banana fruit
- orange fruit
- grape fruit
```

## Challenge Exercises

1. **Log File Analysis**
   Create a sample log file and practice:
   - Filtering lines containing "ERROR"
   - Deleting all lines containing "DEBUG"
   - Sorting lines by timestamp
   - Copying all error messages to a new file

2. **Code Formatting**
   Format this unformatted code:
   ```python
   def calculate_sum(a,b,c):
   result=a+b+c
   print("The sum is:",result)
   return result
   ```

3. **YAML File Manipulation**
   Create and format a YAML file with proper indentation.

## Completion Criteria
- All exercises completed successfully
- Able to perform basic navigation and editing
- Comfortable with search and replace operations
- Understanding of visual mode and block operations
- Basic macro usage mastered

## Additional Practice
- Visit [Vim Adventures](https://vim-adventures.com/)
- Try `vimtutor` in your terminal
- Practice with real configuration files
- Customize your own `.vimrc`

---

> 💡 **Tip**: Take your time with each exercise. Muscle memory is key to becoming proficient with Vim. 
df('disk filesystem') is a command to check usage and available on our mounted filesystems.
df / check only the root.
df / | awk 'NR==2' will give us just the second row of the "df /" command output.
df / | awk 'NR==2 {print $5}' will give us the fifth field of the second row of the "df /" output.
sub("%","") change the percentage to space so we can compare numbers(threshold and usage).
USAGE=$(df / | awk 'NR==2 {gsub("%",""); print $5}') - put the number we got from the all command 
in a variable named USAGE.

if [ "$USAGE" -gt "$THRESHOLD" ] - if we got that the USAGE number is greater than("gt") the THRESHOLD 
number so 'echo' the date and the warning to a logfile.

i hope it was understandable.



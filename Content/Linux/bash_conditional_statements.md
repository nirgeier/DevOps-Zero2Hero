# Conditional Statements

## The if-else Statement

Sometimes you need to specify different courses of action to be taken in a shell script, depending on the success or failure of a command. The `if` construction allows you to specify such conditions. The most common syntax of the `if` command is:

```bash
if TEST-COMMAND
then
    POSITIVE-CONSEQUENT-COMMANDS
else
    NEGATIVE-CONSEQUENT-COMMANDS
fi
```

If the `TEST-COMMAND` is successful (returns an exit status of `0`), then the positive consequent commands are executed; otherwise, the negative consequent commands (if provided) are executed. The `if` statement is terminated with the `fi` command.

---

### Testing Files

Before you start, review the man page of the `test` command.

The first example checks for the existence of a file:

```bash
echo "This script checks the existence of the messages file."
echo "Checking..."

if [ -f /var/log/messages ]
then
  echo "/var/log/messages exists."
fi

echo
echo "...done."
```

---

### Testing Exit Status

Recall that the `$?` variable holds the exit status of the previously executed command. The following example utilizes this variable to take a decision according to the success or failure of the previous command:

```bash
curl google.com &> /dev/null

if [ $? -eq 0 ]
then
  echo "Request succeeded"
else
  echo "Request failed, trying again..."
fi
```

---

### Numeric Comparisons

The below example demonstrates numeric comparison between a variable and `20`. Don’t worry if it doesn’t work; you’ll fix it soon 🙂

```bash
num=$(wc -l /etc/passwd)
echo $num

if [ "$num" -gt "20" ]; then
  echo "Too many users in the system."
fi
```

---

### String Comparisons

```bash
if [[ "$(whoami)" != 'root' ]]; then
  echo "You have no permission to run $0 as non-root user."
  exit 1;
fi
```

---

### The if-grep Construct

```bash
echo "Bash is ok" > file

if grep -q Bash file
then
  echo "File contains at least one occurrence of Bash."
fi
```

Another example:

```bash
word=Linux
letter_sequence=inu

if echo "$word" | grep -q "$letter_sequence"
# The "-q" option to grep suppresses output.
then
  echo "$letter_sequence found in $word"
else
  echo "$letter_sequence not found in $word"
fi
```

---

### [...] vs [[...]]

With version 2.02, Bash introduced the `[[ ... ]]` extended test command, which performs comparisons in a manner more familiar to programmers from other languages. The `[[...]]` construct is the more versatile Bash version of `[...]`. Using the `[[...]]` test construct, rather than `[...]`, can prevent many logic errors in scripts.

---

## Exercises

### :pencil2: Geo-Location Info

Write a bash script `geo_by_ip.sh` that, given an IP address, prints geo-location details, as follows:

1. The script first checks if the `jq` CLI is installed. If not, it prints a message to the user with a link to download the tool: [https://stedolan.github.io/jq/download/](https://stedolan.github.io/jq/download/).
2. The script checks that exactly one argument was sent to it, which represents the IP address to check. Otherwise, an informative message is printed to stdout.
3. The script checks that the given IP argument is not equal to `127.0.0.1`.
4. The script performs an HTTP `GET` request to `http://ip-api.com/json/<ip>` where `<ip>` is the IP argument. The results should be stored in a variable.
5. Using the `jq` tool and the variable containing the HTTP response, check that the request has succeeded by verifying that the `status` key has a value of `success`. The command `jq -r '.<key>'` can extract a key from the JSON (e.g., `echo $RESPONSE | jq -r '.status'`).
6. If the request succeeds, print the following information to the user:
   - `country`
   - `city`
   - `regionName`

---

### :pencil2: Extended Availability Test

Extend the above script to be more modular. Assume the script `availability_test.sh` is:

```bash
curl google.com &> /dev/null

if [ $? -eq 0 ]
then
    echo "Request succeeded"
else
    echo "Request failed, trying again..."
fi
```

Change the script to work for any URL input from the user, in the following form:

```bash
myuser@hostname:~$ ./availability_test.sh google.com
...
myuser@hostname:~$ ./availability_test.sh cnn.com
...
myuser@hostname:~$ ./availability_test.sh abcdefg
...
myuser@hostname:~$ ./availability_test.sh
A valid URL is required.
```

---

This site is open source. Improve this page.
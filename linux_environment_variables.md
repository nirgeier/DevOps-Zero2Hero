# Environment variables

## Environment variables defined

Global variables or **environment variables** are variables available for any process or application running in the same environment. Global variables are being transferred from parent process to child program. They are used to store system-wide settings and configuration information, such as the current user's preferences, system paths, and language settings. Environment variables are an essential part of the Unix and Linux operating systems and are used extensively by command-line utilities and scripts.

The `env` or `printenv` commands can be used to display environment variables.

## The `$PATH` environment variable

When you want the system to execute a command, you almost never have to give the full path to that command. For example, we know that the `ls` command is actually an executable file, located in the `/bin` directory (check with `which ls`), yet we don't have to enter the command `/bin/ls` for the computer to list the content of the current directory.

The `$PATH` environment variable is a list of directories separated by colons (`:`) that the shell searches when you enter a command. When you enter a command in the shell, the shell looks for an executable file with that name in each directory listed in the `$PATH` variable, in order. If it finds an executable file with that name, it runs it.

System commands are normal programs that exist in compiled form (e.g. `ls`, `mkdir` etc... ).

```console
myuser@hostname:~$ which ls
/bin/ls
myuser@hostname:~$ echo $PATH
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:.....
```

The above example shows that `ls` is actually an executable file located under `/bin/ls`. The `/bin` path is part of the PATH env var, thus we are able to type `ls` shortly.

## The `export` command

The `export` command is used to set environment variables in the current shell session or to export variables to **child processes**.

When a variable is exported using the `export` command, it becomes available to any child process that is spawned by the current shell. This is useful when you need to pass environment variables to programs or scripts that you run.

For example, let's say you want to add a directory called `mytools` to your `PATH` environment variable so that you can run executables stored in that directory. You can do this by running the following command:

```bash
export PATH=$PATH:/home/myuser/mytools
```

This command adds the directory `/home/myuser/mytools` to the existing PATH environment variable, which is a colon-separated list of directories that the shell searches for executable files.

If you only set the `PATH` variable without exporting it, it will only be available in the current shell session and will not be inherited by child processes.

```bash
PATH=$PATH:/home/myuser/mytools
```

# Self-check questions

[Enter the interactive self-check page](https://alonitac.github.io/DevOpsBootcampUPES/multichoice-questions/linux_environment_variables.html)

# Exercises

### :pencil2: Create your own Linux "command"

Let's create a shell program and add it to your `$PATH` env var. Execute the following commands line by line:

1. In your home dir, create a directory called `scripts`. This dir will be added to the PATH soon.
2. Create bash script in a file called `myscript` (without any extension), with the following content:

```bash
#!/bin/bash
echo my script is running...
```

3. Test your script by `bash myscript`
4. Give it execute permissions
5. Copy your script into `~/scripts`
6. Add `~/scripts` to the PATH (don't override the existing content of PATH, take a look at the above example).
7. Test your new "command" by just typing `myscript`.
8. Try to use the `myscript` command in another new terminal session. Does it work? Why?


### :pencil2: Manipulate env vars

In your current terminal session, type `printenv` to list your environment variables. 
Find specific env var to manipulate, such that the command `cd ~` will actually change to the `/tmp` directory, instead to your regular home directory.

This hack should work for any child process spawned from your current terminal session.

## Optional practice

### Elvis custom `ls` command

The PATH variable on `elvis`' machine looks like:

```console
[elvis@station elvis]$ echo $PATH 
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
```

`elvis` created a custom program called `ls`.
The program is located in `/home/elvis/custom` directory.

1. What is the command that `elvis` should execute such that **his** version of `ls` would be executed in the current terminal session only?
2. What is the command that `elvis` should execute such that **Ubuntu**'s version of `ls` would be executed in the current and child terminal sessions?

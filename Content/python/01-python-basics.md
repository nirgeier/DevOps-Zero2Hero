<!-- omit in toc -->
# Python Basics

Python is a powerful programming language widely used in Software Development, DevOps and Machine Learning. <br>
This guide covers fundamental Python concepts for beginners while the next part will focus more on python practices for DevOps processes and tools.

<br>

<!-- TOC will be generated here -->
## Table of Contents

- [Introduction to Python](#introduction-to-python)
- [Why Python for DevOps?](#why-python-for-devops)
- [Setting Up Python](#setting-up-python)
- [Basic Python Concepts](#basic-python-concepts)
  - [Variables and Data Types](#variables-and-data-types)
  - [Control Flow](#control-flow)
  - [Functions](#functions)
  - [Modules and Packages](#modules-and-packages)
- [Python Tools for DevOps](#python-tools-for-devops)
- [Next Steps](#next-steps)

---

<br>

## Introduction to Python

Python is a dynamically written, high-level, interpreted programming language known for its simplicity and readability.

What makes Python special:

- Clear, readable syntax that resembles plain English
- Extensive standard library
- Strong community support with countless libraries and frameworks
- Versatile - used in web development, data science, automation, DevOps and more

<br>

## Why Python for DevOps?

Python has become a cornerstone in DevOps for several compelling reasons:

- **Simplicity**: Easy to learn and write, making automation accessible
- **Cross-platform**: Works on Windows, MacOS, Linux, and more
- **Rich ecosystem**: Libraries for interacting with clouds, containers, and infrastructure
- **System integration**: Excellent for gluing different systems together
- **Text processing**: Great for parsing logs, configuration files, and outputs

As a DevOps practitioner, Python empowers you to automate tasks and build custom tools.

<br>

## Setting Up Python

Getting started with Python is straightforward and simple:

1. **Install Python**: Download from [python.org](https://python.org) or use your OS package manager
2. **Virtual Environments**: Use `venv` to create isolated environments for your projects
3. **Package Management**: Learn to use `pip` to install and manage dependencies, e.g., `pip install requests`

<br>

## Basic Python Concepts

### Variables and Data Types

Python uses dynamic typing, meaning you don't need to declare variable types explicitly.

Basic data types include:

- **String**: Text, e.g., `"Hello DevOps-Zero2Hero"`
- **Integer**: Whole numbers, e.g., `42`
- **Float**: Decimal numbers, e.g., `3.14`
- **Boolean**: Logical values, `True` or `False`
  - `True` and `False` are keywords, not strings, and also correspond to `1` and `0`
  - Empty strings, lists, or dictionaries evaluate to `False` in boolean contexts
- **List**: Ordered, mutable collections, e.g., `[1, 2, 3]` (can mix types)
- **Tuple**: Ordered, immutable collections, e.g., `(1, 2, 3)`
- **Dictionary**: Key-value pairs, e.g., `{"service": "web", "port": 80}`

Example:

```python
name = "DevOps-Zero2Hero"                  # String
count = 42                                 # Integer
pi = 3.14                                  # Float
active = True                              # Boolean
items = [1, "two", 3.0]                    # List
config = ("environment", "dev")            # Tuple
settings = {"mode": "test", "level": 1}    # Dictionary
```

### Control Flow

Control flow structures determine how your code executes:

- **If-else statements**: Make decisions in your code  

  ```python
  if count > 10:
      print("Count is greater than 10")
  else:
      print("Count is 10 or less")
  ```

- **Loops**: Repeat actions with `for` and `while`  

  ```python
  for item in items:
      print(item)

  i = 0
  while i < 3:
      print(i)
      i += 1
  ```

- **Error handling**: Catch and manage exceptions with `try-except`  

  ```python
  try:
      result = 10 / 0
  except ZeroDivisionError:
      print("Cannot divide by zero")
  ```

### Functions

Functions help organize code into reusable blocks:

- Functions are defined with `def` keyword followed by the function name and parentheses. e.g, `def say_hello():`
- Functions can but do not neccecarily accept parameters for flexible behavior
- Functions can return values to the caller using the `return` statement
- Use docstrings to document purpose and usage

### Modules and Packages

Python code is organized in:

- **Modules**: Python files containing code (e.g., `my_module.py`)
  - You can import modules using the `import` statement, e.g., `import my_module`
  - Use `from my_module import function_name` to import specific functions or classes

- **Packages**: Directories containing multiple modules
  - Packages are structured with an `__init__.py` file to indicate they are packages
  - Use `import package_name.module_name` to access modules within a package

- **Libraries**: Collections of packages for specific tasks
  - Libraries are often installed via `pip` and can be imported like modules

<br>

The import system lets you use code from other files and libraries.
This script defines a function, creates a list, and uses a loop to greet each name.

```python
def greet(name):
  print(f"Hello, {name}!")

names = ["Alice", "Bob", "Charlie"]

for n in names:
  greet(n)
```

The output will be:

```python
Hello, Alice!
Hello, Bob!
Hello, Charlie!
```

<br>

## Python Tools for DevOps

Several Python libraries are especially useful for DevOps:

- **Requests**: For working with HTTP/APIs
- **Paramiko**: For SSH connections
- **PyYAML**: For parsing YAML configurations
- **Boto3**: For AWS automation
- **Fabric**: For streamlining SSH use
- **Ansible**: For configuration management (uses Python)

## Next Steps

After learning these basics:

- Review the dedicated jupyter notebook for practical examples.
- Explore more advanced Python concepts
- Dive deeper into specific DevOps-related topics with the [Python Basics Jupyter Notebook](./notebooks/python_basics.ipynb)


---

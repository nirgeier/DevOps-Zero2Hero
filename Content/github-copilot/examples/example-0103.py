# Please write simple Python program that prints "Hello, World!" and a main function.


### ----------------------------------------------------------------------
###
### Suggestion 1
###
# This program prints "Hello, World!" using a main function.
def main():
    # Print the message to the console
    print("Hello, World!")

# Ensures the main function is executed only when the script is run directly
if __name__ == "__main__":
    main()

### ----------------------------------------------------------------------
###
### Suggestion 2
###
# This program prints "Hello, World!" using a function that accepts input.

def main(message):
    # Print the provided message to the console
    print(message)

# Ensures the main function is executed only when the script is run directly
if __name__ == "__main__":
    # Pass "Hello, World!" as an argument to the main function
    main("Hello, World!")

### ----------------------------------------------------------------------
###
### Suggestion 3
###
# This program prints "Hello, World!" using a lambda function and a main function.

def main():
    # Use a lambda function to print the message
    greet = lambda: print("Hello, World!")
    greet()

# Ensures the main function is executed only when the script is run directly
if __name__ == "__main__":
    main()

### ----------------------------------------------------------------------
###
### Suggestion 4
###    
# This program prints "Hello, World!" using a class and a main function.

class Greeter:
    # Class to handle greeting messages
    def greet(self):
        # Print the greeting message
        print("Hello, World!")

def main():
    # Create an instance of Greeter and call its greet method
    greeter = Greeter()
    greeter.greet()

# Ensures the main function is executed only when the script is run directly
if __name__ == "__main__":
    main()
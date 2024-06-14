# factorial.py
def factorial(n):
    if n == 0:
        return 1
    else:
        return n * factorial(n - 1)

def main():
    for i in range(10):
        print(f"The factorial of {i} is {factorial(i)}")

if __name__ == "__main__":
    main()

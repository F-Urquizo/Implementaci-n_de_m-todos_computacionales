# fibonacci.py
def fibonacci(n):
    a, b = 0, 1
    sequence = []
    for _ in range(n):
        sequence.append(a)
        a, b = b, a + b
    return sequence

def main():
    n = 20
    sequence = fibonacci(n)
    print(f"Fibonacci sequence up to {n}: {sequence}")
    if n > 10:
        print("That's a lot of Fibonacci numbers!")

if __name__ == "__main__":
    main()

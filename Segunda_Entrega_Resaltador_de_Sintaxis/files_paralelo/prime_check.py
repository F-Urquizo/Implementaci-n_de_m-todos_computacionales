# prime_check.py
def is_prime(n):
    if n <= 1:
        return False
    for i in range(2, int(n**0.5) + 1):
        if n % i == 0:
            return False
    return True

def main():
    primes = []
    for i in range(100):
        if is_prime(i):
            primes.append(i)
    print(f"Prime numbers up to 100: {primes}")

if __name__ == "__main__":
    main()

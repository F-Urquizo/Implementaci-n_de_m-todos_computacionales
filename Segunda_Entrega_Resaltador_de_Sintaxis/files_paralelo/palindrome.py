# palindrome.py
def is_palindrome(s):
    return s == s[::-1]

def main():
    test_strings = ["racecar", "hello", "madam", "world", "level"]
    for s in test_strings:
        result = "is" if is_palindrome(s) else "is not"
        print(f"'{s}' {result} a palindrome.")

if __name__ == "__main__":
    main()

# Francisco Urquizo
# hello_world.py
def greet(name):
    return f"Hello, {name}!"

def main():
    print(greet("World"))
    print(greet("Alice"))
    print(greet("Bob"))
    names = ["Charlie", "David", "Eve"]
    for name in names:
        print(greet(name))

if __name__ == "__main__":
    main()

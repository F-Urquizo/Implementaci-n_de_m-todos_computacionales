# Francisco Urquizo
# file_io.py
def write_to_file(filename, content):
    with open(filename, 'w') as file:
        file.write(content)

def read_from_file(filename):
    with open(filename, 'r') as file:
        return file.read()

def main():
    filename = "example.txt"
    content = "Hello, this is a test file.\nThis file is used to demonstrate file I/O in Python."
    write_to_file(filename, content)
    read_content = read_from_file(filename)
    print(f"Content of {filename}:")
    print(read_content)

if __name__ == "__main__":
    main()

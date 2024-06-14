# temperature_converter.py
def celsius_to_fahrenheit(c):
    return (c * 9/5) + 32

def fahrenheit_to_celsius(f):
    return (f - 32) * 5/9

def main():
    temps_celsius = [0, 20, 37, 100]
    temps_fahrenheit = [32, 68, 98.6, 212]
    print("Celsius to Fahrenheit:")
    for temp in temps_celsius:
        print(f"{temp}°C = {celsius_to_fahrenheit(temp):.2f}°F")
    print("Fahrenheit to Celsius:")
    for temp in temps_fahrenheit:
        print(f"{temp}°F = {fahrenheit_to_celsius(temp):.2f}°C")

if __name__ == "__main__":
    main()

# Francisco Urquizo
# grade_calculator.py
def calculate_grade(scores):
    average = sum(scores) / len(scores)
    if average >= 90:
        return 'A'
    elif average >= 80:
        return 'B'
    elif average >= 70:
        return 'C'
    elif average >= 60:
        return 'D'
    else:
        return 'F'

def main():
    scores = [88, 92, 79, 93, 85]
    grade = calculate_grade(scores)
    print(f"Scores: {scores}")
    print(f"Grade: {grade}")

if __name__ == "__main__":
    main()

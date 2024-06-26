# bubble_sort.py
def bubble_sort(arr):
    n = len(arr)
    for i in range(n):
        for j in range(0, n-i-1):
            if arr[j] > arr[j+1]:
                arr[j], arr[j+1] = arr[j+1], arr[j]
    return arr

def main():
    data = [64, 34, 25, 12, 22, 11, 90]
    print(f"Original array: {data}")
    sorted_data = bubble_sort(data)
    print(f"Sorted array: {sorted_data}")

if __name__ == "__main__":
    main()

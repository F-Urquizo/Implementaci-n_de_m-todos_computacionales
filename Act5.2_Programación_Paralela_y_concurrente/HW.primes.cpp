#include <iostream>
#include <cmath>
#include <vector>
#include <pthread.h>
#include <chrono>
using namespace std;
using namespace std::chrono;

//////////// PARALLEL ////////////

#define NUM_THREADS 12

// Structure to send data to the threads
typedef struct {
    int id;
    long start;
    long end;
    long long result;
    pthread_mutex_t * mutex_ptr;
} thread_data_t;

// Function declarations:
// Sequential:
void sum_primes(long n);

// Parallel:
void * thread_func(void * args);
long long sum_primes_range(long start, long end);
int sum_primes_parallel(long limit, int num_threads);

// Overlap:
bool is_prime(int n);


int sum_primes_parallel(long limit, int num_threads)
{
    pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
    // Calculate the range for each thread
    long segment_size = limit / num_threads;

    // Array to store the thread id's
    pthread_t tids[num_threads];
    // Array for the data to be sent to the threads
    thread_data_t data[num_threads];

    long long total_sum = 0;

    for(int i = 0; i < num_threads; i++) {
        data[i].id = i;
        data[i].start = i * segment_size;
        data[i].end = (i == num_threads - 1) ? limit : (i + 1) * segment_size;
        data[i].result = 0;
        data[i].mutex_ptr = &mutex;

        int status = pthread_create(&tids[i], NULL, thread_func, &data[i]);
        if (status != 0) {
            cerr << "Unable to create threads" << endl;
            exit(1);
        }
        cout << "Created thread " << i << " with id: " << tids[i] << endl;
    }

    // Wait for the threads to finish and collect results
    for(int i = 0; i < num_threads; i++) {
        pthread_join(tids[i], NULL);
        cout << "Thread " << i << " finished with result: " << data[i].result << endl;

        // Sum up the results from each thread
        total_sum += data[i].result;
    }

    cout << "FINAL SUM OF PRIMES: " << total_sum << endl;

    return 0;
}

// Function to check if a number is prime
bool is_prime(int n) {
    bool prime = true; 
    long long upper_bound = std::ceil(std::sqrt(n));

    for (int j = 2; j <= upper_bound; j++) {
        if (n % j == 0) {
            prime = false;
            break; 
        }
    }
    if (n == 2)
    {
        prime = true;
    }
    if (n == 1)
    {
        prime = false;
    }
    return prime;
}

// Function to sum primes in a given range
long long sum_primes_range(long start, long end) {
    long long sum = 0;
    for (long i = start; i < end; i++) {
        if (is_prime(i)) {
            sum += i;
        }
    }
    return sum;
}

// Thread function to compute the sum of primes in a segment
void * thread_func(void * args) {
    thread_data_t * data = (thread_data_t *)args;

    cout << "Thread " << data->id << " processing range " << data->start << " to " << data->end << endl;
    data->result = sum_primes_range(data->start, data->end);

    pthread_exit(NULL);
}


//////////// SEQUENTIAL ////////////

void sum_primes(long n) {
    long long sum = 0;
    for (long i = 2; i < n; i++) {
        if (is_prime(i)) {
            sum += i;
        }
    }
    cout << "FINAL SUM OF PRIMES: " << sum << endl;
}

int main(int argc, char* argv[])
{
    // Parralel
    int num_threads = NUM_THREADS;
    long limit = 5000000;
    
    if (argc == 2) {
        num_threads = atoi(argv[1]);
    }

    cout << "Computing in parallel..." << endl;
    auto start = high_resolution_clock::now();
    sum_primes_parallel(limit, num_threads);
    auto end = high_resolution_clock::now();
    auto duration = duration_cast<milliseconds>(end - start);
    cout << "Time taken by function: " << duration.count() << " milliseconds" << endl;
    cout << endl;

    // Sequential
    cout << "Computing sequentially..." << endl;
    auto start2 = high_resolution_clock::now();
    sum_primes(limit);
    auto end2 = high_resolution_clock::now();
    auto duration2 = duration_cast<milliseconds>(end2 - start2);
    cout << "Time taken by function: " << duration2.count() << " milliseconds" << endl;    
}
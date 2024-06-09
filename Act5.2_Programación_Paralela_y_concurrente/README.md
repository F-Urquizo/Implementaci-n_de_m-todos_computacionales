# Act 5.2 Programación Paralela y Concurrente

# Explicación del Código

Este código en C++ está diseñado para calcular la suma de todos los números primos hasta un límite especificado, tanto de manera secuencial como en paralelo utilizando threads (threads). A continuación se detalla la estructura y funcionalidad del código.

## Estructura del Código

1. **Includes y Namespaces**:
   - Se incluyen los encabezados necesarios: `<iostream>`, `<cmath>`, `<vector>`, `<pthread.h>` y `<chrono>`.
   - Se usa el espacio de nombres `std` para evitar el prefijo `std::`.

2. **Constantes y Estructuras**:
   - Se define una constante `NUM_THREADS` que especifica el número de threads por defecto. Se asignó un valor de 12 a la constante puesto que el equipo en el que se realizó este programa tiene un procesador con esa cantidad de cores (para dividir la tarea lo más posible y así minimizar el tiempo de ejecución).
   - Se crea una estructura `thread_data_t` para enviar datos a los threads. Esta estructura contiene el ID del thread, el inicio y fin del rango que procesará el thread, el resultado de la suma de primos en el rango y un puntero a un mutex para sincronización (aunque no se usa en este código).

3. **Declaraciones de Funciones**:
   - `sum_primes(long n)`: Función secuencial para sumar primos.
   - `thread_func(void * args)`: Función que ejecuta cada thread.
   - `sum_primes_range(long start, long end)`: Función para sumar primos en un rango específico.
   - `sum_primes_parallel(long limit, int num_threads)`: Función principal para sumar primos en paralelo.
   - `is_prime(int n)`: Función para verificar si un número es primo.

## Función Principal

La función principal ejecuta dos métodos de cálculo: paralelo y secuencial.

### Modo Paralelo

1. Inicializa el número de threads (`num_threads`) y el límite (`limit`).
2. Si se proporciona un argumento en la línea de comandos, actualiza `num_threads`.
3. Mide el tiempo antes y después de llamar a `sum_primes_parallel(limit, num_threads)` usando `<chrono>`.
4. Imprime el tiempo de ejecución y el resultado de la suma de primos.

### Modo Secuencial

1. Mide el tiempo antes y después de llamar a `sum_primes(limit)`.
2. Imprime el tiempo de ejecución y el resultado de la suma de primos.

## Función para Sumar Primos en Paralelo

1. Inicializa un mutex (aunque no se usa en este código).
2. Divide el rango total (`limit`) por el número de threads (`num_threads`).
3. Asigna el rango de números a cada thread y crea los threads pasando los datos correspondientes.
4. Espera a que cada thread termine y suma los resultados de cada thread al `total_sum`.
5. Imprime el resultado final de la suma de primos.

## Funciones Auxiliares

### Verificación de Primos

- La función `is_prime(int n)` determina si un número `n` es primo verificando la divisibilidad desde 2 hasta la raíz cuadrada de `n`.

### Suma de Primos en un Rango

- La función `sum_primes_range(long start, long end)` suma todos los números primos en el rango de `start` a `end`.

### Función del thread

- La función `thread_func(void * args)` es ejecutada por cada thread. Calcula la suma de números primos en su rango asignado y almacena el resultado en `data->result`.

### Suma Secuencial de Primos

- La función `sum_primes(long n)` suma todos los números primos desde 2 hasta `n` de manera secuencial.

## Análisis de tiempo y speed-up

Usando la funcionalidad del encabezado `<chrono>`, se logró determinar el tiempo de ejecución de cada uno de los modos empleados para resolver el problema en cuestión (secuencial y paralelo). Se ejecutó el programa 5 veces y se obtuvo un promedio de los tiempos de ejecución de cada modo. Este proceso se muestra a continuación:

1. Primera ejecución
    - Secuencial: 797ms
    - Paralelo: 145ms
2. Segunda ejecución
    - Secuencial: 798ms
    - Paralelo: 132ms
3. Tercera ejecución
    - Secuencial: 798ms
    - Paralelo: 134ms
4. Cuarta ejecución
    - Secuencial: 797ms
    - Paralelo: 130ms
5. Quinta ejecución
    - Secuencial: 798ms
    - Paralelo: 139ms

Habiendo tomado las medidas anteriores, se determinaron los siguientes tiempos promedio:

- Secuencial: 797.6ms
- Paralelo: 136ms

Con esta información, se concluyó que el modo paralelo es aproximadamente **5.86** veces más rápido que el modo secuencial, usando todos los cores del equipo de cómputo en el que se realizó esta comparación (12 cores).




### Francisco Urquizo Schnaas
### 18/05/24

# Resaltador de Sintaxis

## Descripción: 
Este programa es un módulo en Elixir que se encarga de resaltar sintaxis de programas escritos en Python, generando un archivo HTML con el contenido del archivo fuente con etiquetas HTML que permiten aplicar estilos CSS a diferentes elementos de la sintaxis.

El módulo se llama `Highlighter` y contiene varias funciones. La función principal es `get_info`, que toma como argumento el nombre de un archivo de entrada. Primero, se construye el nombre del archivo de salida reemplazando la extensión del archivo de entrada con `.html`. Luego, se abre el archivo de salida para escritura. Se escribe la cabecera del archivo HTML, que incluye el título y un enlace a una hoja de estilos CSS, y se abre un bloque `<pre>` para mantener el formato de los espacios y saltos de línea del archivo fuente.

A continuación, se lee el archivo de entrada línea por línea utilizando `File.stream!()` y se aplica la función `filter_regex` a cada línea. Esta función se encarga de identificar y clasificar diferentes elementos de la sintaxis de Python, como comentarios, palabras reservadas, nombres de funciones, números, operadores, símbolos, cadenas de texto y espacios. Para cada tipo de elemento encontrado, se llama a la función `write_out`, que escribe el elemento en el archivo de salida envuelto en una etiqueta `<span>` con una clase CSS específica que corresponde al tipo de elemento, permitiendo así aplicar estilos de resaltado personalizados.

La función `filter_regex` utiliza una serie de expresiones regulares para identificar los diferentes elementos de la sintaxis. Si una expresión regular coincide con el inicio de la línea, se escribe la parte coincidente en el archivo de salida con la clase CSS correspondiente y se llama recursivamente a `filter_regex` con el resto de la línea. Este proceso se repite hasta que toda la línea ha sido procesada. Si ninguna expresión regular coincide, la línea se escribe tal cual en el archivo de salida con la clase CSS "default".

Finalmente, después de procesar todas las líneas del archivo de entrada, se escribe el pie de página HTML y se cierra el archivo de salida. La función `get_info` devuelve una tupla indicando el éxito y el nombre del archivo de salida generado. La última parte del código muestra un mensaje en la consola indicando el nombre del archivo HTML creado.

Este módulo permite convertir un archivo de Python en un archivo HTML con resaltado de sintaxis, facilitando la lectura y comprensión del código fuente al visualizarlo en un navegador web con estilos personalizados aplicados a diferentes elementos de la sintaxis de Python.

## Instrucciones para correr el código:
1. Abrir el directorio que contenga el programa de Elixir y el código fuente de Python en un editor de código.
2. Abrir una nueva terminal dentro del editor.
3. Ejecutar el siguiente comando en la terminal: elixir resaltador.exs

## Tokens y Expresiones Regulares (Regex):

### Comentarios
- **Regex**: `~r/#.*$/`
- **Descripción**: Identifica comentarios en una línea que comienzan con el símbolo `#`.

### Comentarios multilínea
- **Regex**: `~r/^(""".*""")|('''.*''')/`
- **Descripción**: Identifica comentarios multilínea encerrados entre triple comillas dobles `"""` o triples comillas simples `'''`.

### Espacios en blanco
- **Regex**: `~r/^\s+/`
- **Descripción**: Identifica secuencias de espacios en blanco.

### Palabras reservadas
- **Regex**: `~r/^\b(?:if|else|while|elif|for|def|return|is|not)\b/`
- **Descripción**: Identifica palabras reservadas del lenguaje Python.

### Nombres de funciones
- **Regex**: `~r/^\w+(?=\()/`
- **Descripción**: Identifica nombres de funciones seguidos por un paréntesis de apertura `(`.

### Números
- **Regex**: `~r/^[0-9]+(\.[0-9]+)?/`
- **Descripción**: Identifica números enteros y decimales.

### Variables
- **Regex**: `~r/^\b\w+\b/`
- **Descripción**: Identifica nombres de variables.

### Operadores
- **Regex**: `~r/^[\+\-\*\/=<>!]+/`
- **Descripción**: Identifica operadores matemáticos y lógicos.

### Símbolos
- **Regex**: `~r/^[{}[\]();,]/`
- **Descripción**: Identifica símbolos de puntuación y operadores de agrupación como `{}`, `[]`, `()`, `;`, y `,`.

### Cadenas de texto
- **Regex**: `~r/(['"])(?:(?=(\\?))\2.)*?\1/`
- **Descripción**: Identifica cadenas de texto encerradas entre comillas simples `'` o comillas dobles `"`.


## Análisis de Complejidad:

### Complejidad: O(n * m * p)

### Explicación: 
La complejidad temporal del código del módulo `Highlighter` puede analizarse a través de las operaciones realizadas por sus funciones principales. La función `get_info/1` abre el archivo de entrada, escribe la cabecera HTML en el archivo de salida y luego lee el archivo de entrada línea por línea. La lectura del archivo y la escritura inicial de la cabecera tienen una complejidad constante, O(1). Sin embargo, el proceso de leer y procesar todas las líneas del archivo tiene una complejidad lineal, O(n), donde n representa el número total de líneas en el archivo.

Dentro de la función `get_info/1`, cada línea se procesa utilizando la función `filter_regex/2`. Esta función aplica una serie de expresiones regulares secuenciales para identificar y clasificar diferentes elementos de la sintaxis de Python. Si asumimos que hay m expresiones regulares y que la longitud promedio de una línea es p, la complejidad de aplicar todas las expresiones regulares a una sola línea es O(m * p). Dado que `filter_regex/2` es recursiva y puede llamar a sí misma hasta p veces en el peor de los casos, la complejidad para procesar una línea completa se mantiene en O(m * p), ya que cada llamada recursiva procesa una parte más pequeña de la línea.

En conjunto, dado que cada una de las n líneas del archivo debe procesarse de esta manera, la complejidad temporal total del módulo `Highlighter` es O(n * m * p). Esto significa que el tiempo necesario para procesar el archivo es proporcional al número de líneas en el archivo, al número de expresiones regulares aplicadas y a la longitud promedio de las líneas. 

## Implicaciones éticas:

El desarrollo de herramientas como el resaltador de sintaxis del módulo `Highlighter` mejora la legibilidad y accesibilidad del código, facilitando la colaboración y el aprendizaje entre desarrolladores. Sin embargo, también plantea desafíos éticos, como la dependencia excesiva en la automatización, la necesidad de proteger datos sensibles y la importancia de crear soluciones sostenibles. Es crucial que los desarrolladores mantengan un equilibrio entre el uso de estas herramientas y el desarrollo de habilidades fundamentales, además de implementar prácticas robustas de seguridad y sostenibilidad.


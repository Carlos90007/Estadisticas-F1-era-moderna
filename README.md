# Estadisticas-F1-era-moderna
# Análisis Estadístico de la Fórmula 1: Pit Stops y Rendimiento (2018-2023)

Este repositorio contiene un proyecto de **Estadística Descriptiva** desarrollado en **R**. El objetivo principal es analizar la eficiencia de las paradas en boxes y la relación entre el rendimiento en la clasificación y el resultado final de la carrera en la era moderna de la F1.

## Descripción del Proyecto

El proyecto utiliza datos históricos de la base de datos Ergast para explorar tres pilares fundamentales:
1.  **Eficiencia Técnica:** Comparativa de tiempos de pit stop entre las principales escuderías (Red Bull, Mercedes, Ferrari, McLaren, Williams.).
2.  **Influencia de la Clasificación:** Análisis de correlación y regresión para determinar cuánto influye la posición de salida en el resultado final.
3.  **Efecto Circuito:** Estudio de cómo la arquitectura de cada trazado condiciona el tiempo perdido en el carril de boxes.

## Requisitos e Instalación
Para ejecutar el script estadisticas.r, necesitas tener instalado **R** y las siguientes librerías:

### Librerías necesarias
Puedes instalarlas todas ejecutando este comando en tu consola de R:
install.packages(c("readr", "dplyr", "ggplot2", "reshape2", "httpgd"))

## Análisis e Interpretación de Resultados
A continuación se detallan las conclusiones obtenidas tras la ejecución del análisis descriptivo:

### 1. Histograma + KDE: Distribución de Tiempos en Pit Lane:
Este gráfico combina el recuento por intervalos con una estimación continua de la densidad KDE. El histograma permite identificar la forma de la distribución, que en este caso presenta una asimetría positiva muy marcada. La mayor densidad de datos se concentra entre los 20 y 25 segundos, pero existe otra cola alta hacia la derecha generada por un conjunto de cirucitos con un pitlane mas largo o con menor velocidad en el pitlane, lo que provoca mayor tiempo de paradas para todos los equipos independientemente de la eficiencia en boxes de cada uno. La curva KDE suaviza el histograma para aproximar la función de densidad de probabilidad de la población. Al no asemejarse a una campana de Gauss simétrica, se sugiere visualmente la no normalidad de los datos.

### 2. Violin Plot: Densidad de Tiempos por Escudería:
El gráfico de violín ofrece una visión más completa que el boxplot tradicional al mostrar la densidad de los datos en cada nivel. El ancho de cada violín revela dónde se concentran la mayoría de las paradas de cada equipo. Se observa que Red Bull tiene una base más ancha en tiempos bajos, lo que indica una mayor frecuencia de paradas rápidas. Las diferencias en la altura y el grosor de los violines sugieren que la eficiencia técnica no es uniforme entre las escuderías.

### 3. Barras Horizontales: Top 10 Circuitos con Pit Lane más Lento:
El gráfico permite comparar valores absolutos, tiempos medios, entre diferentes trazados. Los circuitos están ordenados por magnitud, lo que permite identificar los trazados con mayor coste de tiempo en boxes, esta visualización permite ver que hay barreras físicas en cada circuito aparte del aspecto técnico de cada escudería.

### 4. Scatter Plot: Relación Grid vs. Posición Final:
Este gráfico de dispersión permite diagnosticar la relación entre el rendimiento del sábado y el éxito en la carrera del domingo. Se observa una tendencia lineal positiva clara, a medida que aumenta la posición en parrilla, tiende a aumentar la posición final.
La línea roja de regresión permite modelar esta relación, aunque existe dispersión debido a factores aleatorios de carrera, la pendiente ascendente confirma que la clasificación es un predictor significativo del resultado final.

### 5. Matriz de Correlación (year,grid,duracion pit stop, positionOrder).
Al analizar los resultados obtenidos en esta matriz, nos encontramos con tres casos mayoritariamente.
- grid vs. positionOrder: 0.6. Es la relación más fuerte de la matriz, como vimos el el scatter Plot, estan altamente relacionadas estas dos variables.
- duracion_segundos vs. positionOrder: 0.14. Existe una correlación positiva muy débil, esto sugiere que aunque perder tiempo en el pit lane tiende a empeorar la posición final, su peso en el resultado global es mucho menor que el de la posición de salida.
- year vs. resto de variables: valores cercanos a 0. La variable temporal muestra una independencia lineal práctica. Esto nos dice que ni la competitividad de la parrilla ni la velocidad de los pit stops han seguido una tendencia lineal sistemática de mejora o empeoramiento durante estos años analizados.

### 6. Gráfico de Líneas:
En este gráfico vemos la relación entre el tiempo de parada de boxes para diferentes equipos desde el año 2018-2023.
Red Bull y Ferrari destacan como los equipos con mejores tiempos en varios años.
2020 fue un punto crítico, con un empeoramiento generalizado.
Algunos equipos como McLaren muestran gran variabilidad, mientras que Red Bull es más consistente.
No hay una tendencia lineal clara, los tiempos fluctúan bastante año a año.

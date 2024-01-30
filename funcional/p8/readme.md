# **TIPOS de DATOS**

```hs
data Nota = Maestria Char | Cato Int Int | Umss Int
```

*1. Definir una función que reciba una nota y devuelva verdad(True) si esta es de la UMSS.*

*2. Definir una función que reciba una nota y devuelva su valor sólo en caso que sea de la Cato o de UMSS. En caso de ser de la Cato, que devuelva el promedio de las dos notas.*

*3. Definir una función que reciba una lista de notas y devuelva únicamente las notas de aprobación. La nota de aprobación para el caso de la Cato es cuando el promedio de sus valores componentes es mayor a 50 y de la Maestría, cuando el valor es A, B o C.*

*4. Definir una función que reciba una lista de notas y las devuelva ordenadas (suponer que una nota de San Simón es mayor a una nota de la Cato y una de Maestría es mayor que una de la UMSS).*

*5. Inventar 3 tipos de datos compuestos, para cada tipo inventar 3 funciones que se apliquen al mismo.*

*6. Definir una función que reciba 4 número y devuelva la suma del mayor de los 2 primeros con el mayor de los 2 siguientes utilizar la función mayor definida.*

```hs
data Rpta = Entero Int | Mensaje String
mayor x y   | x > y = Entero x
            | y > x = Entero y
            | otherwise = Mensaje “Iguales”
```

*7. Definir un tipo de datos para representar números enteros (Positivos y negativos). Utilizando este tipo definir los operadores: +,-,*,div.*

*8. Definir una función que reciba dos listas xs, ys (del tipo Lista a) y devuelva cuantas veces ocurre xs en ys.*

*9. Definir un tipo de datos para modelar árboles que se bifurcan en tres y guardan información únicamente en las hojas. Utilizando este tipo definir funciones para:*

* *a) Calcular el total de hojas*
* *b) Calcular el total de nodos no terminales*
* *c) Calcular la sumatoria de las hojas*
* *d) Comparar dos árboles*
* *e) Comparar una lista de árboles y devolver verdad si todos son iguales*
* *f) Definir la función foldTree*
* *g) Utilizando la función foldTree definir las funciones de los incisos a, b, c*
* *h) Añadir el tipo a la clase Eq*

*10. Definir un tipo de datos para modelar árboles que se bifurcan en tres y guardan información en los nodos no terminales y en las hojas. Utilizando este tipo definir funciones para:*

* *a) Calcular el total de hojas*
* *b) Calcular el total de nodos no terminales*
* *c) Calcular la sumatoria de las hojas*
* *d) Calcular la sumatoria de los valores de los nodos no terminales*
* *e) Comparar dos árboles*
* *f) Comparar una lista de árboles y devolver verdad si todos son iguales*
* *g) Definir la función foldTree*
* *h) Utilizando la función foldTree definir las funciones de los incisos a, b, c, d*
* *i) Añadir el tipo a la clase Eq*

*11. Definir un tipo de datos para modelar árboles que se bifurcan en tres o en dos ramas y guardan información únicamente en las hojas. Utilizando este tipo definir funciones para:*

* *a) Calcular el total de hojas*
* *b) Calcular el total de nodos no terminales*
* *c) Calcular la sumatoria de las hojas*
* *d) Comparar dos árboles*
* *e) Comparar una lista xs de árboles y devolver verdad si todos son iguales*

    - i. Representar xs como [a]
    - ii. Representar xs como Lista a

* *f) Definir la función foldTree*
* *g) Utilizando la función foldTree definir las funciones de los incisos a, b, c, e*
* *h) Añadir el tipo a la clase Eq*

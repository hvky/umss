# **LISTAS POR COMPRENSIÓN**

## **I.** ***Aplicando Listas por Comprensión, definir:***

*1. filter.*

*2. map,*

*3. concat,*

*4. length.*

*5. Una función que reciba una cadena y la encripte, cambiando las vocales por los caracteres correspondientes a los dígitos **1,2,3,4,5** respectivamente.*

*6. Una función que realice el producto cartesiano de dos conjuntos.*

*7. Una función que reciba un conjunto y un elemento y devuelva **True** si el elemento pertenece al conjunto, **False** en otro caso.*

*8. Una función que reciba dos conjuntos y devuelva la intersección de los mismos.*

*9. Una función que reciba un elemento, un conjunto y elimine el elemento del conjunto.*

*10. Una función que implemente la unión de dos conjuntos.*

*11. Una función que reciba una matriz y devuelva su diagonal principal.*

*12. Una función que reciba una matriz y devuelva su diagonal secundaria.*

*13. Una función que reciba una matriz y devuelva **True** si esta es un cuadrado perfecto.*

*14. Una función que multiplique 2 matrices.*

*15. Una función que reciba un número y devuelva **True** si es primo.*

*16. zipWith.*

*17. zip3 (hace lo mismo que zip pero con 3 listas, devuelve una lista de triplas).*

*18. zip4 (hace lo mismo que zip pero con 4 listas, devuelve una lista de tuplas de 4 elementos).*

*19. Definir una función que reciba una lista y una función de orden y devuelva la verdad si la lista esta ordenada de acuerdo a una función de orden.*

## **II.** ***Evaluar las siguientes expresiones:***

*1.* `[x | x <- [y | y <- [2, 3, 4, 5], even y], odd x]`

*2.* `[[1 |x <- [2 | y <- [1 .. 10]], even x] | z <- [1 .. 5]]`

*3.* `[even x | x <- [y | y <- [1 .. 20], y > 5], odd x]`

*4.* `[x | x <- [[[1, 2, 3, 4]]], x <- x, x <- x]`

*5.* `[[x | x <- [1, 2, 3], x <- y] | y <- [[‘a’, ’b’, ’c’], [‘d’, ’e’], [‘h’, ’i’, ’j’]]`

*6.* `[[x <- [1, 2, 3, 4]] | x <- [1, 2, 3], y <- [2, 3]]`

*7.* `[[x <- [1, 2, 3, 4]] | x <- [1, 2, 3], y <- []]`

*8.* `[[x <- [1, 2, 3, 4]] | x <- [1, 2, 3], y <- [2 .. x]]`

# **FOLD**

## **I.** ***Definir en términos de foldr:***

*1. Una función que reciba una lista y devuelva la productoria de sus elementos.*

*2. map.*

*3. filter.*

*4. length.*

*5. (++).*

*6. reverse.*

*7. concat.*

*8. takeWhile.*

*9. Una función que reciba una lista de dígitos y devuelva el Nro. que se forma al juntarlos.*

*10. Una función que encuentre el valor mínimo de una lista.*

*11. Una función que reemplace los elementos de una lista por el valor mínimo de esa lista.*

*12. Una función que reciba una lista y retorne true si la lista está ordenada ascendentemente, false en otro caso.*

## **II.** ***Sea la definición de la función foldl:***

```hs
foldl (⨁) a [] = a
foldl (⨁) a [x1, x2, x3..xn] =(...( (a ⨁ x1) ⨁ x2)..) ⨁ xn
```

*La misma definición utilizando función en lugar de operador, sería:*

```hs
foldl f a [] = a
foldl f a [x1, x2, x3..xn] =f(...f (f (f a x1) x2) x3 ...) xn
```

*Esta función es similar a foldr, sin embargo a diferencia de foldr que trabaja hacia la derecha, foldl trabaja hacia la izquierda ```(foldl = fold left, foldr = fold right)```.*

*1. Definir el tipo de foldl.*

*2. Hacer las anterior definiciones (1 al 12) utilizando foldl en lugar de foldr.*

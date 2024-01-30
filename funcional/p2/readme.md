# **PRINCIPIO CURRYING**

### **I.** *Escribir la definicion de tipos de las siguientes funciones. Por ejemplo la definicion de tipo de la funcion*

```hs
f x = 2 * x     ==>     f :: Int -> Int
```

```hs
1.  f1 x y z = if x then y + 10 else z

2.  f2 x y z = if z == 's' then 2 * x else y 

3.  f3 x y z = (x 2) && (y 'a') && (z True)

4.  f4 = (\x -> \y -> \z -> \w -> if x 2 then z else w + 10)

5.  f5 = (\(x, y) -> \(z, w) -> (x y) + (z w))

6.  f6 x = x

7.  f7 x y = x y

8.  f8 x y z = x (y z)

9.  f9 x y z = (x y) z

10. f10 x y z w = x (y (z w))

11. f11 x y z w = ((x y) z) w

12. f12 x y z w = (x y) (z w)

13. f13 x y z = x * 2 + y

16. f16 x y z = x y z

17. f17 x y z
        | x = y
        | y = z

18. f18 x y z = x (y z) (y z)

19. f19 f (x, y) = f x y

20. f20 f x y = f (x, y)

21. f21 x y z = s + y
        where s = z y

22. f22 x y z = r1 + r2
        where r1 = x 5 y
              r2 = x y z
              
23. f23 f = g
        where g x y = f (x, y)

24. f24 f = g
        where g (x, y) = f x y

25. f25 f = g
        where g x y z = f (x, y, z)

26. f26 e x y z w = if x && (y x) then z else w z
        where w a | a = e
                  | otherwise = z
```

### **II.** *Sean las funciones*

```hs
curry1 f x y = f (x, y)

curry2 f = g
    where g x y = f (x, y)

uncurry1 f (x, y) = f x y

uncurry2 f = g
    where g (x, y) = f x y

suma1 x y = x + y

suma2 (x, y) = x + y
```

*Escribir los tipos de las siguientes expresiones:*

```hs
1.  curry1 ::

2.  curry2 ::

3.  uncurry1 ::

4.  uncurry2 ::

5.  curry1 suma1 ::

6.  curry1 suma2 ::

7.  uncurry1 suma1 ::

8.  curry1 suma2 3 5 ::

9.  curry1 suma2 7 ::

10. curry1 uncurry1 suma1 2 3 ::

11. uncurry1 (curry1 suma2) (2, 3) ::

12. uncurry1 (curry1 suma2 (2, 3)) ::
```

### **III.** *Para las siguientes definiciones, definir la funcion fn de modo que obedezca el tipo:*

```hs
1.  f1 :: Int -> Int -> Int -> Bool -> Int -> Bool -> Int

2.  f2 :: (Int -> Int) -> Int -> Bool -> Int -> Bool -> Int

3.  f3 :: (Int -> Int) -> (Int -> Bool) -> Int -> Bool -> Int

4.  f4 :: (Int -> Int -> Int) -> Bool -> Int -> Bool -> Int

5.  f5 :: ((Int -> Int) -> Int -> Bool) -> Int -> Bool -> Int

6.  f6 :: (Int -> Int -> Int) -> Bool -> (Int -> Bool) -> Int

7.  f7 :: (Int, Int, Int) -> Bool -> Int -> Bool -> Int

8.  f8 :: (Int -> Int -> Int) -> (Bool -> Int -> Bool -> Int)

9.  f9 :: (Int -> Int -> Int) -> (Bool -> Int -> (Bool -> Int))

10. f10 :: ((Int -> Int) -> Int) -> (Bool -> (Int -> (Bool -> Int)))

11. f11 :: (Int -> (Int -> Int)) -> (Bool -> Int -> Bool -> Int)
```

### **IV.** *Sea la definicion de tipo de la funcion fn, en cada caso completar la expresion para que la definicion de fn obedezca el tipo*

```hs
1. f1 :: Int -> Int -> a -> Int -> Bool -> Bool -> Bool -> Int -> Bool -> Int -> Int -> Int

    a. f1 x = r
        where r .....

    b. f1 x s = y
        where y .....

    c. f1 x s t = y
        where y .....
  
    d. f1 x s t u = y
        where y .....

    e. f1 x s t u v = y
        where y .....
```

```hs
2. f2 :: ((Int -> Int) -> (Int -> Int -> Bool) -> Bool -> Bool) -> Int -> Bool -> (Int -> Int -> Int)

    a. f2 x = r
        where r .....

    b. f2 x s = y
        where y .....

    c. f2 x s t = y
        where y .....
  
    d. f2 x s t u = y
        where y .....

    e. f2 x s t u v = y
        where y .....
```

### **V.** *Deducir el tipo de las siguientes expresiones*

```hs
1. (\x -> \y -> \z -> if x then y 2 else z + 20) ::

2. (\x -> \y -> \z -> if x then y (*) else (&&)) ::

3. (\x -> \y -> x y) (\a -> 2 * a) ::

4. (\x -> \y -> x y) (\a -> \b -> 2 * a + b) ::

5. (\x -> \y -> \z -> x y z) (*) ::

6. (\x -> \y -> \z -> (x y) + z) (\a -> a && True) ::
```

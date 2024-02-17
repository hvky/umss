-- Para las siguientes definiciones, definir la funcion fn de modo que obedezca el tipo:

f1 :: Int -> Int -> Int -> Bool -> Int -> Bool -> Int
f1 a b c d e f = if d || f then b + c else a * e

f2 :: (Int -> Int) -> Int -> Bool -> Int -> Bool -> Int
f2 f a b c d = if b && d then f a else f c

f3 :: (Int -> Int) -> (Int -> Bool) -> Int -> Bool -> Int
f3 f g a b = if g a || b then f a else a

f4 :: (Int -> Int -> Int) -> Bool -> Int -> Bool -> Int
f4 f a b c = if a && c then f b 1 else 0

f5 :: ((Int -> Int) -> Int -> Bool) -> Int -> Bool -> Int
f5 f a b = if b || f ((-) 1) 5 then a else 1 

f6 :: (Int -> Int -> Int) -> Bool -> (Int -> Bool) -> Int
f6 f a g = if g (f 1 0) || a then 0 else 1

f7 :: (Int, Int, Int) -> Bool -> Int -> Bool -> Int
f7 (a, b, c) d e f = if a + b + c < 10 || d && f then e else 0

f8 :: (Int -> Int -> Int) -> (Bool -> Int -> Bool -> Int)
f8 f a b c = if a || c then f b b else b

f9 :: (Int -> Int -> Int) -> (Bool -> Int -> (Bool -> Int))
f9 = f8

f10 :: ((Int -> Int) -> Int) -> (Bool -> (Int -> (Bool -> Int)))
f10 f a b c = if a && c then f ((-) 1) else b

f11 :: (Int -> (Int -> Int)) -> (Bool -> Int -> Bool -> Int)
f11 = f9
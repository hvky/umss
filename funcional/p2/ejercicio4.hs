-- Sea la definicion de tipo de la funcion fn, en cada caso completar la expresion para que la definicion de fn obedezca el tipo

-- 1
f1 :: Int -> Int -> a -> Int -> Bool -> Bool -> Bool -> Int -> Bool -> Int -> Int -> Int
f1 n1 n2 a n3 b1 b2 b3 n4 b4 n5 n6 = 0

-- a.   f1 x :: b -> a -> c -> d -> e -> f -> g -> h -> i -> j -> Int
-- f1 x = r
--         where r b a c d e f g h i j =
--                 if (d && e) || (f && h) then (x + b) * i else c + g - j

-- b.   f1 x s :: a -> b -> c -> d -> e -> f -> g -> h -> i -> Int
-- f1 x s = y
--         where y a b c d e f g h i = 
--                 if b + f > 20 || (c && d) || (e && g)
--                     then x * h else s `div` i

-- c.   f1 x s t :: a -> b -> c -> d -> e -> f -> g -> h -> Int
-- f1 x s t = y
--         where y a b c d e f g h =
--                 if a * s == 10 && (b || c) || (d && f) then x + e else g - h

-- d.   f1 x s t u :: a -> b -> c -> d -> e -> f -> g -> Int
-- f1 x s t u = y
--         where y a b c d e f g = 
--                 case a && b || c && e of
--                         True -> x + s + u
--                         False -> (d + f) * g

-- e.   f1 x s t u v :: a -> b -> c -> d -> e -> f -> Int
-- f1 x s t u v = y
--         where y a b c d e f
--                 | a && b = x * s
--                 | v && d = u * f
--                 | otherwise = e - c

-- 2
f2 :: ((Int -> Int) -> (Int -> Int -> Bool) -> Bool -> Bool) -> Int -> Bool -> (Int -> Int -> Int)
f2 f n1 b1 n2 n3 = 0

-- a.   f2 x :: a -> b -> (c -> d -> Int)
-- f2 x = r
--         where r a b c d = if x (*2) (==) b then a + c else d 

-- b.   f2 x s :: a -> (b -> c -> Int)
-- f2 x s = y
--         where y a b c = if x (+1) esMayor True || a then s else b + c 
--               esMayor h g = h < g

-- c.   f2 x s t :: (a -> b -> Int)
-- f2 x s t = y
--         where y a b = case x (+s) (<) t of 
--                         True -> a 
--                         False -> b

-- d.   f2 x s t u :: a -> Int
-- f2 x s t u = y
--         where y a
--                 | x (div 2) (>) False = a
--                 | t || False = s + u

-- e.   f2 x s t u v :: Int
-- f2 x s t u v = y
--         where y = if x (mod v) (==) t then s else u

-- Escribir la definicion de tipos de las siguientes funciones. Por ejemplo la definicion de tipo de la funcion

f1 :: Bool -> Int -> Int -> Int
f1 x y z = if x then y + 10 else z

f2 :: Int -> Int -> Char -> Int
f2 x y z = if z == 's' then 2 * x else y

f3 :: (Int -> Bool) -> (Char -> Bool) -> (Bool -> Bool) -> Bool
f3 x y z = (x 2) && (y 'a') && (z True)

f4 :: (Int -> Bool) -> ty -> Int -> Int -> Int
f4 = (\x -> \y -> \z -> \w -> if x 2 then z else w + 10)

f5 :: ((Int -> Int), Int) -> ((Int -> Int), Int) -> Int
f5 = (\(x, y) -> \(z, w) -> (x y) + (z w))

f6 :: tx -> tx
f6 x = x

f7 :: (ty -> tr) -> ty -> tr
f7 x y = x y

f8 :: (ty -> tr) -> (tz -> ty) -> tz -> tr
f8 x y z = x (y z)

f9 :: (ty -> (tz -> tr)) -> ty -> tz -> tr
f9 x y z = (x y) z

f10 :: (ty -> tr) -> (tz -> ty) -> (tw -> tz) -> tw -> tr
f10 x y z w = x (y (z w))

f11 :: (ty -> tz -> tw -> tr) -> ty -> tz -> tw -> tr
f11 x y z w = ((x y) z) w

f12 :: (ty -> (tz -> tr)) -> ty -> (tw -> tz) -> tw -> tr
f12 x y z w = (x y) (z w)

f13 :: Int -> Int -> tz -> Int
f13 x y z = x * 2 + y

f16 :: (ty -> tz -> tr) -> ty -> tz -> tr
f16 x y z = x y z

f17 :: Bool -> Bool -> Bool -> Bool
f17 x y z
        | x = y
        | y = z

f18 :: (ty -> ty -> tr) -> (tz -> ty) -> tz -> tr
f18 x y z = x (y z) (y z)

f19 :: (tx -> ty -> tr) -> (tx, ty) -> tr
f19 f (x, y) = f x y

f20 :: ((tx, ty) -> tr) -> tx -> ty -> tr
f20 f x y = f (x, y)

f21 :: tx -> Int -> (Int -> Int) -> Int
f21 x y z = s + y
        where s = z y

f22 :: (Int -> Int -> Int) -> Int -> Int -> Int
f22 x y z = r1 + r2
        where r1 = x 5 y
              r2 = x y z

f23 :: ((tx, ty) -> tr) -> tx -> ty -> tr
f23 f = g
        where g x y = f (x, y)

f24 :: (tx -> ty -> tr) -> (tx, ty) -> tr
f24 f = g
        where g (x, y) = f x y

f25 :: ((tx, ty, tz) -> tr) -> tx -> ty -> tz -> tr
f25 f = g
        where g x y z = f (x, y, z)

f26 :: Bool -> Bool -> (Bool -> Bool) -> Bool -> (Bool -> Bool) -> Bool
f26 e x y z w = if x && (y x) then z else w z
        where w a | a = e
                  | otherwise = z

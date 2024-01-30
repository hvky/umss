-- Sean las funciones

curry1 :: ((tx, ty) -> tr) -> tx -> ty -> tr
curry1 f x y = f (x, y)

curry2 :: ((tx, ty) -> tr) -> tx -> ty -> tr
curry2 f = g
    where g x y = f (x, y)

uncurry1 :: (tx -> ty -> tr) -> (tx, ty) -> tr
uncurry1 f (x, y) = f x y

uncurry2 :: (tx -> ty -> tr) -> (tx, ty) -> tr
uncurry2 f = g
    where g (x, y) = f x y

suma1 :: Int -> Int -> Int
suma1 x y = x + y

suma2 :: (Int, Int) -> Int
suma2 (x, y) = x + y

-- Escribir los tipos de las siguientes expresiones:

-- 1.  curry1 :: ((tx, ty) -> tr) -> tx -> ty -> tr

-- 2.  curry2 :: ((tx, ty) -> tr) -> tx -> ty -> tr

-- 3.  uncurry1 :: (tx -> ty -> tr) -> (tx, ty) -> tr

-- 4.  uncurry2 :: (tx -> ty -> tr) -> (tx, ty) -> tr

-- 5.  curry1 suma1 :: ERROR! => [ (tx, ty) -> tr != Int -> Int -> Int ]

-- 6.  curry1 suma2 :: Int -> Int -> Int

-- 7.  uncurry1 suma1 :: (Int, Int) -> Int

-- 8.  curry1 suma2 3 5 :: Int

-- 9.  curry1 suma2 7 :: Int -> Int

-- 10. curry1 uncurry1 suma1 2 3 :: ERROR! => [ (tx, ty) -> tr != (tx -> ty -> tr) -> (tx, ty) -> tr ]

-- 11. uncurry1 (curry1 suma2) (2, 3) :: Int

-- 12. uncurry1 (curry1 suma2 (2, 3)) :: ERROR! => [ No recibe la tupla (tx, ty); aparte que curry1 no recibe ninguna tupla ]
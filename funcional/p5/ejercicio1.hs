-- 1
myFilter :: (a -> Bool) -> [a] -> [a]
myFilter f xs = [x | x <- xs, f x]

-- 2
myMap :: (a -> b) -> [a] -> [b]
myMap f xs = [f x | x <- xs]

-- 3
myConcat :: [[a]] -> [a]
myConcat xss = [y | ys <- xss, y <- ys]

-- 4
myLength :: [a] -> Int
myLength xs = sum [1 | _ <- xs]

-- 5
f5 :: String -> String
f5 c = [equivalente x | x <- c]
    where
        equivalente x = case x of
                  'a' -> '1'
                  'e' -> '2'
                  'i' -> '3'
                  'o' -> '4'
                  'u' -> '5'
                  _   -> x

-- 6
f6 :: [a] -> [b] -> [(a, b)]
f6 xs ys = [(x, y) | x <- xs, y <- ys]

-- 7
-- f7 :: [a] -> a -> Bool
f7 xs y = or [y == x | x <- xs]

-- 8
-- f8 :: [a] -> [a] -> [a]
f8 xs ys = [x | x <- xs, y <- ys, x == y]

-- 9
-- f9 :: a -> [a] -> [a]
f9 y xs = [x | x <- xs, x /= y]

-- 10
-- f10 :: [a] -> [a] -> [a]
-- (++)

-- 11
f11 :: [[a]] -> [a]
f11 xss = [xss !! y !! y | y <- [0 .. (length xss - 1)]]

-- 12
f12 :: [[a]] -> [a]
f12 xss = [xss !! y !! (tam - y) | y <- [0 .. tam] ]
    where
        tam = length xss - 1

-- 13
f13 :: [[a]] -> Bool
f13 xss = and [length x == length xss | x <- xss]

-- 14
-- f14 :: [[Int]] -> [[Int]] -> [[Int]]
-- Se sobreentiende que las matrices seran enviadas de manera correcta

-- 15
f15 :: Int -> Bool
f15 x = length [y | y <- [1 .. x], rem x y == 0] == 2

-- 16
myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith f xs ys = [f (xs !! n) (ys !! n) | n <- [0 .. mx]]
    where
        mx = if length xs < length ys then length xs - 1 else length ys - 1

-- 17
myZip3 :: [a] -> [b] -> [c] -> [(a,b,c)]
myZip3 xs ys zs = [(xs !! n, ys !! n, zs !! n) | n <- [0 .. tamMin - 1]]
    where
        tamMin = min (min (length xs) (length ys)) (length zs)

-- 18
myZip4 :: [a] -> [b] -> [c] -> [d] -> [(a,b,c,d)]
myZip4 ws xs ys zs = [(ws !! n, xs !! n, ys !! n, zs !! n) | n <- [0 .. tamMin - 1]]
    where
        tamMin = min (min (min (length ws) (length xs)) (length ys)) (length zs)

-- 19
-- estaOrdenada :: [Int] -> (Int -> Bool) -> Bool

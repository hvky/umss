-- 1
f1 :: [a] -> a
f1 xs = xs !! 2

-- 2
f2 :: [a] -> a
f2 xs = xs !! 1

-- 3
f3 :: [[(a -> b)]] -> a -> b
f3 xss x = ((xss !! 0) !! 0) x

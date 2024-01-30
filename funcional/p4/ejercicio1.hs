-- 1
f1 :: [Int] -> Int
f1 xs = foldr (*) 1 xs
{-
foldr :: (a -> b -> b) -> b -> [a] -> b
(*) :: Int -> Int -> Int

(a -> b -> b) = Int -> Int -> Int

=> xs = [1,2,4,5]
=> 1 * (2 * (3 * (4 * (5 * 1))))
=> 120
-}

-- 2
{-
-}

-- 3
{--}

-- 4
f4 :: [a] -> Int
f4 xs = foldr (\_ -> \y -> 1 + y) 0 xs
{-
=> [1,2,4,7,4]
=> 1 f (2 f (4 f (7 f (4 f 0))))
=> 1 f (2 f (4 f (7 f 1)))
=> 1 f (2 f (4 f 2))
=> 1 f (2 f 3)
=> 1 f 4
=> 5
-}

-- 5
{--}

-- 6
f6 :: [a] -> [a]
f6 xs = foldr (\x -> \y -> y ++ [x]) [] xs
{-
=> [1,2,3,5]
=> 1 f (2 f (3 f (5 f [])))
=> f a b = b ++ [a]
=> 1 f (2 f (3 f [5]))
=> 1 f (2 f [5, 3])
=> 1 f [5, 3, 2]
=> [5, 3, 2, 1]
-}

-- 7
--f7 :: [[a]] -> [a]
--f7 xss = foldr () [] xss
{-
=> [[1,2,4], [5], [6,7]]
=> [1,2,4,5,6,7]

=> 
-}

-- 8
--f8 :: (a -> Bool) -> [a] -> [a]
--f8 g xs = foldr () [] (f6 xs)
{-
=> takeWhile (>2) [1,2,4,4]
=> [False, False, True, True]
=> []
-}

-- 9
f9 :: [Int] -> Int
f9 xs = foldr (\x -> \y -> y * 10 + x) 0 (f6 xs)
{-
=> foldr x s [1,2,3,5]
=> 1 x (2 x (3 x (5 x s)))
=> 1235

s = Int
x = (a -> b -> b)  =>  b = a = Int
x :: (Int -> Int -> Int)

=> [5,3,2,1]
=> 5 f (3 f (2 f (1 f 0)))
f a b = a + 10 * b
1 f 0 = 1
2 f 1 = 12
3 f 12 = 123
5 f 123 = 1235
-}

-- 10
f10 :: [Int] -> Int
f10 xs = foldr (\x -> \y -> if x < y then x else y) (xs !! 0) xs
{-
=> [6,5,1,5,2]
=> 6 g (5 g (1 g (5 g (2 g 6))))
=> 6 g (5 g (1 g (5 g 2)))
=> 6 g (5 g (1 g 2))
=> 6 g (5 g 1)
=> 6 g 1
=> 1
-}

-- 11
f11 :: [Int] -> [Int]
f11 xs = foldr (\_ -> \ys -> menor : ys) [] xs
    where
        menor = f10 xs
{-
=> [2,4,1,5]
=> 2 f (4 f (1 f (5 f [])))
=> 2 f (4 f (1 f [1]))
=> 2 f (4 f [1,1])
=> 2 f [1,1,1]
=> [1,1,1,1]
-}

-- 12
f12 :: [Int] -> Bool
f12 xs = foldr (\x -> \b -> x >= (xs !! 0) && b) True xs
{-
=> [1,3,6,7,8]
=> 1 f (3 f (6 f (7 f (8 f True))))
=> 1 f (3 f (6 f (7 f True)))
=> 1 f (3 f (6 f True))
=> 1 f (3 f True)
=> 1 f True
=> True

=> [4,1,6,7,8]
=> 4 f (1 f (6 f (7 f (8 f True))))
=> 4 f (1 f (6 f (7 f True)))
=> 4 f (1 f (6 f True))
=> 4 f (1 f True)
=> 4 f False
=> False
-}

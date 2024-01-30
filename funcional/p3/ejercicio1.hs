-- 1
f1 = map (even.head) [[1,2,3,4],[6,7,1,2],[7,8]]
{-
map :: (a -> b) -> [a] -> [b]
(.) :: (b -> c) -> (a -> b) -> a -> c
even :: Int -> Bool
head :: [t] -> t

(b -> c) = even  =>  b = Int; c = Bool
(a -> b) = head  =>  a = [t]; b = t = Int entonces a = [Int]
even.head :: [Int] -> Bool

(a -> b) = even.head  =>  a = [Int]; b = Bool
map (even.head) :: [[Int]] -> [Bool]

map (even.head) [[1,2,3,4],[6,7,1,2],[7,8]] :: [Bool]

=> map even [head [1,2,3,4], head [6,7,1,2], head [7,8]]
=> map even [1, 6, 7]
=> [False, True, False]
-}

-- 2
f2 = filter ((>2).head) [[1,2,3,4],[6,7,1,2],[7,8]]
{-
filter :: (a -> Bool) -> [a] -> [a]
(.) :: (b -> c) -> (a -> b) -> a -> c
(>2) :: Int -> Bool
head :: [t] -> t

(b -> c) = (>2)  =>  b = Int; c = Bool
(a -> b) = head  =>  a = [t]; b = t = Int; t = [Int]
(>2).head :: [Int] -> Bool

(a -> Bool) = (>2).head  =>  a = [Int];
filter ((>2).head) :: [[Int]] -> [[Int]]

filter ((>2).head) [[1,2,3,4],[6,7,1,2],[7,8]] :: [[Int]]

=> filter (>2) [head [1,2,3,4], head [6,7,1,2], head [7,8]]
=> filter (>2) [1, 6, 7]
=> [[6,7,1,2], [7,8]]
-}

-- 3
f3 = takeWhile (even.head) [[1,2,3,4],[6,7,1,2],[7,8]]
{-
takeWhile :: (a -> Bool) -> [a] -> [a]
(.) :: (b -> c) -> (a -> b) -> a -> c
even :: Int -> Bool
head :: [t] -> t

(b -> c) = even  =>  b = Int, c = Bool
(a -> b) = head  =>  a = [Int], b = t = Int
even.head = [Int] -> Bool

(a -> Bool) = even.head  =>  a = [Int]
takeWhile (even.head) :: [[Int]] -> [[Int]]

takeWhile (even.head) [[1,2,3,4],[6,7,1,2],[7,8]] :: [[Int]]

=> takeWhile even [head [1,2,3,4], head [6,7,1,2], head [7,8]]
=> takeWhile even [1, 6, 7]
=> []
-}

-- 4
f4 = dropWhile (even.head) [[1,2,3,4],[6,7,1,2],[7,8]]
{-
dropWhile :: (a -> Bool) -> [a] -> [a]
even :: Int -> Bool
head :: [t] -> t

(b -> c) = even  =>  b = Int, c = Bool
(a -> b) = head  =>  a = [Int], b = t = Int
even.head = [Int] -> Bool

(a -> Bool) = even.head  =>  a = [Int]
dropWhile (even.head) :: [[Int]] -> [[Int]]

dropWhile (even.head) [[1,2,3,4],[6,7,1,2],[7,8]] :: [[Int]]

=> dropWhile even [head [1,2,3,4], head [6,7,1,2], head [7,8]]
=> dropWhile even [1, 6, 7]
=> [[1,2,3,4],[6,7,1,2],[7,8]]
-}

-- 5
f5 = ((\(x,y) -> y).last) (zip [1,2,3,4,5][map (*2), filter (>2)]) [1,2,6,8,3]
{-
(.) :: (b -> c) -> (a -> b) -> a -> c
(\(x,y) -> y) :: (x, y) -> y
last :: [a] -> a
zip :: [a] -> [b] -> [(a, b)]
map :: (a -> b) -> [a] -> [b]
filter :: (a -> Bool) -> [a] -> [a]
(*2) :: Int -> Int
(>2) :: Int -> Bool

-> zip [1,2,3,4,5][map (*2), filter (>2)]
-> [(1, map (*2)), (2, filter (>2))]

(\(x,y) -> y) = f

(b -> c) = f     =>  b = (x,y), c = y
(a -> b) = last  =>  a = [(x,y)], b = t = (x,y)
f.last :: [(x,y)] -> y

(x, y) = (1, map (*2))     =>  x = Int, y = [Int] -> [Int]
(x, y) = (2, filter (>2))  =>  x = Int, y = [Int] -> [Int]

f.last :: [(Int, [Int] -> [Int])] -> [Int] -> [Int]

(f.last) [(1, map (*2)), (2, filter (>2))] :: [Int] -> [Int]
(f.last) [(1, map (*2)), (2, filter (>2))] [1,2,6,8,3] :: [Int]

=> f (last [(1, map (*2)), (2, filter (>2))]) [1,2,6,8,3]
=> (\(x,y) -> y) (2, filter (>2)) [1,2,6,8,3]
=> filter (>2) [1,2,6,8,3]
=> [6,8,3]
-} 

-- 6
f6 = filter (even.length) (map (map (even.head.tail.tail)) [[[1,2,4,5,6],[8,3,5,2],[2,2,2]], [[1,2,4,5,6],[8,3,5,2]]])
{--}

-- 7
f7 = map (\(x,y) -> x y) (zip [takeWhile even,filter odd,dropWhile (even.(+3))] [[2,7,8],[3,6,5,4],[2,5,7]])
{--}

-- 8
f8 = map (map (head.tail.tail.init)) [[[2,7,8,1,3],[3,6,5,4,6,3],[2,5,7,1]], [[2,7,8,9,10],[1,2,3,6,5,4],[3,8,2,5,7]]]
{--}

-- 9
f9 = (head.tail.tail) [(+5),(*6),((*3).(+4))] 10
{-
head :: [a] -> a
tail :: [a] -> [a]
(.) :: (b -> c) -> (a -> b) -> a -> c

=> f9 = head (tail (tail [(+5),(*6),((*3).(+4))])) 10
=> head (tail [(*6), ((*3).(+4))]) 10
=> head [((*3).(+4))] 10
=> ((*3).(+4)) 10
=> (*3) ((+4) 10)
=> (*3) 14
=> 42
-}

-- 10
-- f10 = (head.tail.tail) [(+),(*),((*3).(+4))] 10  ERROR!
{-
(+) == (*) :: Int -> Int -> Int
(.) :: (b -> c) -> (a -> b) -> a -> c
(*3) :: Int -> Int
(+4) :: Int -> Int

(b -> c) = (*3)  =>  b = Int, c = Int
(a -> b) = (+4)  =>  a = Int, b = Int
((*3).(+4)) :: Int -> Int

=> Int -> Int es diferente a Int -> Int -> Int
=> los datos de la lista no son del mismo tipo
-}

-- 11
f11 = map (map (map (*2))) [[[1,2,3],[4,5]],[[6,7]],[[8],[9,10]]]
{-
map :: (a -> b) -> [a] -> [b]
(*2) :: Int -> Int

(a -> b) = (*2)  => a = Int, b = Int
map (*2) :: [Int] -> [Int]

(a -> b) = map (*2)  =>  a = [Int], b = [Int]
map (map (*2)) :: [[Int]] -> [[Int]]

(a -> b) = map (map (*2))  =>  a = [[Int]], b = [[Int]]
map (map (map (*2))) :: [[[Int]]] -> [[[Int]]]

map (map (map (*2))) [[[1,2,3],[4,5]],[[6,7]],[[8],[9,10]]] :: [[[Int]]]

=> [map (map (*2)) [[1,2,3],[4,5]], map (map (*2)) [[6,7]], map (map (*2)) [[8],[9,10]]]
=> [[map (*2) [1,2,3], map (*2) [4,5]], [map (*2) [6,7]], [map (*2) [8], map (*2) [9,10]]]
=> [[[2,4,6], [8,10]], [[12,14]], [[16], [18,20]]]
-}

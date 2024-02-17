-- f1 :: Eq a => [a] -> [a] -> Bool
f1 [] [] = True
f1 [] (x : xs) = False
f1 (x : xs) [] = False
f1 (x : xs) (y : ys) = x == y && f1 xs ys


f2 :: [Int] -> [Int] -> [Int]
f2 [] xs = xs
f2 xs [] = xs
f2 (x : xs) (y : ys) = if x < y then x : f2 xs (y : ys) else y : f2 (x : xs) ys


f3 :: [[a]] -> Bool
f3 [] = True
f3 [x] = True
f3 (ys : xs : xss) = length ys == length xs && f3 (xs : xss)


-- f4 :: [[Int]] -> Bool


f5 :: [Int] -> [Int]
f5 [] = []
f5 (x : xs) = if even x then x : f5 xs else f5 xs


f6 :: [[a]] -> [[a]]
f6 [] = []
f6 (xs : xss) = if even (length xs) then xs : f6 xss else f6 xss


f7 :: [Int] -> [Int]
f7 [] = []
f7 (x : xs) = if even x then f7 xs else x : f7 xs


f8 :: [[a]] -> [a]
f8 [] = []
f8 (xs:xss) = if length xs < 2 then f8 xss else xs !! (length xs - 2) : f8 xss


-- n > 0
f9 :: Int -> [Int]
f9 n = divi n n
  where
    divi _ 0 = []
    divi n m = if mod n m == 0 then m : divi n (m - 1) else divi n (m - 1)


-- f10 :: Eq a => [a] -> a -> Int
f10 xs x = getPos xs x 0
    where
        getPos [] _ _ = -1
        getPos (x:xs) y i = if x == y then i else getPos xs y (i + 1)


f11 :: [Int] -> Int -> Int
f11 xs x = getPos 0 fin (posMedio 0 fin)
    where
        fin = length xs - 1
        posMedio n m = div (n + m) 2

        getPos ini fin medio
                | fin < ini = -1
                | valMedio == x = medio
                | valMedio > x = getPos ini (medio - 1) (posMedio ini (medio - 1))
                | otherwise = getPos (medio + 1) fin (posMedio (medio + 1) fin)
            where
                valMedio = xs !! medio


-- f12 :: [Int] -> [Int]

-- f13 :: [Int] -> [Int]
-- f14 :: [Int] -> [Int]
-- f15 :: [Int] -> [Int]


f16 :: [[a]] -> [[a]]
f16 [] = []
f16 xss = transpuesta 0
    where
        transpuesta n
            | n < length (head xss) = obtenerValor n xss : transpuesta (n + 1)
            | otherwise = []

        obtenerValor _ [] = []
        obtenerValor n (xs:xss)
            | n < length xs = (xs !! n) : obtenerValor n xss
            | otherwise = []


f17 :: [[Int]] -> [[Int]] -> [[Int]]
f17 ass bss = doMat ass (f16 bss)
    where
        doMat [] _ = []
        doMat (fs:fss) css = (doFila fs css) : doMat fss css

        doFila _ [] = []
        doFila fs (cs:css) = (doElem fs cs) : (doFila fs css)

        doElem [] [] = 0
        doElem (f:fs) (c:cs) = f * c + (doElem fs cs)


f18 :: [[Int]] -> [[Int]] -> [[Int]] -> [[Int]]
f18 xss yss wss = f17 (f17 xss yss) wss


f19 :: [[Int]] -> [[Int]] -> [[Int]] -> [[Int]] -> [[Int]]
f19 xss yss wss zss = f17 (f17 (f17 xss yss) wss) zss


f20 :: [[[Int]]] -> [[Int]]
f20 [] = []
f20 [xss] = xss
f20 (xss:xsss) = f17 xss (f20 xsss)


-- f21 :: Eq a => [a] -> [a] -> Bool
f21 [] _ = True
f21 _ [] = False
f21 xs (y:ys) = estaDentro xs (y:ys) || f21 xs ys


-- f22 :: Eq a => [a] -> [a] -> [Int]
f22 xs ys = f xs ys 0
    where
        f _ [] _ = []
        f as (b:bs) i = if estaDentro as (b:bs) 
                            then i : f as bs (i + 1) 
                            else f as bs (i + 1)


-- estaDentro :: Eq a => [a] -> [a] -> Bool
estaDentro [] _ = True
estaDentro _ [] = False
estaDentro (x:xs) (y:ys) = x == y && estaDentro xs ys


---------------------------------------------------------------------------

myHead :: [a] -> a
myHead (x:xs) = x

myLast :: [a] -> a
myLast [x] = x
myLast (x:xs) = myLast xs

myLength :: [a] -> Int
myLength [] = 0
myLength (x:xs) = myLength xs + 1

myTake :: Int -> [a] -> [a]
myTake _ [] = []
myTake n (x:xs)
        | n <= 0 = []
        | n >= length (x:xs) = x:xs
        | otherwise = x : myTake (n - 1) xs

myDrop :: Int -> [a] -> [a]
myDrop _ [] = []
myDrop n (x:xs)
        | n >= length (x:xs) = []
        | n > 0 = myDrop (n - 1) xs
        | otherwise = x:xs

myZip :: [a] -> [b] -> [(a,b)]
myZip _ [] = []
myZip [] _ = []
myZip (x:xs) (y:ys) = (x,y) : myZip xs ys

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter _ [] = []
myFilter f (x:xs) = if f x then x : myFilter f xs else myFilter f xs

myMap :: (a -> b) -> [a] -> [b]
myMap _ [] = []
myMap f (x:xs) = f x : myMap f xs

myTakeWhile :: (a -> Bool) -> [a] -> [a]
myTakeWhile _ [] = []
myTakeWhile f (x:xs) = if f x then x : myTakeWhile f xs else []

myDropWhile :: (a -> Bool) -> [a] -> [a]
myDropWhile _ [] = []
myDropWhile f (x:xs) = if f x then myDropWhile f xs else x:xs

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith _ [] _ = []
myZipWith _ _ [] = []
myZipWith f (x:xs) (y:ys) = f x y : myZipWith f xs ys

myConcat :: [[a]] -> [a]
myConcat [] = []
myConcat (xs:xss) = xs `myMasMas` (myConcat xss)

myReverse :: [a] -> [a]
myReverse [] = []
myReverse (x:xs) = myMasMas (myReverse xs) [x]

(\\) :: Eq a => [a] -> [a] -> [a]
(\\) [] _ = []
(\\) (x:xs) ys = if esta x ys then xs \\ quitar x ys else x : (xs \\ ys)
    where
        esta _ [] = False
        esta a (b:bs) = a == b || esta a bs

        quitar _ [] = []
        quitar a (b:bs) = if a == b then bs else b : quitar a bs

myMasMas :: [a] -> [a] -> [a]
myMasMas [] xs = xs
myMasMas (x:xs) ys = x : myMasMas xs ys

myGetValor :: [a] -> Int -> a
myGetValor (x:xs) n = if n > 0 then myGetValor xs (n - 1) else x

mySum :: [Int] -> Int
mySum [] = 0
mySum (x:xs) = x + mySum xs

myAnd :: [Bool] -> Bool
myAnd [] = True
myAnd (x:xs) = x && myAnd xs

myOr :: [Bool] -> Bool
myOr [] = False
myOr (x:xs) = x || myOr xs

myFoldr :: (b -> a -> a) -> a -> [b] -> a
myFoldr _ x [] = x
myFoldr f x (y:ys) = f y (myFoldr f x ys)

-- 1
cuadrado :: Int -> Int
cuadrado x = x * x

-- 2 y 3
areaRectangulo, perimetroRectangulo :: Int -> Int -> Int
areaRectangulo x y = x * y
perimetroRectangulo x y = 2 * (x + y)

-- 4
esMayor :: Int -> Int -> Bool
esMayor x y = x > y

-- 5 y 6
esMultiploDe2, esMultiploDe2_3 :: Int -> Bool
esMultiploDe2 x = (x `rem` 2) == 0
esMultiploDe2_3 x = (x `rem` 3) == 0 && esMultiploDe2 x

-- 7 y 8
cubo, elevarA4, elevarA8, elevarA10, elevarA32 :: Int -> Int
cubo x = x * x * x
elevarA4 x = x * cubo x
elevarA8 x = cuadrado (elevarA4 x)
elevarA10 x = (cuadrado x) * (elevarA8 x)
elevarA32 x = elevarA4 (elevarA8 x)

-- 9
func :: Int -> Int -> (Int -> Int -> Bool) -> Bool
func x y f = f x y

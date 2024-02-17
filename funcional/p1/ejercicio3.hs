-- 1
mayorPorCombinacion :: Int -> Int -> Int -> Int -> Int
mayorPorCombinacion a b c d = max (max (max a b)  c) d

mayorPorDistincionCasos :: Int -> Int -> Int -> Int -> Int
mayorPorDistincionCasos a b c d 
    | a <= b && c <= b && d <= b = b
    | a <= c && d <= c = c
    | a <= d = d
    | otherwise = a

-- 2
promedio :: Int -> String
promedio x 
    | x > 50 && x <= 100 = "Aprobado" 
    | x < 51 && x >= 0 = "Reprobado"
    | otherwise = "Nota Incorrecta"

-- 3
verificarNota :: Int -> String
verificarNota x 
    | x > 89 && x < 101 = "Excelente"
    | x > 69 && x < 90 = "Bien"
    | x > 50 && x < 70 = "Regular"
    | x >= 0 && x < 51 = "Mal"
    | otherwise = "Nota Incorrecta"

-- 4
revisarNota :: Int -> Int -> Int -> Int -> Int
revisarNota a b c d = a

-- 5
mayorDe16 :: (Int, Int, Int, Int, Int, Int, Int, 
        Int, Int, Int, Int, Int, Int, Int, Int, Int) -> Int
mayorDe16 (a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p) = 
    mayorPorDistincionCasos (mayorPorDistincionCasos (mayorPorCombinacion 
    (mayorPorDistincionCasos (mayorPorDistincionCasos a b c d) e f g) h i j) k l m) n o p

-- 6
esMayor :: Float -> Bool
esMayor x 
    | x > 1 = True
    | otherwise = False

-- 7
fechaMayor :: (Int, Int, Int) -> (Int, Int, Int) -> (Int, Int, Int)
fechaMayor (d1, m1, a1) (d2, m2, a2)
    | a1 < a2 = (d2, m2, a2)
    | a1 > a2 = (d1, m1, a1)
    | m1 < m2 = (d2, m2, a2)
    | m1 > m2 = (d1, m1, a1)
    | d1 < d2 = (d2, m2, a2)
    | otherwise = (d1, m1, a1)

-- 8
aniosTranscurridos :: (Int, Int, Int) -> (Int, Int, Int) -> Int
aniosTranscurridos (d1, m1, a1) (d2, m2, a2)
    | (a1 < a2) && (m1 <= m2) && (d1 <= d2) = a2 - a1
    | (a1 < a2) && (m1 > m2) = a2 - a1 - 1
    | (a1 > a2) && (m1 >= m2) && (d1 >= d2) = a1 - a2
    | (a1 > a2) && (m1 < m2) = a1 - a2 - 1
    | otherwise = 0

{-
9. Definir una función que reciba 2 fechas y devuelva los meses transcurridos
10. Definir una función que reciba 2 fechas y devuelva los días transcurridos
11. Definir una función que reciba 2 fechas y devuelva los días, meses y años transcurridos
12. Definir una función que reciba un instante (fecha, hora) e incremente el instante en 1 segundo.
-}

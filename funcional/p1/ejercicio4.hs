-- 1
sgteVocal :: Char -> Char
sgteVocal x =
    case x of
        'a' -> 'e'
        'e' -> 'i'
        'i' -> 'o'
        'o' -> 'u'
        'u' -> 'a'
        _ -> '?'

-- 2
literalDe :: Int -> String
literalDe x =
    case x of
        0 -> "cero"
        1 -> "uno"
        2 -> "dos"
        3 -> "tres"
        4 -> "cuatro"
        5 -> "cinco"
        6 -> "seis"
        7 -> "siete"
        8 -> "ocho"
        9 -> "nueve"
        _ -> "no es un digito"

-- 3
operacionAND :: Int -> Int -> Bool
operacionAND x y =
    case (x, y) of
        (1, 1) -> True
        _ -> False

-- 4
operacionOR :: Int -> Int -> Bool
operacionOR x y =
    case (x, y) of
        (0, 0) -> False
        _ -> True

-- 5
operacionXOR :: Int -> Int -> Bool
operacionXOR x y =
    case (x, y) of
        (1, 1) -> False
        (0, 0) -> False
        _ -> True

-- 6
operacionARealizar :: () -> ()
operacionARealizar fun = fun

{-
7. Definir una función que reciba un número de dos dígitos y retorne su literal (similar al ejercicio 2)
8. Definir una función que reciba un número de tres dígitos y retorne su literal (similar al ejercicio 2)
-}

-- 9
menor :: Int -> Int -> Int
menor x y =
    case x < y of
        True -> x
        _ -> y

-- 10
menor6 :: Int -> Int -> Int -> Int -> Int -> Int -> Int
menor6 a b c d e f =
    case (a <= b && a <= c && a <= d && a <= e && a <= f) of
        True -> a
        _ -> case (b <= c && b <= d && b <= e && b <= f) of
            True -> b
            _ -> case (c <= d && c <= e && c <= f) of
                True -> c
                _ -> case (d <= e && d <= f) of
                    True -> d
                    _ -> case (e <= f) of
                        True -> e
                        _ -> f

-- 11
sumatoria :: Int -> Int -> Int -> String
sumatoria x y z =
    case (x + y + z) < 20 of
        True -> case (x + y + z) < 10 of
            True -> "Sumatoria Menor"
            False -> "Sumatoria Mayor"
        _ -> "Vacio"

-- 12
promedio :: Int -> Int -> Int -> String
promedio x y z =
    case (prom x y z) >= 90 && (prom x y z) <= 100 of
        True -> "Excelente"
        False -> case (prom x y z) < 90 && (prom x y z) >= 70 of
            True -> "Bien"
            False -> case (prom x y z) < 70 && (prom x y z) > 50 of
                True -> "Regular"
                False -> "Mal"

    where prom x y z = (x + y + z) `div` 3

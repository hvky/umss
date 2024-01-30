-- 1
cuadrado = \x -> x * x

areaRectangulo = \x -> \y -> x * y

perimetroRectangulo = \x -> \y -> (x + y) * 2

esMayor :: Int -> Int -> Bool
esMayor = \x -> \y -> x > y

esMultiploDe2 = \x -> x `rem` 2 == 0

esMultiploDe2_3 = \x -> esMultiploDe2 x && x `rem` 3 == 0

cubo = \x -> x * x * x

elevarA4 = \x -> x * cubo x
elevarA8 = \x -> cuadrado (elevarA4 x)
elevarA10 = \x -> (cuadrado x) * (elevarA8 x)
elevarA32 = \x -> elevarA4 (elevarA8 x)

func = \x -> \y -> \f -> f x y

-- 2
mayor :: Int -> Int -> Int
mayor = \x -> \y -> if x < y then y else x

mayorDe3 :: Int -> Int -> Int -> Int
mayorDe3 = \x -> \y -> \z ->
    if x >= y && x >= z then x else
        if y >= z then y else z

mayorDe4 :: Int -> Int -> Int -> Int -> Int
mayorDe4 = \x -> \y -> \z -> \w ->
    if x >= y && x >= z && x >= w then x else
        if y >= z && y >= w then y else
            if z >= w then z else w

revision = \pp -> \sp -> \ef -> \si ->
    if (pp == 0 && sp == 0 && ef == 0)
            then "Abandono!" 
            else if (pp + sp > 101) || (ef > 50)
                then "Aprobado"
                else if (pp + sp > 51) && si > 50
                    then "Aprobado"
                    else "Reprobado"

fechaMayor :: (Int, Int, Int) -> (Int, Int, Int) -> (Int, Int, Int)
fechaMayor = \f1@(d1, m1, a1) -> \f2@(d2, m2, a2) ->
    if a1 < a2 then f2 else
    if a1 > a2 then f1 else
    if m1 < m2 then f2 else
    if m1 > m2 then f1 else
    if d1 < d2 then f2 else f1

-- 3
mayorDe4PorCombinacion = \x -> \y -> \z -> \w -> mayor (mayor (mayor x y) z) w

{- No se puede usar distincion de casos, ni la expresion where -}

-- 4
sgteVocal = \v ->
    case v of
        'a' -> 'e'
        'e' -> 'i'
        'i' -> 'o'
        'o' -> 'u'
        'u' -> 'a'
        _ -> '?'

literal = \n ->
    case n of
        1 -> "uno"
        2 -> "dos"
        3 -> "tres"
        4 -> "cuatro"
        5 -> "cinco"
        6 -> "seis"
        7 -> "siete"
        8 -> "ocho"
        9 -> "nueve"
        0 -> "cero"
        _ -> "numero no valido"

and = \x -> \y ->
    case (x, y) of
        (1, 1) -> True
        _ -> False

or = \x -> \y ->
    case (x, y) of
        (0, 0) -> False
        _ -> True

xor = \x -> \y ->
    case (x, y) of
        (0, 1) -> True
        (1, 0) -> True
        _ -> False

operacionARealizar = \f -> f

menor :: Int -> Int -> Int
menor = \x -> \y ->
    case x < y of
        True -> x
        _ -> y

menorDe6 :: Int -> Int -> Int -> Int -> Int -> Int -> Int
menorDe6 = \a -> \b -> \c -> \d -> \e -> \f ->
    case a <= b && a <= c && a <= d && a <= e && a <= f of
        True -> a
        _ -> case b <= c && b <= d && b <= e && b <= f of
            True -> b
            _ -> case c <= d && c <= e && c <= f of
                True -> c
                _ -> case d <= e && d <= f of
                    True -> d
                    _ -> case e < f of
                        True -> e
                        _ -> f

sumatoria = \x -> \y -> \z ->
    case x + y + z < 20 of
        True -> case x + y + z < 10 of
            True -> "Sumatoria Menor"
            _ -> "Sumatoria Mayor"
        _ -> "Vacio"

promedio = \n1 -> \n2 -> \n3 ->
    case ((n1 + n2 + n3) `div` 3) >= 90 && ((n1 + n2 + n3) `div` 3) <= 100 of
        True -> "Excelente"
        False -> case ((n1 + n2 + n3) `div` 3) < 90 && ((n1 + n2 + n3) `div` 3) >= 70 of
            True -> "Bien"
            False -> case ((n1 + n2 + n3) `div` 3) < 70 && ((n1 + n2 + n3) `div` 3) > 50 of
                True -> "Regular"
                False -> "Mal"

-- 6
menorDe6ConDefinicionDeCasos :: Int -> Int -> Int -> Int -> Int -> Int -> Int
menorDe6ConDefinicionDeCasos = \a -> \b -> \c -> \d -> \e -> \f ->
    let
        men x y = if x < y then x else y
    in
        men (men (men (men (men a b) c) d) e) f

sumatoriaConDefinionesLocales = \x -> \y -> \z ->
    let
        esMenorA n = (x + y + z) < n
    in
        if esMenorA 20 then
            if esMenorA 10 then "Suamtoria Menor" else "Sumatoria Mayor"
        else "Vacio"

promedioConDefinicionesLocales = \n1 -> \n2 -> \n3 ->
    let
        verificar li lf = prom >= li && prom <= lf
        prom = (n1 + n2 + n3) `div` 3
    in
        if verificar 90 100 then "Excelente" else
            if verificar 70 89 then "Bien" else
                if verificar 51 69 then "Regular" else
                    if verificar 0 50 then "Mal" else "Notas Incorrectas!"

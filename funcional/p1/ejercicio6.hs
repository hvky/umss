-- 13
menorDe6 :: Int -> Int -> Int -> Int -> Int -> Int -> Int
menorDe6 a b c d e f =
    let
        comprobar x (a, b, c, d, e) = (x <= a) && (x <= b)
                                        && (x <= c) && (x <= d) && (x <= e)
    in
        if comprobar a (b, c, d, e, f) then a else
        if comprobar b (a, c, d, e, f) then b else
        if comprobar c (a, b, d, e, f) then c else
        if comprobar d (a, b, c, e, f) then d else
        if comprobar e (a, b, c, d, f) then e else f

-- 14
sumatoria :: Int -> Int -> Int -> String
sumatoria a b c =
    if esMenorA 20 then
        if esMenorA 10 then "Suamtoria Menor" else "Sumatoria Mayor"
    else "Vacio"

    where esMenorA x = (a + b + c) < x

-- 15
promedio :: Int -> Int -> Int -> String
promedio n1 n2 n3
  | verificar 90 100 = "Excelente"
  | verificar 70 89 = "Bien"
  | verificar 51 69 = "Regular"
  | verificar 0 50 = "Mal"
  | otherwise = "Notas Incorrectas"

  where verificar li lf = prom >= li && prom <= lf
        prom = (n1 + n2 + n3) `div` 3

{- 16. Inventar 3 ejercicios que muestren la utilidad de las definiciones locales -}

-- 1
mayor :: Int -> Int -> Int
mayor x y = if x < y then y else x

-- 2
mayorDe3 :: Int -> Int -> Int -> Int
mayorDe3 x y z = 
        if x < y
            then if z < y then y else z
            else if x > z then x else z

-- 3
mayorDe4 :: Int -> Int -> Int -> Int -> Int
mayorDe4 a b c d =
        if a < b
            then if c < b
                then if d < b then b else d
                else if c > d then c else d
            else if a > c
                then if a > d then a else d
                else if c > d then c else d

-- 10
promedio :: Int -> Int -> Int -> Int -> String
promedio a b c d = 
        if (a == 0 && b == 0 && c == 0)
            then "Abandono!" 
            else if (a + b > 101) || (c > 50)
                then "Aprobado"
                else if (a + b > 51) && d > 50
                    then "Aprobado"
                    else "Reprobado"

-- 11
fechaMayor :: (Int, Int, Int) -> (Int, Int, Int) -> (Int, Int, Int)
fechaMayor (d1, m1, a1) (d2, m2, a2) = 
        if a1 < a2
            then (d2, m2, a2) 
            else if a1 > a2
                then (d1, m1, a1)
                else if m1 < m2
                    then (d2, m2, a2)
                    else if m1 > m2
                        then (d1, m1, a1)
                        else if d1 < d2
                            then (d2, m2, a2)
                            else if d1 > d2
                                then (d1, m1, a1)
                                else (d2, m2, a2)

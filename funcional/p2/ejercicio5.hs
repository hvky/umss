-- Deducir el tipo de las siguientes expresiones

f1 = (\x -> \y -> \z -> if x then y 2 else z + 20) :: Bool -> (Int -> Int) -> Int -> Int

f2 = (\x -> \y -> \z -> if x then y (*) else (&&)) :: Bool -> ((Int -> Int -> Int) -> (Bool -> Bool -> Bool)) -> tz -> (Bool -> Bool -> Bool)

f3 = (\x -> \y -> x y) (\a -> 2 * a) :: Int -> Int

f4 = (\x -> \y -> x y) (\a -> \b -> 2 * a + b) :: Int -> Int -> Int

f5 = (\x -> \y -> \z -> x y z) (*) :: Int -> Int -> Int

-- f6 = (\x -> \y -> \z -> (x y) + z) (\a -> a && True) :: ERROR!, no se puede realizar la operacion (Bool + Int)

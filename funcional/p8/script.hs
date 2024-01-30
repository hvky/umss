data Nota = Maestria Char | Cato Int Int | Umss Int
    deriving Show

data Res a b = Ok a | Err b
    deriving Show

-- 1
type EsDeLaUmss = Bool
f1 :: Nota -> EsDeLaUmss

f1 (Umss _) = True
f1 _ = False


-- 2
type Promedio = Int
f2 :: Nota -> Res Promedio String

f2 (Maestria _) = Err "Error inesperado"
f2 (Cato n m) = Ok (div (n + m) 2)
f2 (Umss n) = Ok n


-- 3
type Notas = [Nota]
type Aprobados = Notas
f3 :: Notas -> Aprobados

f3 [] = []
f3 (x : xs) = if prom x then x : f3 xs else f3 xs
    where
        prom (Maestria c) = c == 'A' || c == 'B' || c == 'C'
        prom (Cato n m) = div (n + m) 2 > 50
        prom (Umss n) = n > 50


-- f4 :: Notas -> Notas
-- ordenar las notas


-- 5


-- 6
data Rpta = Entero Int | Mensaje String
    deriving Show

mayor :: Int -> Int -> Rpta
mayor x y | x > y = Entero x
          | y > x = Entero y
          | otherwise = Mensaje "Iguales"

f6 :: Int -> Int -> Int -> Int -> Int
f6 a b c d = sumar n m
    where
        n = case mayor a b of
                (Mensaje _) -> Entero a
                _ -> mayor a b

        m = case mayor c d of
                (Mensaje _) -> Entero c
                _ -> mayor c d

        sumar (Entero n) (Entero m) = n + m


-- 7
data Entero = Cero | Mas Entero | Menos Entero
    deriving Show

intToEntero :: Int -> Entero
intToEntero n
    | n > 0 = Mas (intToEntero (n - 1))
    | n < 0 = Menos (intToEntero (n + 1))
    | otherwise = Cero

enteroToInt :: Entero -> Int
enteroToInt Cero = 0
enteroToInt (Mas n) = 1 + enteroToInt n
enteroToInt (Menos n) = (enteroToInt n) - 1

-- defii¿nir las 4 operacion basicas


-- 8
data Lista a = Vacia | Add a (Lista a)
    deriving Show

f8 :: Eq a => Lista a -> Lista a -> Int
f8 _ Vacia = 0
f8 xs (Add y ys) = if seEncuentra xs (Add y ys) then 1 + f8 xs ys else f8 xs ys
    where
        seEncuentra Vacia _ = True
        seEncuentra _ Vacia = False
        seEncuentra (Add x xs) (Add y ys) = x == y && seEncuentra xs ys


-- 9
data ArbolNodo a = Hoja a | Rama (ArbolNodo a) (ArbolNodo a) (ArbolNodo a)
    deriving Show

f9a :: ArbolNodo a -> Int
f9a (Hoja _) = 1
f9a (Rama a b c) = (f9a a) + (f9a b) + (f9a c)

f9b :: ArbolNodo a -> Int
f9b (Hoja _) = 0
f9b (Rama a b c) = 1 + (f9b a) + (f9b b) + (f9b c)

f9c :: ArbolNodo Int -> Int
f9c (Hoja x) = x
f9c (Rama a b c) = (f9c a) + (f9c b) + (f9c c)

f9d :: Eq a => ArbolNodo a -> ArbolNodo a -> Bool
f9d (Rama _ _ _) (Hoja _) = False
f9d (Hoja _) (Rama _ _ _) = False
f9d (Hoja x) (Hoja y) = x == y
f9d (Rama a b c) (Rama x y z) = (f9d a x) && (f9d b y) && (f9d c z)

f9e :: Eq a => [ArbolNodo a] -> Bool
f9e [] = True
f9e [x] = True
f9e (y:x:xs) = f9d y x && f9e (x:xs)

-- f9f
-- f9g

-- f9h
instance (Eq a) => Eq (ArbolNodo a) where
    (==) (Hoja a) (Hoja b) = a == b
    (==) (Rama a b c) (Rama x y z) = a == x && b == y && c == z
    (==) _ _ = False


-- 10
data ArbolC a = HojaC a | RamaC a (ArbolC a) (ArbolC a) (ArbolC a)
    deriving Show
    
f10a :: ArbolC a -> Int
f10a (HojaC _) = 1
f10a (RamaC _ a b c) = (f10a a) + (f10a b) + (f10a c)

f10b :: ArbolC a -> Int
f10b (HojaC _) = 0
f10b (RamaC _ a b c) = 1 + (f10b a) + (f10b b) + (f10b c)

f10c :: ArbolC Int -> Int
f10c (HojaC x) = x
f10c (RamaC x a b c) = x + (f10c a) + (f10c b) + (f10c c)

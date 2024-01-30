type Dia = Int
type Mes = Int
type Anio = Int
type Fecha = (Dia, Mes, Anio)
type Periodo = (Fecha, Fecha)
type Nombre = String
type Presidente = (Nombre, Periodo)


-- 1
type AniosTranscurridos = Int
f1 :: Periodo -> AniosTranscurridos
-- Se sobreentiende que el periodo sera ingresado de manera correcta
f1 ((_,_,a1), (_,_,a2)) = a2 - a1

-- 2
type TiempoGobernado = AniosTranscurridos
f2 :: Presidente -> TiempoGobernado

f2 (_, p) = f1 p

-- 3
type PresidenteMayorTiempoGobernado = Presidente
f3 :: Presidente -> Presidente -> PresidenteMayorTiempoGobernado

f3 pA pB = if f2 pA > f2 pB then pA else pB

-- 4
type Presidentes = [Presidente]
type NombrePresidenteMenorTiempoGoberno = Nombre
f4 :: Presidentes -> NombrePresidenteMenorTiempoGoberno

f4 [] = ""
f4 [(n, _)] = n
f4 (x : y : ps) = if f2 x < f2 y then f4 (x:ps) else f4 (y:ps)

-- 5
type NombresPresidentesEstuvieron1980 = [Nombre]
f5 :: Presidentes -> NombresPresidentesEstuvieron1980

f5 [] = []
f5 ((n, ((_, _, a1), (_, _, a2))) : ps) = if a1 <= 1980 && a2 >= 1980 then n : f5 ps else f5 ps

-- 6
type CantidadPresidentesGobernaronMenos4 = Int
f6 :: Presidentes -> CantidadPresidentesGobernaronMenos4

f6 [] = 0
f6 (p : ps) = if f2 p < 4 then 1 + (f6 ps) else f6 ps


-- 7
type FechasGobiernoOrdenada = Presidentes
f7 :: Presidentes -> FechasGobiernoOrdenada

f7 [] = []
f7 (pA@(_, ((_, _, x), _)) : pB@(_, ((_, _, y), _)) : ps) = []
-- aplicar algoritmo de ordenamiento

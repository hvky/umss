data ZonaGeografica = Valles | Llanos | Altiplano
    deriving Show

data Departamento = Pando | Beni | La_Paz | Cochabamba | Santa_Cruz | Oruro | Chuquisaca | Potosi | Tarija
    deriving (Show, Eq)


-- 1
type Caracteristica = String
f1 :: ZonaGeografica -> Caracteristica

f1 Valles = "Clima Variado"
f1 Llanos = "Clima Humedo"
f1 Altiplano = "Clima Frio"

-- 2
type EstaEnElValle = Bool
f2 :: Departamento -> EstaEnElValle

f2 d = d == Cochabamba || d == Chuquisaca || d == Tarija


-- 3
f3 :: Departamento -> ZonaGeografica

f3 d
    | d == Beni || d == Pando || d == Santa_Cruz = Llanos
    | d == La_Paz || d == Potosi || d == Oruro = Altiplano
    | otherwise = Valles

-- 4
type Departamentos = [Departamento]
type DepartamentosFueraDelAltiplano = Departamentos
f4 :: Departamentos -> DepartamentosFueraDelAltiplano

f4 [] = []
f4 (d:ds) = case (f3 d) of
                Altiplano -> f4 ds
                _ -> d: f4 ds

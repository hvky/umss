type Nombre = String
type Horas = Int
type SueldoHora = Float
type Salario = Float
type Materias = [String]
type Cargo = String

data Empleado = Docente Nombre Horas SueldoHora Materias | Administrativo Nombre Salario Cargo
    deriving (Show, Eq)


-- 1
type MismoSueldoDiferenteRol = Bool
f1 :: Empleado -> Empleado -> MismoSueldoDiferenteRol

f1 (Docente _ h sH _) (Administrativo _ s _) = s == calcularSalario h sH
f1 _ _ = False

calcularSalario :: Horas -> SueldoHora -> Salario
calcularSalario 0 _ = 0
calcularSalario h sH = sH + calcularSalario (h - 1) sH

-- 2
type Empleados = [Empleado]
type DocenteConMayorMaterias = Nombre
f2 :: Empleados -> DocenteConMayorMaterias

f2 [] = ""
f2 [Docente n _ _ _] = n
f2 (x@(Docente _ _ _ msA) : y@(Docente _ _ _ msB) : es) =
         if length msA >= length msB then f2 (x:es) else f2 (y:es)

-- 3
type EmpleadoConMayorSueldo = Nombre
f3 :: Empleados -> EmpleadoConMayorSueldo

f3 [] = ""
f3 [Docente n _ _ _]  = n
f3 [Administrativo n _ _] = n
f3 (x : y : es) = f3 (sueldoMayor x y : es)

sueldoMayor :: Empleado -> Empleado -> Empleado
sueldoMayor e1@(Docente _ h1 sH1 _) e2@(Docente _ h2 sH2 _) =
        if calcularSalario h1 sH1 >= calcularSalario h2 sH2 then e1 else e2
sueldoMayor e1@(Docente _ h sH _) e2@(Administrativo _ s _) =
        if calcularSalario h sH >= s then e1 else e2
sueldoMayor e1@(Administrativo _ s _) e2@(Docente _ h sH _) =
        if s >= calcularSalario h sH then e1 else e2
sueldoMayor e1@(Administrativo _ s1 _) e2@(Administrativo _ s2 _) =
        if s1 >= s2 then e1 else e2

-- 4
f4 :: Empleado -> Empleados -> Empleados
f4 e [] = [e]
f4 e (x : ls) = if sueldoMayor e x == x then e : x : ls else x : f4 e ls 

-- 5
type ListaOrdenadaSegunSalarios = Empleados
f5 :: Empleados -> ListaOrdenadaSegunSalarios
f5 [] = []
f5 [x] = [x]
-- aplicar algoritmo de ordenamiento

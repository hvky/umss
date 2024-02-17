# **TIPOS SINONIMOS Y TIPOS ENUMERADOS**

## **I.** ***Definir los siguientes tipos de datos:***

* *ZonaGeografica que permita representar las 3 zonas geográficas de Bolivia (valles, llanos y altiplano).*
* *Departamento que permita representar los 9 departamentos de Bolivia.*

### *Utilizando estos tipos definir las siguientes funciones:*

*1. Una función que reciba un zona y devuelva un mensaje indicando sus características.*

*2. Una función que reciba un departamento y devuelva True si pertenece a la zona de los valles, falso en otro caso.*

*3. Una función que reciba un departamento y devuelva la zona a la que corresponde el departamento.*

*4. Una función que reciba un lista de departamentos y devuelva aquellos que pertenecen a la zona de los llanos o de los valles.*

## **II.** ***Sean las siguientes definiciones de tipo:***

```hs
type Dia        = Int
type Mes        = Int
type Anio       = Int
type Fecha      = (Dia, Mes, Anio)
type Periodo    = (Fecha, Fecha)
type Nombre     = String
type Presidente = (Nombre, Periodo)
```

### *Definir:*

*1. Una función que reciba un Periodo y devuelva el tiempo transcurrido en años.*

*2. Una función que reciba un Presidente y devuelva el tiempo total en años que gobernó.*

*3. Definir una función que reciba dos presidentes y devuelva aquel que gobernó más tiempo.*

*4. Una función que reciba una lista de presidentes y devuelva el nombre del presidente que menos tiempo gobernó.*

*5. Una función que reciba una lista de presidentes y devuelva una lista con los nombres de los presidentes que gobernaron antes del año 1990.*

*6. Una función que reciba una lista de presidentes y devuelva la cantidad de presidentes que gobernaron menos de 4 años.*

*7. Una función que reciba una lista de presidentes y la ordene ascendentemente por la fecha en que fue presidente.*

## **III.** ***Sea el siguiente tipo de datos:***

```hs
type Nombre     = String
type Horas      = Int
type SueldoHora = Float
type Salario    = Float
type Materia    = [String]
type Cargo      = String

data Empleado = Docente Nombre Horas SueldoHora Materias | Administrativo Nombre Salario Cargo
```

*1. Definir una función que reciba dos empleados y devuelva verdad si ambos tienen el mismo ingreso mensual pero uno es docente y el otro es administrativo.*

*2. Definir una función que reciba una lista de empleados y devuelva el nombre del docente que dicta mayor cantidad de materias.*

*3. Definir una función que reciba una lista de empleados y devuelva el nombre del empleado que tiene mayor salario mensual.*

*4. Definir una función que reciba un empleado (e) y una lista ordenada ascendentemente de acuerdo al ingreso mensual percibido (ls) y que inserte e en ls en la posición que le corresponde, de modo que la lista resultante siga ordenada.*

*5. Definir una función que reciba una lista de empleados y devuelva la lista ordenada ascendentemente por ingresos mensuales del empelado.*

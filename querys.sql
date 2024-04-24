SELECT 
  p.nombre AS Nombre,
  GROUP_CONCAT(t.numero) AS Telefonos,
  c.nombre AS Ciudad,
  pa.nombre AS Pais,
  paq.tipo AS Paquete_Elegido,
  CASE
    WHEN fp.id IS NOT NULL THEN 'Contado'
    WHEN cr.id_forma_pago IS NOT NULL THEN 'Crédito'
  END AS Modalidad_Pago
FROM
  PERSONA p
JOIN
  TELEFONO t ON p.id = t.id_cuenta
JOIN
  CIUDAD c ON p.id_ciudad_residencia = c.id
JOIN
  PAIS pa ON c.id_pais = pa.id
JOIN
  SUSCRIPCION s ON p.id = s.id_cuenta
JOIN
  PAQUETE paq ON s.id_paquete = paq.id
LEFT JOIN
  FORMA_PAGO fp ON s.id_forma_pago = fp.id
LEFT JOIN
  CREDITO cr ON fp.id = cr.id_forma_pago
LEFT JOIN
  CONTADO co ON fp.id = co.id_forma_pago
WHERE
  s.fecha_adquisicion BETWEEN '2024-01-01' AND NOW()
GROUP BY
  p.id, p.nombre, c.nombre, pa.nombre, paq.tipo, fp.id, cr.id_forma_pago, co.id_forma_pago;


-- *****************************************************************
-- SELECT 
--   ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS Puesto,
--   c.titulo AS Titulo_Pelicula,
--   COUNT(*) AS Cantidad_Visualizaciones
-- FROM 
--   VISUALIZACION v
-- JOIN 
--   CONTENIDO c ON v.id_contenido = c.id
-- JOIN 
--   CUENTA cu ON v.id = cu.id_persona
-- JOIN 
--   PERSONA p ON cu.id_persona = p.id
-- JOIN 
--   CIUDAD ci ON p.id_ciudad_residencia = ci.id
-- JOIN 
--   PAIS pa ON ci.id_pais = pa.id
-- WHERE 
--   pa.nombre = 'Bolivia'
--   AND MONTH(v.fecha) = 2
--   AND YEAR(v.fecha) = 2024
-- GROUP BY 
--   c.titulo
-- ORDER BY 
--   Cantidad_Visualizaciones DESC
-- LIMIT 5;


-- -- *****************************************************************
-- SELECT
--   MIN(t.fecha_estreno) AS Fecha_Primer_Capitulo,
--   COUNT(DISTINCT t.id) AS Total_Temporadas,
--   SUM(t.cantidad_capitulos) AS Total_Capitulos,
--   COUNT(DISTINCT re.id_empresa) AS Empresas_Produccion,
--   MAX(c.fecha_estreno) AS Fecha_Ultimo_Capitulo
-- FROM 
--   TEMPORADA t
-- JOIN 
--   CAPITULO c ON t.id = c.id_temporada
-- JOIN 
--   R_CONTENIDO_EMPRESA re ON t.id_serie = re.id_contenido
-- JOIN 
--   CONTENIDO co ON t.id_serie = co.id
-- WHERE 
--   co.titulo = 'LA LEY Y EL ORDEN UVE';


-- -- *****************************************************************
-- SELECT 
--   p.nombre AS Nombre_Actor,
--   pais_origen.nombre AS Pais_Origen,
--   pais_residencia.nombre AS Pais_Residencia,
--   rca.rol AS Rol,
--   e.fecha AS Ano_Estreno_Pelicula,
--   COUNT(v.id) AS Numero_Visualizaciones
-- FROM 
--   CONTENIDO c
-- JOIN
--   ESTRENO e on c.id = e.id_contenido
-- JOIN 
--   R_CONTENIDO_ACTOR rca ON c.id = rca.id_contenido
-- JOIN 
--   PERSONA p ON rca.id_actor = p.id
-- JOIN
--   ACTOR a on p.id = a.id_persona
-- JOIN 
--   CIUDAD ciudad_origen ON a.id_ciudad_origen = ciudad_origen.id
-- JOIN 
--   PAIS pais_origen ON ciudad_origen.id_pais = pais_origen.id
-- JOIN 
--   CIUDAD ciudad_residencia ON p.id_ciudad_residencia = ciudad_residencia.id
-- JOIN 
--   PAIS pais_residencia ON ciudad_residencia.id_pais = pais_residencia.id
-- LEFT JOIN 
--   VISUALIZACION v ON c.id = v.id_contenido
-- WHERE 
--   c.titulo = 'AVENGERS: ENDGAME'
-- GROUP BY 
--   p.nombre, pais_origen.nombre, pais_residencia.nombre, rca.rol, e.fecha;


-- -- *****************************************************************
-- SELECT 
--   p.nombre AS Nombre_Usuario,
--   s.fecha_adquisicion AS Fecha_Suscripcion_Antigua,
--   paq.tipo AS Paquete_Asociado
-- FROM 
--   PERSONA p
-- JOIN 
--   SUSCRIPCION s ON p.id = s.id_cuenta
-- JOIN 
--   PAQUETE paq ON s.id_paquete = paq.id
-- GROUP BY 
--   p.id
-- ORDER BY 
--   COUNT(*) DESC
-- LIMIT 1;

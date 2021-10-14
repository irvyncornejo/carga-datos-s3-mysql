-- `tickets_pp.json` `tickets_2020_api.json` `tickets_2020-01.csv`
-- 1
-- El objetivo es validar las distintas rutas y contar la cantidad de las mismas, sin que se repitan
SELECT COUNT(DISTINCT(ruta)) FROM _TEST.`tickets_pp.json`;

-- 2
-- Para poder contar la catidad de tickets únicamente realicé la operación en la columna de ticket
SELECT COUNT(ticket) FROM _TEST.`tickets_pp.json`;

-- 3 Conté los tickets de los viajes que tuvieran el atributo el valor False en el atributo realizado.
SELECT COUNT(ticket) viajes_no_realizados FROM _TEST.`tickets_2020-01.csv` 
	WHERE realizado = 0;

-- 4 Validé los distintes estados para poder comprobar que son homogéneos
--  y conté los tickets de los viajes que tienen 'REAGENDADO' en el atributo estado
SELECT distinct(estado) viajes_reagendados FROM _TEST.`tickets_pp.json`;
SELECT COUNT(ticket) viajes_reagendados FROM _TEST.`tickets_pp.json` 
	WHERE estado='REAGENDADO';

-- 5 conté los tickets de los viajes que tienen 'CANCELADOS' en el atributo estado
SELECT COUNT(ticket) viajes_cancelados 
	FROM _TEST.`tickets_2020-01.csv` 
    WHERE estado='CANCELADO';

-- 6 Apliqué la función de promedio en la columna de ocupación y el valor lo 
-- multipliqué por 100
SELECT AVG(ocupacion)*100 FROM _TEST.`tickets_pp.json`;

-- 7 Filtrar los viajes que tengan 'True' en el atributo realizado,
-- agruparlos por ruta para contarlos y ordenarlos por la cantidad de viajes realizados
SELECT RUTA, COUNT(TICKET) VIAJES_REALIZADOS 
	FROM _TEST.`tickets_2020-01.csv`
    WHERE realizado=True 
    GROUP BY RUTA
    ORDER BY VIAJES_REALIZADOS
    LIMIT 2;

-- 8 Primero obtuve el valor de la ruta(s) con más viajes realizados y los ordené de manera
-- descendente y limite a dos; ya que en una de las tables no solo existe un valor alto sino dos. 
-- Ya que se se tiene el valor de la ruta(s), aplique un inner para poder traer unicamente el valor
-- que coincide y filtrar por estado, agrupar y contar. 
SELECT V.RUTA, COUNT(V.TICKET) VIAJES_REAGENDADOS 
	FROM _TEST.`tickets_pp.json` AS V
	INNER JOIN (SELECT RUTA
		FROM _TEST.`tickets_pp.json`
		WHERE REALIZADO=True 
        GROUP BY RUTA
		ORDER BY COUNT(TICKET) DESC
		LIMIT 2) AS TABLA_2 ON V.RUTA = TABLA_2.RUTA 
    WHERE V.ESTADO = 'REAGENDADO'
    GROUP BY V.RUTA;

-- 9 Obtengo el valor de los viajes cancelados filtrando por atributo 'ESTADO' = 'CANCELADO'
-- agrupo por ruta, se cuentan los tickets y ordenamos de manera descendente
SELECT RUTA, COUNT(TICKET)
	FROM _TEST.`tickets_pp.json`
    WHERE ESTADO='CANCELADO' 
    GROUP BY RUTA
    ORDER BY COUNT(TICKET) DESC
    LIMIT 3;
    
-- 10 Agrupo por rutas y obtengo el valor promedio de cada una, 
-- las ordeno para obtener el valor mayor y lo multiplico por 100 
SELECT RUTA, AVG(ocupacion)*100 PROMEDIO
	FROM _TEST.`tickets_2020-01.csv`
	GROUP BY RUTA
    ORDER BY PROMEDIO DESC;


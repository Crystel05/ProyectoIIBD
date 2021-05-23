CREATE OR REPLACE FUNCTION public.numeroAlquileresXduracion(
	dura smallint)
    RETURNS TABLE (duracion smallint, 
				  cantidadAlquileres bigint,
				  monto numeric)
    LANGUAGE 'plpgsql'
	
AS $BODY$
BEGIN
	RETURN QUERY 
	SELECT duracion, sum(unidadesvendidas), sum(montovendido)
	FROM ventas 
	INNER JOIN duracion ON ventas.duracionid = duracion.duracionid
	WHERE duracion.duracion = dura
	GROUP BY GROUPING SETS (duracion.duracion);
END;
$BODY$;
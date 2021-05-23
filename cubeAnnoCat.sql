CREATE OR REPLACE FUNCTION public.cubeAnnoCat(

    RETURNS TABLE (categNom varchar,
				   anno varchar
				  cantidadAlquileres bigint
				  monto bigint)
    LANGUAGE 'plpgsql'
	
AS $BODY$
BEGIN
	RETURN QUERY 
	SELECT categoria, anno, sum(unidadesvendidas), sum(montovendido)
	FROM ventas 
	INNER JOIN pelicula ON ventas.peliculaid = pelicula.peliculaid
	INNER JOIN fecha ON ventas.fechaid = fecha.fechaid 
	GROUP BY CUBE(fecha.anno, pelicula.categoria);
END;
$BODY$;
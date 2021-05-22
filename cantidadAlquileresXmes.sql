--DROP FUNCTION numeroAlquileres(smallint);

CREATE OR REPLACE FUNCTION public.numeroAlquileres(
	mesBuscar smallint)
    RETURNS TABLE (categNom varchar, 
				  cantidadAlquileres bigint)
    LANGUAGE 'plpgsql'
	SECURITY DEFINER 
    COST 100
    VOLATILE PARALLEL UNSAFE
	
AS $BODY$
BEGIN
	RETURN QUERY 
	SELECT categoria, sum(unidadesvendidas)
	FROM ventas 
	INNER JOIN pelicula ON ventas.peliculaid = pelicula.peliculaid
	INNER JOIN fecha ON ventas.fechaid = fecha.fechaid AND fecha.mes = mesBuscar
	GROUP BY GROUPING SETS (pelicula.categoria);
END;
$BODY$;

--SELECT * FROM numeroAlquileres(6::smallint) --solo sirven 6, 7 y 8


--DROP FUNCTION montoCobradoXalquileres()
--SELECT * FROM montoCobradoXalquileres()

CREATE OR REPLACE FUNCTION public.montoCobradoXalquileres(
	)
    RETURNS TABLE (montoCobrado numeric, 
				  mesM smallint, 
				  annoM smallint)
    LANGUAGE 'plpgsql'
	SECURITY DEFINER
    COST 100
    VOLATILE PARALLEL UNSAFE
	
AS $BODY$
BEGIN
	
	RETURN QUERY 
	SELECT sum(montovendido), mes, anno
	FROM ventas
	INNER JOIN fecha ON ventas.fechaid = fecha.fechaid
	GROUP BY ROLLUP(fecha.anno, fecha.mes);
	
END;
$BODY$;



	
	
	
	
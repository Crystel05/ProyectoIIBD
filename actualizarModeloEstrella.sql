CREATE OR REPLACE FUNCTION public.actualizarModeloEstrella()
    RETURNS void
    LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	
BEGIN
	
	DELETE FROM tiempo;
	DELETE FROM lugar;
	DELETE FROM item;
	DELETE FROM sucursal;
	DELETE FROM ventas;
	
	TRUNCATE ONLY tiempo,
	lugar,
	item,
	sucursal,
	ventas
	RESTART IDENTITY;
			

END;
$BODY$;
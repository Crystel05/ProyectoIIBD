CREATE OR REPLACE FUNCTION public.registrarAlquiler(
	peliculaNom varchar, 
	clienteNom varchar, 
	clienteApl varchar,
	usernameEmp varchar, 
	direccionTienda varchar
	)
    RETURNS integer
    LANGUAGE 'plpgsql'
	SECURITY DEFINER
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE 
	inventarioId int; 
	tiendaId int;
	peliculaId int;
	clienteId int; 
	empleadoId int;
BEGIN

	--tienda id
	
	tiendaId := (SELECT DISTINCT store_id FROM store 
				 INNER JOIN address ON store.address_id = address.address_id 
				 WHERE address.address = direccionTienda);
	
	--pelicula id
	
	peliculaId := (SELECT film_id FROM film WHERE film.title = peliculaNom);
	
	--inventario id
	
	inventarioId := (SELECT inventory.inventory_id FROM inventory 
					 WHERE film_id = peliculaId AND store_id = tiendaId LIMIT 1);
	
	--cliente id
	
	clienteId := (SELECT customer_id FROM customer 
				  WHERE first_name = clienteNom AND last_name = clienteApl);
	
	--empleado id
	
	empleadoId := (SELECT staff_id FROM staff 
				   WHERE username = usernameEmp);
	
	INSERT INTO public.rental(
	rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
	VALUES ((SELECT NOW()), inventarioId, clienteId, null, empleadoId, (SELECT NOW()));
	
	RETURN 1;
END;
$BODY$;

ALTER FUNCTION registrarAlquiler(varchar, varchar, varchar, varchar, varchar)
OWNER TO "VIDEO"





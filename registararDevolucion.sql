CREATE OR REPLACE FUNCTION public.registrarDevolucion(
	nombrepelicula varchar,
	fechaAlquiler timestamp,
	nombreCliente varchar,
	apellidoCliente varchar)
    RETURNS void
    LANGUAGE 'plpgsql'
AS $BODY$
DECLARE

	alquilerID int;

BEGIN

	alquilerID := (SELECT rental_id FROM rental
				  INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
				  INNER JOIN film ON inventory.film_id = film.film_id 
				  INNER JOIN customer ON rental.customer_id = customer.customer_id
				  WHERE customer.first_name = nombreCliente 
				  AND film.title = nombrepelicula
				  AND customer.last_name = apellidoCliente
				  AND rental.rental_date = fechaAlquiler);
			
	UPDATE rental SET return_date = NOW() WHERE rental_id = alquilerID;

END;
$BODY$;
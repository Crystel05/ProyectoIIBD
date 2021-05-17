CREATE OR REPLACE FUNCTION public.actualizarModeloEstrella()
    RETURNS void
    LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	
BEGIN
	
	DELETE FROM ventas;
	DELETE FROM fecha;
	DELETE FROM lugar;
	DELETE FROM duracion;
	DELETE FROM pelicula;
	DELETE FROM lenguaje;
	
	TRUNCATE ONLY 
	fecha,
	lugar,
	duracion,
	pelicula,
	lenguaje,
	ventas
	RESTART IDENTITY;
		  
	INSERT INTO fecha(anno, mes, dia, partedia)
	SELECT DISTINCT
	EXTRACT(YEAR FROM rental.rental_date),
	EXTRACT(MONTH FROM rental.rental_date),
	EXTRACT(DAY FROM rental.rental_date),
	(cast(rental.rental_date as time))
	FROM rental;
		
	INSERT INTO pelicula(peliculaid, filme, categoria)
	SELECT film.film_id, film.title, category.name
	FROM film_category
	INNER JOIN category ON film_category.category_id = category.category_id
	INNER JOIN film ON film_category.film_id = film.film_id
	ORDER BY film.film_id;
	
	INSERT INTO lugar(lugarid, pais, ciudad, tienda)
	SELECT address.address_id, country.country, city.city, address.district
	FROM country
	INNER JOIN city ON city.country_id = country.country_id
	INNER JOIN address ON address.city_id = city.city_id
	ORDER BY address.address_id;
	
	INSERT INTO lenguaje(lenguajeid, lenguaje)
	SELECT language_id, name
	FROM language
	ORDER BY language_id;
	
	INSERT INTO duracion(duracion)
	SELECT DISTINCT
	return_date::DATE - rental_date::DATE
	FROM rental WHERE return_date::DATE - rental_date::DATE
	IS NOT NULL;
	
	CREATE TEMPORARY TABLE ventasTemp(
    fechaid integer,
	peliculaid integer, 
   	lenguajeid integer, 
   	lugarid integer, 
   	duracionid integer, 
   	unidadvendida integer, 
   	montoitem numeric(19,4));
	
	INSERT INTO ventasTemp(
   	fechaid, 
   	peliculaid, 
   	lenguajeid, 
   	lugarid, 
   	duracionid, 
   	unidadvendida, 
   	montoitem)
   	SELECT 
	fecha.fechaid,
	film.film_id,
	language.language_id,
	address.address_id,
	duracion.duracionid,
	1,
	payment.amount
	FROM rental
	INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
	INNER JOIN film ON film.film_id = inventory.film_id 
	INNER JOIN language ON language.language_id = film.language_id
	INNER JOIN payment ON payment.rental_id = rental.rental_id
	INNER JOIN store ON store.store_id = inventory.store_id
	INNER JOIN address ON address.address_id = store.address_id
	INNER JOIN duracion ON (rental.return_date::DATE - rental.rental_date::DATE) = duracion.duracion
	INNER JOIN fecha ON fecha.anno = EXTRACT(YEAR FROM rental.rental_date) WHERE
	fecha.mes = EXTRACT(MONTH FROM rental.rental_date)AND
	fecha.dia = EXTRACT(DAY FROM rental.rental_date) AND
	fecha.partedia = (cast(rental.rental_date as time));
	
	
    INSERT INTO ventas(
   	peliculaid, 
   	lenguajeid, 
   	lugarid,
	fechaid,
   	duracionid, 
   	unidadesvendidas, 
   	montovendido)
   	SELECT 
	peliculaid, 
   	lenguajeid, 
   	lugarid,
	fechaid,
   	duracionid,
	SUM(unidadvendida),
	SUM(montoitem)
	FROM ventasTemp
	GROUP BY (peliculaid, 
	lenguajeid, lugarid, 
	fechaid, duracionid);
   	  
	DROP TABLE ventasTemp;
END;
$BODY$;






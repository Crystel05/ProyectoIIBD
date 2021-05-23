CREATE OR REPLACE FUNCTION public.insertarInventario(
	titulo varchar,
	descripcion varchar,
	anno integer,
	idioma varchar,
	longitud integer,
	costoRemp numeric,
	rate numeric,
	rentDura integer,
	rating varchar,
	categoria varchar,
	tienda varchar)
	
    RETURNS void
    LANGUAGE 'plpgsql'

AS $BODY$
DECLARE

	peliculaEnStock integer;
	leng integer;
	pelId integer;
	categId integer;
	tiendaId integer;

BEGIN

	SELECT COUNT(film.film_id) INTO peliculaEnStock
	FROM film
	INNER JOIN language ON film.language_id = language.language_id
	INNER JOIN film_category ON film.film_id = film_category.film_id
	INNER JOIN category ON film_category.category_id = category.category_id
	WHERE film.title = titulo AND 
	film.release_year = anno AND
	language.name = idioma AND
	category.name = categoria;
	
	IF peliculaEnStock = 0 THEN
	
		SELECT language_id INTO leng FROM language WHERE name = idioma;
	
		INSERT INTO film(
		title,
		description,
		release_year,
		language_id,
		rental_duration,
		rental_rate,
		length,
		replacement_cost,
		rating,
		last_update)
		VALUES(
		titulo,
		descripcion,
		anno,
		leng,
		rentDura,
		rate,
		longitud,
		costoRemp,
		rating,
		NOW());
		
	END IF;
	
	SELECT film.film_id INTO pelId
	FROM film
	INNER JOIN language ON film.language_id = language.language_id
	WHERE film.title = titulo AND 
	film.release_year = anno AND
	language.name = idioma;
	
	IF peliculaEnStock = 0 THEN
	
		SELECT category_id INTO categId FROM category WHERE name = categoria;
		
		INSERT INTO public.film_category(film_id, category_id, last_update)
		VALUES(pelId, categId, NOW());
	
	END IF;
	
	SELECT store_id INTO tiendaId FROM store
	INNER JOIN address on store.address_id = address.address_id
	WHERE address.address = tienda;

	
	INSERT INTO inventory(film_id, store_id, last_update)
	VALUES(pelId, tiendaId, NOW());
	
END;
$BODY$;


-- FUNCTION: public.buscarpelicula(character varying)

-- DROP FUNCTION public.buscarpelicula(character varying);

CREATE OR REPLACE FUNCTION public.buscarpelicula(
	nombrepelicula character varying)
    RETURNS TABLE(titulo character varying,
				  descripcion character varying,
				  anno integer,
				  longitud smallint,
				  lenguaje character varying,
				  categoria character varying) 
    LANGUAGE 'plpgsql'

AS $BODY$
DECLARE
BEGIN

	RETURN QUERY
	SELECT film.title,
	film.description,
	film.release_year,
	film.length,
	language.name,
	category.name
	FROM film
	INNER JOIN language ON language.language_id = film.language_id
	INNER JOIN film_category ON film_category.film_id = film.film_id
	INNER JOIN category ON category.category_id = film_category.category_id
	WHERE film.title = nombrePelicula;

END;
$BODY$;

ALTER FUNCTION public.buscarpelicula(character varying)
    OWNER TO postgres;

--Crear roles

CREATE ROLE "ADMIN" LOGIN PASSWORD 'admin';
CREATE ROLE "EMP" LOGIN PASSWORD 'emp' INHERIT;

--Crear usurios

CREATE USER "VIDEO" PASSWORD 'video' NOLOGIN;
CREATE USER empleado1 LOGIN PASSWORD 'emp1' IN ROLE "EMP"; 
CREATE USER administrador1 LOGIN PASSWORD 'admin1' IN ROLE "ADMIN";

--Dar permisos

--VIDEO
GRANT ALL PRIVILEGES 
ON ALL TABLES IN SCHEMA public
TO "VIDEO";

GRANT ALL PRIVILEGES 
ON ALL FUNCTIONS IN SCHEMA public
TO "VIDEO";

GRANT CONNECT 
ON DATABASE "proyectoIIBD1" 
TO "VIDEO";

--ADMIN

GRANT CONNECT 
ON DATABASE "proyectoIIBD1" 
TO "ADMIN";

--EMP 

GRANT CONNECT 
ON DATABASE "proyectoIIBD1"
TO "EMP";

--Dueños de las tablas

ALTER TABLE public.actor
    OWNER TO "VIDEO";

ALTER TABLE public.address
    OWNER TO "VIDEO";

ALTER TABLE public.category
    OWNER TO "VIDEO";

ALTER TABLE public.city
    OWNER TO "VIDEO";

ALTER TABLE public.country
    OWNER TO "VIDEO";

ALTER TABLE public.customer
    OWNER TO "VIDEO";

ALTER TABLE public.film
    OWNER TO "VIDEO";

ALTER TABLE public.film_actor
    OWNER TO "VIDEO";

ALTER TABLE public.inventory
    OWNER TO "VIDEO";

ALTER TABLE public.language
    OWNER TO "VIDEO";

ALTER TABLE public.payment
    OWNER TO "VIDEO";

ALTER TABLE public.rental
    OWNER TO "VIDEO";

ALTER TABLE public.staff 
    OWNER TO "VIDEO";

ALTER TABLE public.store
    OWNER TO "VIDEO";

ALTER TABLE public.film_category
    OWNER TO "VIDEO";
	
-- Ejemplo de como son las funciones

/*CREATE OR REPLACE FUNCTION public.prueba(
	)
    RETURNS integer
    LANGUAGE 'plpgsql'
	SECURITY DEFINER --****
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE nom varchar;
BEGIN
	nom := (SELECT first_name FROM actor WHERE actor_id = 1);
	RETURN 1;
END;
$BODY$;
*/

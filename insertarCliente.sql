
CREATE OR REPLACE FUNCTION public.insertarCliente( 
	nombre varchar, --DC
	apellido varchar, --DC
	correo varchar, --DC
	direccionCliente varchar, --dir **
	direccionCliente2 varchar,  --dir **
	distrito varchar, --dir **
	ciudad varchar, --bca **
	paisNom varchar,--bca **
	codigoPostal varchar, --dir **
	direccionTienda varchar, --DT **
	telefono varchar --dir **
		
)
    RETURNS integer
    LANGUAGE 'plpgsql'
	SECURITY DEFINER 
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

DECLARE 
	tiendaId int;	
	direccionId int;
	ciudadId int;
	paisId int;

BEGIN

--Conseguir tienda id
	
	tiendaId :=(SELECT address_id FROM address WHERE address.address = direccionTienda);
	
--Conseguir direccion id
	
	IF (SELECT address.address_id FROM address WHERE address.address = direccionCliente) IS NOT NULL 
	THEN 
	
		direccionId := (SELECT address.address_id FROM address WHERE address.address = direccionCliente);
		
	ELSE
		IF (SELECT city_id FROM city WHERE city.city = ciudad) IS NOT NULL 
		THEN 

			ciudadId := (SELECT city_id FROM city WHERE city.city = ciudad);

		ELSE
			IF (SELECT country_id FROM country WHERE country.country = paisNom) IS NOT NULL 
			THEN 

				paisId := (SELECT country_id FROM country WHERE country.country = paisNom);

			ELSE

				INSERT INTO public.country(
				country, last_update)
				VALUES (paisNom, (SELECT NOW()));

				paisId := (SELECT country_id FROM country WHERE country.country = paisNom);

			END IF; 

			INSERT INTO public.city(
			city, country_id, last_update)
			VALUES (ciudad, paisId, (SELECT NOW())); 

			ciudadId := (SELECT city_id FROM city WHERE city.city = ciudad);
		END IF; 

		INSERT INTO public.address(
		address, address2, district, city_id, postal_code, phone, last_update)
		VALUES (direccionCliente, direccionCliente2, distrito, ciudadId, codigoPostal, telefono, (SELECT now()));


		direccionId := (SELECT address.address_id FROM address WHERE address.address = direccionCliente);
	END IF; 
	
	INSERT INTO public.customer(
	store_id, first_name, last_name, email, address_id, activebool, create_date, last_update, active)
	VALUES (tiendaId, nombre, apellido, correo, direccionId, TRUE, (SELECT NOW()), (SELECT NOW()), 1);
	
	RETURN 1;
	
END;
$BODY$;

ALTER TABLE actor
ALTER COLUMN actor_id DROP DEFAULT; 
ALTER TABLE actor
ALTER COLUMN actor_id ADD GENERATED BY DEFAULT AS IDENTITY;

ALTER TABLE address
ALTER COLUMN address_id DROP DEFAULT; 
ALTER TABLE address
ALTER COLUMN address_id ADD GENERATED BY DEFAULT AS IDENTITY;

ALTER TABLE category
ALTER COLUMN category_id DROP DEFAULT; 
ALTER TABLE category
ALTER COLUMN category_id ADD GENERATED BY DEFAULT AS IDENTITY;

ALTER TABLE city
ALTER COLUMN city_id DROP DEFAULT; 
ALTER TABLE city
ALTER COLUMN city_id ADD GENERATED BY DEFAULT AS IDENTITY;

ALTER TABLE country
ALTER COLUMN country_id DROP DEFAULT; 
ALTER TABLE country
ALTER COLUMN country_id ADD GENERATED BY DEFAULT AS IDENTITY;

ALTER TABLE customer
ALTER COLUMN customer_id DROP DEFAULT; 
ALTER TABLE customer
ALTER COLUMN customer_id ADD GENERATED BY DEFAULT AS IDENTITY;

ALTER TABLE film
ALTER COLUMN film_id DROP DEFAULT; 
ALTER TABLE film
ALTER COLUMN film_id ADD GENERATED BY DEFAULT AS IDENTITY;
ALTER TABLE film
ALTER COLUMN release_year SET DATA TYPE INT;
--Drop vista film_list y nicer_but_slower_film_list
ALTER TABLE film
DROP COLUMN rating; 
ALTER TABLE film
ADD COLUMN rating VARCHAR COLLATE pg_catalog."default" DEFAULT 'G';
--Volver a crear las listas que se borraron

ALTER TABLE inventory
ALTER COLUMN inventory_id DROP DEFAULT; 
ALTER TABLE inventory
ALTER COLUMN inventory_id ADD GENERATED BY DEFAULT AS IDENTITY;

ALTER TABLE public.language
ALTER COLUMN language_id DROP DEFAULT; 
ALTER TABLE public.language
ALTER COLUMN language_id ADD GENERATED BY DEFAULT AS IDENTITY;

ALTER TABLE payment
ALTER COLUMN payment_id DROP DEFAULT; 
ALTER TABLE payment
ALTER COLUMN payment_id ADD GENERATED BY DEFAULT AS IDENTITY;

ALTER TABLE rental
ALTER COLUMN rental_id DROP DEFAULT; 
ALTER TABLE rental
ALTER COLUMN rental_id ADD GENERATED BY DEFAULT AS IDENTITY;

ALTER TABLE staff
ALTER COLUMN staff_id DROP DEFAULT; 
ALTER TABLE staff
ALTER COLUMN staff_id ADD GENERATED BY DEFAULT AS IDENTITY;

ALTER TABLE store
ALTER COLUMN store_id DROP DEFAULT; 
ALTER TABLE store
ALTER COLUMN store_id ADD GENERATED BY DEFAULT AS IDENTITY;


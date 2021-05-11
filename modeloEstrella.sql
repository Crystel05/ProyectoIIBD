CREATE TABLE Tiempo 
(
	tiempoID integer GENERATED ALWAYS AS IDENTITY NOT NULL, 
	anno smallint NOT NULL, 
	mes smallint NOT NULL, 
	dia smallint NOT NULL, 
	parteDia varchar NOT NULL,
	CONSTRAINT tiempo_pkey PRIMARY KEY(tiempoID)
);

CREATE TABLE Sucursal
(
	sucursalID integer GENERATED ALWAYS AS IDENTITY NOT NULL, 
	nombreSuc varchar NOT NULL,
	CONSTRAINT sucursal_pkey PRIMARY KEY(sucursalID)
);

CREATE TABLE Item
(
	itemID integer GENERATED ALWAYS AS IDENTITY NOT NULL,
	nombre varchar NOT NULL,
	CONSTRAINT item_pkey PRIMARY KEY(itemID)
);

CREATE TABLE Lugar
(
	lugarID integer GENERATED ALWAYS AS IDENTITY NOT NULL, 
	pais varchar NOT NULL, 
	provincia varchar NOT NULL, 
	ciudad varchar NOT NULL,
	CONSTRAINT lugar_pkey PRIMARY KEY(lugarID)
);

CREATE TABLE Ventas
(
	tiempoID integer GENERATED ALWAYS AS IDENTITY NOT NULL, 
	itemID integer NOT NULL, 
	sucursalID integer NOT NULL, 
	lugarID integer NOT NULL, 
	unidadesVendidas integer NOT NULL, 
	montoVendido numeric(19,4),
	CONSTRAINT ventas_tiempo_fkey FOREIGN KEY(tiempoID)
		REFERENCES public.Tiempo(tiempoID),
	CONSTRAINT ventas_item_fkey FOREIGN KEY(itemID)
		REFERENCES public.Item(itemID),
	CONSTRAINT ventas_sucursal_fkey FOREIGN KEY(sucursalID)
		REFERENCES public.Sucursal(sucursalID),
	CONSTRAINT ventas_lugar_fkey FOREIGN KEY(lugarID)
		REFERENCES public.Lugar(lugarID)
);
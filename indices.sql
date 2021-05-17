CREATE INDEX idx_pelicula_categoria
ON pelicula(categoria);

CREATE INDEX idx_fecha_mes
ON fecha(mes);

CREATE INDEX idx_duracion_duracion
ON duracion(duracion);

CREATE INDEX idx_fecha_anno
ON fecha(anno);

CREATE INDEX idx_ventas_unidades
ON ventas(unidadesvendidas);

CREATE INDEX idx_ventas_monto
ON ventas(montovendido);
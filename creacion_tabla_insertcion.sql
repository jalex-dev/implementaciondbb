drop table if exists categorias;
create table categorias(
	codigo_cat serial not null,
	nombre varchar(100) not null,
	categoria_padre int ,
	constraint categorias_pk primary key (codigo_cat),
	constraint categorias_fk foreign key (categoria_padre)
	references categorias(codigo_cat)	
);
INSERT INTO public.categorias(nombre, categoria_padre)
	VALUES ('Materia Prima', null);
INSERT INTO public.categorias(nombre, categoria_padre)
	VALUES ('Proteina', 1);
INSERT INTO public.categorias(nombre, categoria_padre)
	VALUES ('Salsas', 1);
	INSERT INTO public.categorias(nombre, categoria_padre)
	VALUES ('Punto de venta', null);
INSERT INTO public.categorias(nombre, categoria_padre)
	VALUES ('Bebidas', 4);
INSERT INTO public.categorias(nombre, categoria_padre)
	VALUES ('Con alcohol', 5);
INSERT INTO public.categorias(nombre, categoria_padre)
	VALUES ('Sin alcohol', 5);
	
select *from categorias;

drop table if exists categorias_unidad_medida;
create table categorias_unidad_medida(
	codigo_udm char(1) not null,
	nombre varchar(100) not null,
	constraint categorias_udidad_medida_pk primary key (codigo_udm)
);

INSERT INTO public.categorias_unidad_medida(codigo_udm, nombre)
	VALUES ('U','Unidades');	
INSERT INTO public.categorias_unidad_medida(codigo_udm, nombre)
VALUES ('V','Volumen');
INSERT INTO public.categorias_unidad_medida(codigo_udm, nombre)
VALUES ('P','Pesos');

Select *from categorias_unidad_medida;

drop table if exists unidad_medida;
create table unidad_medida(
	codigo_udm varchar(2) not null,
	descripcion varchar(100) not null,
	codigo_cat_udm char(1) not null,

	constraint udidad_medida_pk primary key (codigo_udm),
	constraint categorias_udidad_medida_fk foreign key (codigo_cat_udm)
	references categorias_unidad_medida(codigo_udm)
);
INSERT INTO public.unidad_medida(codigo_udm, descripcion, codigo_cat_udm)
	VALUES ('ml', 'mililitros', 'V');
	
INSERT INTO public.unidad_medida(codigo_udm, descripcion, codigo_cat_udm)
	VALUES ('l', 'litros', 'V');
INSERT INTO public.unidad_medida(codigo_udm, descripcion, codigo_cat_udm)
	VALUES ('u', 'udidad', 'U');
INSERT INTO public.unidad_medida(codigo_udm, descripcion, codigo_cat_udm)
	VALUES ('d', 'docena', 'U');
INSERT INTO public.unidad_medida(codigo_udm, descripcion, codigo_cat_udm)
	VALUES ('g', 'gramos', 'P');
INSERT INTO public.unidad_medida(codigo_udm, descripcion, codigo_cat_udm)
	VALUES ('kg', 'kilogramos', 'P');
INSERT INTO public.unidad_medida(codigo_udm, descripcion, codigo_cat_udm)
	VALUES ('lb', 'libras', 'P');
	
select *from unidad_medida;
	
drop table if exists productos;
create table productos(
	codigo_pro serial not null,
	nombre varchar(100) not null,
	codigo_udm char(2) not null,
	precio_venta money not null,
	coste money not null,
	tiene_iva boolean not null,
	codigo_cat int not null,
	stock int not null,

	constraint productos_pk primary key (codigo_pro),
	constraint udidad_medida_fk foreign key (codigo_udm)
	references unidad_medida(codigo_udm),
	constraint categorias_fk foreign key (codigo_cat)
	references categorias(codigo_cat)	
);

INSERT INTO public.productos(
	 nombre, codigo_udm, precio_venta, coste, tiene_iva, codigo_cat, stock)
	VALUES ( 'Coca Cola pequeña','u', 0.5804, 0.3729, 'true',7 , 100);
INSERT INTO public.productos(
	 nombre, codigo_udm, precio_venta, coste, tiene_iva, codigo_cat, stock)
	VALUES ( 'salsa de Tomate','kg', 0.95, 0.8736, 'true',3 , 50);
INSERT INTO public.productos(
	 nombre, codigo_udm, precio_venta, coste, tiene_iva, codigo_cat, stock)
	VALUES ( 'Moztaza','kg', 0.95, 0.89, 'true',3 , 100);
INSERT INTO public.productos(
	 nombre, codigo_udm, precio_venta, coste, tiene_iva, codigo_cat, stock)
	VALUES ( 'Fuze tea','u', 0.8, 0.7, 'true',7 , 50);
	
select *from productos;

drop table if exists tipo_documento;
create table tipo_documento(
	codigo_td char(1) not null,
	descripcion varchar(100) not null,
	constraint tipo_documento_pk primary key (codigo_td)
);

INSERT INTO public.tipo_documento(codigo_td, descripcion)
	VALUES ('C', 'CEDULA');
INSERT INTO public.tipo_documento(codigo_td, descripcion)
	VALUES ('R', 'RUC');
	
drop table if exists proveedores;
create table proveedores(
	identificador varchar(13) not null,
	codigo_td char(1) not null,
	nombre varchar(100) not null,
	telefono varchar(10) not null,
	correo varchar(100) ,
	direccion varchar(100),

	constraint proveedores_pk primary key (identificador),
	constraint codigo_td_fk foreign key (codigo_td)
	references tipo_documento(codigo_td)
		
);
INSERT INTO public.proveedores(
	identificador, codigo_td, nombre, telefono, correo, direccion)
	VALUES ('1792285747', 'C', 'Santiago Mosquera', '0992920306', 'zantycb89@gmail.com', 'Cumbayork');
	
INSERT INTO public.proveedores(
	identificador, codigo_td, nombre, telefono, correo, direccion)
	VALUES ('1792285747001', 'R', 'Snacks SA', '0992920398', 'snaks@gmail.com', 'La tola');
	
select *from proveedores;

drop table if exists estado_pedido;
create table estado_pedido(
	codigo_ep char(1) not null,
	descripcion varchar(100) not null,
	constraint estado_pedido_pk primary key (codigo_ep)
);
INSERT INTO public.estado_pedido(codigo_ep, descripcion)
	VALUES ('S', 'Solicitado');
INSERT INTO public.estado_pedido(codigo_ep, descripcion)
	VALUES ('R', 'Recibido');
	

drop table if exists cabezera_pedido;
create table cabezera_pedido(
	numero serial not null,
	identificador varchar(13) not null,
	fecha timestamp not null, 
	codigo_ep char(1) not null,
		 
	constraint cabezera_pedido_pk primary key (numero),
	constraint codigo_ep_fk foreign key (codigo_ep)
	references estado_pedido(codigo_ep),
	constraint identificador_fk foreign key (identificador)
	references proveedores(identificador)
);

INSERT INTO public.cabezera_pedido(identificador, fecha, codigo_ep)
	VALUES ( '1792285747', '30/11/2023', 'R');
INSERT INTO public.cabezera_pedido(identificador, fecha, codigo_ep)
	VALUES ( '1792285747', '20/11/2023', 'S');
	
drop table if exists detalle_pedido;
create table detalle_pedido(
	codigo_dp serial not null,
	numero int not null,
	codigo_pro int not null,
	cantidad_solicitada int not null,
	subtotal money not null, 
	cantidad_recibido int not null,
		 
	constraint detalle_pedido_pk primary key (codigo_dp),
	constraint numero_fk foreign key (numero)
	references cabezera_pedido(numero),
	constraint codigo_pro_fk foreign key (codigo_pro)
	references productos(codigo_pro)
);
INSERT INTO public.detalle_pedido(numero, codigo_pro, cantidad_solicitada, subtotal, cantidad_recibido)
	VALUES ( 1, 1, 100, 37.29, 100);
INSERT INTO public.detalle_pedido(numero, codigo_pro, cantidad_solicitada, subtotal, cantidad_recibido)
	VALUES ( 1, 4, 50, 11.8, 50);
INSERT INTO public.detalle_pedido(numero, codigo_pro, cantidad_solicitada, subtotal, cantidad_recibido)
	VALUES ( 2, 1, 10, 3.73, 0);

drop table if exists historial_stock;
create table historial_stock(
	codigo_hs serial not null,
	fecha timestamp not null, 
	referencia varchar(100) not null,
	codigo_pro int not null,
	cantidad int not null,
		 
	constraint historial_stock_pk primary key (codigo_hs),
	constraint codigo_pro_fk foreign key (codigo_pro)
	references productos(codigo_pro)
);
	
INSERT INTO public.historial_stock( fecha, referencia, codigo_pro, cantidad)
	VALUES ( '20/11/2023 12:00', 'Pedido 1', 1, 100);
INSERT INTO public.historial_stock( fecha, referencia, codigo_pro, cantidad)
	VALUES ( '20/11/2023 12:00', 'Pedido 1', 4, 50);
INSERT INTO public.historial_stock( fecha, referencia, codigo_pro, cantidad)
	VALUES ( '20/11/2023 12:00', 'Pedido 1', 1, 10);

drop table if exists cabezera_ventas;
create table cabezera_ventas(
	codigo_cv serial not null,
	fecha timestamp not null, 
	total_sin_iva money not null,
	iva decimal not null,
	total money not null,
		 
	constraint cabezera_ventas_pk primary key (codigo_cv)
	
);

INSERT INTO public.cabezera_ventas(fecha, total_sin_iva, iva, total)
	VALUES ( '20/11/2023 12:00', 3.26, 0.39, 3.65);
	
drop table if exists detalles_ventas;
create table detalles_ventas(
	codigo_dv serial not null,
	codigo_cv int not null,
	codigo_pro int not null,
	cantidad int not null,
	precio_venta money not null, 
	subtotal money not null,
	subtotal_con_iva money not null,

		 
	constraint detalle_venta_spk primary key (codigo_dv),
	constraint codigo_cv_fk foreign key (codigo_cv)
	references cabezera_ventas(codigo_cv),
	constraint codigo_pro_fk foreign key (codigo_pro)
	references productos(codigo_pro)
);

INSERT INTO public.detalles_ventas(codigo_cv, codigo_pro, cantidad, precio_venta, subtotal, subtotal_con_iva)
	VALUES ( 1, 1, 5, 0.58, 2.9, 3.25);
	
INSERT INTO public.detalles_ventas(codigo_cv, codigo_pro, cantidad, precio_venta, subtotal, subtotal_con_iva)
	VALUES ( 1, 4, 1, 0.36, 0.36, 0.4);
create database proyecto_grupo_#3

use proyecto_grupo_#3


create table usuario
(
usuario_ID int identity (1,1) primary key,
nombre_de_usuario varchar (30),
contrasena varchar (25),
emali varchar (30),
numero_de_grupo int
)

alter table usuario
add apellido varchar (35)

alter table usuario
add nombre varchar (35)

select * from usuario

select * from compensacion
/* procedimiento almacenado de cada valor */
create proc lista_usuario
as
select * from usuario order by nombre_de_usuario asc
go

exec lista_usuario

/* fin de insercion */

/*--------------------------------------------------------------------- */ 

create table distribucion_y_almacenamiento
(
almacenamiento_ID int identity (1,1) primary key,
descripcion_de_almacenamiento varchar (30),
localizacion varchar (30)
)

/* procedimiento almacenado de cada valor */
create proc lista_almacenamiento
as
select * from distribucion_y_almacenamiento order by descripcion_de_almacenamiento asc
go

exec lista_almacenamiento

/* fin de insercion */

/*--------------------------------------------------------------------- */

create table produccion_marca
(
ID_produccion int identity (1,1) primary key ,
descripcion_produccion_de_marca varchar (30),
cantidad_produccion_de_marca int,
valor_produccion money
)

delete from produccion_marca where ID_produccion = 3

select * from produccion_marca

select * from distribucion_y_almacenamiento

/* procedimiento almacenado de cada valor */
create proc lista_produccion_marca
as
select * from produccion_marca order by descripcion_produccion_de_marca asc
go

exec lista_produccion_marca
/* fin de insercion */

/*--------------------------------------------------------------------- */

create table instalacion_de_produccion
(
ID_instalacion int identity (1,1) primary key,
Descripcion_de_instalacion_de_produccion varchar (40),
valor_de_instalacion money,
ID_produccion int,
almacenamiento_ID int,

constraint producccion_marca_ID foreign key (ID_produccion) references produccion_marca(ID_produccion),
constraint almacenamiento_ID foreign key (almacenamiento_ID) references distribucion_y_almacenamiento(almacenamiento_ID)
)

select  * from distribucion_y_almacenamiento

/* procedimiento almacenado de cada valor */
create proc lista_instalacion_de_produccion
as
select * from instalacion_de_produccion order by Descripcion_de_instalacion_de_produccion asc
go

exec lista_instalacion_de_produccion
/* fin de insercion */

/*--------------------------------------------------------------------- */



insert into instalacion_de_produccion values
('CEPA',10500.03)


create table estado_financiero
(
ID_estado int primary key identity,
descripcion_de_estado varchar (30),
valor_de_estado money,
total_de_estado money,
fecha_valor_de_estado date
)

/* procedimiento almacenado de cada valor */
create proc lista_estado_financiero
as
select * from estado_financiero order by descripcion_de_estado asc
go

exec lista_estado_financiero
/* fin de insercion */

/*--------------------------------------------------------------------- */

create table ratio
(
ID_ratio int primary key identity,
descripcion_de_ratio varchar (40),
valor_de_ratio money,
total_de_ratio money,
ID_estado int foreign key references estado_financiero(ID_estado)
)

/* procedimiento almacenado de cada valor */
create proc lista_ratio
as
select * from ratio order by descripcion_de_ratio asc
go

exec lista_ratio
/* fin de insercion */

/*--------------------------------------------------------------------- */

create table informe_de_RRHH
(
ID_informe_rrhh int primary key identity,
descripcion_de_rrhh varchar (30),
valor_de_rrhh money,
total_rrhh money
)

/* procedimiento almacenado de cada valor */
create proc lista_rrhh
as
select * from informe_de_RRHH order by descripcion_de_rrhh asc
go

exec lista_rrhh
/* fin de insercion */

/*--------------------------------------------------------------------- */

create table informe_de_mercado
(
ID_informe_mercado int primary key identity,
descripcion_informe_mercado varchar (40),
valor_de_mercado money,
total_de_mercado money,
ID_informe_rrhh int foreign key references informe_de_RRHH(ID_informe_rrhh)
)

/* procedimiento almacenado de cada valor */
create proc lista_informe_mercado
as
select * from informe_de_mercado order by descripcion_informe_mercado asc
go

exec lista_informe_mercado
/* fin de insercion */

/*--------------------------------------------------------------------- */

create table responsabilidad_social
(
ID_responsabilidad_social int primary key identity,
descripcion_responsabilidad_social varchar (30),
valor_responsabilidad_social money
)

/* procedimiento almacenado de cada valor */
create proc lista_responsabilidad_social
as
select * from responsabilidad_social order by descripcion_responsabilidad_social asc
go

exec lista_responsabilidad_social
/* fin de insercion */

/*--------------------------------------------------------------------- */

create table informe_de_costes
(
ID_informe_costes int primary key identity,
descripcion_costes varchar (30),
valor_costes money,
total_costes money,
ID_responsabilidad_social int foreign key references responsabilidad_social(ID_responsabilidad_social)
)

/* procedimiento almacenado de cada valor */
create proc lista_informe_de_costes
as
select * from informe_de_costes order by descripcion_costes asc
go

exec lista_informe_de_costes
/* fin de insercion */

/*--------------------------------------------------------------------- */

create table compensacion
(
ID_compensacion int primary key identity,
descripcion_de_recompensa varchar (40),
valor_recompensa money,
fecha_recompensa varchar (20)
)

 

alter table compensacion add total_recompensa as valor_recompensa*1.2

select * from compensacion
select * from usuario

/* procedimiento almacenado de cada valor */
create proc lista_recompensa
as
select * from compensacion order by descripcion_de_recompensa asc
go

exec lista_recompensa
/* fin de insercion */

/*--------------------------------------------------------------------- */



create table fecha
(
ID_fecha int primary key identity,
fecha_inicial date,
fecha_final date
)

/* procedimiento almacenado de cada valor */
create proc lista_fecha
as
select * from fecha order by ID_fecha asc
go

exec lista_fecha
/* fin de insercion */

/*--------------------------------------------------------------------- */
select * from estado_financiero

/*       Finanza                     */
create table finanza_flujo_de_caja
(
ID_finanza int primary key identity,
ID_instalacion int foreign key references instalacion_de_produccion(ID_instalacion),
ID_estado int foreign key references estado_financiero(ID_estado),
ID_informe_mercado int foreign key references informe_de_mercado(ID_informe_mercado),
ID_informe_costes int foreign key references informe_de_costes(ID_informe_costes),
ID_compensacion int foreign key references compensacion(ID_compensacion),

finanza_total money
)

alter table finanza_flujo_de_caja
add ID_informe_rrhh int foreign key references informe_de_rrhh(ID_informe_rrhh)

alter table finanza_flujo_de_caja
add ID_ratio int foreign key references ratio(ID_ratio)

alter table finanza_flujo_de_caja
add ID_responsabilidad_social int foreign key references responsabilidad_social (ID_responsabilidad_social)

select * from finanza_flujo_de_caja

/* procedimiento almacenado de cada valor */
create proc lista_finanza
as
select * from finanza_flujo_de_caja order by ID_finanza asc
go

exec lista_finanza
/* fin de insercion */

/*--------------------------------------------------------------------- */


/*      Tabla de recopilacion                        */
create table historial_de_usuario
(
ID_historial_usuario int primary key identity,
usuario_ID int foreign key references usuario(usuario_ID),
ID_finanza int foreign key references finanza_flujo_de_caja(ID_finanza),
ID_fecha int foreign key references fecha(ID_fecha)
)

/* procedimiento almacenado de cada valor */
create proc lista_historia_de_usuario
as
select * from historial_de_usuario order by ID_historial_usuario asc
go

exec lista_historia_de_usuario
/* fin de insercion */

/*--------------------------------------------------------------------- */

/*      Informacion descriptiva                                     */
create table historial_de_informacion
(
ID_historial int primary key identity,
ID_historial_usuario int foreign key references historial_de_usuario(ID_historial_usuario)
)

/* procedimiento almacenado de cada valor */
create proc lista_historial_informacion
as
select * from historial_de_informacion order by ID_historial asc
go

exec lista_historial_informacion
/* fin de insercion */

/*--------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------------------- */
 /* Triggers */

 

 /*---TRIGER HISTORIAL USUARIO---- */
 create trigger TR_Historial_usuario
 on historial_de_usuario
 for insert
 as
 print 'informacion agregada'

 insert into historial_de_usuario values (1,1,1)
 select * from historial_de_usuario

 /*-------TRIGER HISTORIAL Informacion-------*/

 create trigger TR_historial_informacion
 on historial_de_informacion
 for insert
 as
 print 'Informacion agregada'

 insert into historial_de_informacion values (1)

 select * from historial_de_informacion

 /* -----TRIGGER de TR_compensacion--------- */
create trigger TR_compensacion_insert
 on compensacion
 for insert
 as
 print 'Informacion Agregada';

 insert into compensacion(descripcion_de_recompensa, valor_recompensa, fecha_recompensa) values ('CREDITO', 12350.05, '23/12/2023');

 

 select * from compensacion

 /* -----TR_Produccion_Marca--------- */

create trigger TR_produccion_marca_insert
 on produccion_marca
 for insert
 as
 print 'Informacion Agregada';

 insert into produccion_marca values ('Abani', 160, 12400.25)

 select * from produccion_marca

 /*---------------TR_distribucion_y_almacenamiento-------------------*/

create trigger TR_distribucion_y_almacenamiento_insert
 on distribucion_y_almacenamiento
 for insert
 as
 print 'Informacion Agregada';

 insert into distribucion_y_almacenamiento values ('Distribucion A3','Santa Barbara');

 select * from distribucion_y_almacenamiento

 select * from finanza_flujo_de_caja


 /*-----------------TR_Instalacion_de_produccion-------------------------*/

 create trigger TR_instalacion_de_produccion_insert
 on instalacion_de_produccion
 for insert
 as
print 'informacion agregada';

insert into instalacion_de_produccion values ('CEPA', 12500.43, 1, 1)

select * from instalacion_de_produccion

/*----------TR_Fecha------------*/

create trigger TR_fecha_insert
on fecha
for insert
as
print 'Informacion agregada';

insert into fecha values ('24/02/2023', '20/04/2023');

select * from fecha

/*----------TR_usuario------------------------*/

create trigger TR_usuario_insert
on usuario
for insert
as
print 'Informacion agregada';

insert into usuario values ('David Suarez', 'unicah123', 'Davidsuarez123@gmail.com', 1, 'David', 'Francisco');

select * from usuario

/*-------TR_informe_RRHH----------*/

create trigger TR_RRHH_insert
on informe_de_RRHH
for insert
as
print 'Informacion agregada';

insert into informe_de_RRHH values ('mano de obra', 4300.02, 4300.02*1.01)

select * from informe_de_RRHH

/*--------TR_iforme_mercado-------------*/

create trigger TR_mercado_insert
on informe_de_mercado
for insert
as
print 'Informacion agregada';

insert into informe_de_mercado values ('Papeleria', 5300.05, 5300.05*1.01,1)

select * from informe_de_mercado

/*-------TR_responsabilidad_social----------*/

create trigger TR_responsabilidad_social_insert
on responsabilidad_social
for insert
as
print 'Informacion agregada'

insert into responsabilidad_social values ('Aseo', 12500.02*1.1)

select * from responsabilidad_social

/*----------TR_informe_de_costes-----------------*/

create trigger TR_informe_costes_insert
on informe_de_costes
for insert
as
print 'Informacion agregada'

insert into informe_de_costes values ('preparacion', 12800.02, 12800*1.1, 1)

select * from informe_de_costes

/*-----------TR_Ratio------------------*/

create trigger TR_ratio_insert
on ratio
for insert
as
print 'Informacion agregada'

insert into ratio values ('valor por costos', 400.02, 450.03, 1)

select * from ratio

select * from produccion_marca



/*--------TR_estado_financiero-------------*/

create trigger TR_estado_financiero
on estado_financiero
for insert
as
print 'informacion agregada'

insert into estado_financiero values ('estado actual', 25000.02, 25000.02*1.1, '20/11/2022')

select * from estado_financiero

/* TR_Finanza_flujo_de_caja */

create trigger TR_finanza_caja
on finanza_flujo_de_caja
for insert
as
print 'Informacion actualizada'

insert into finanza_flujo_de_caja values (1,1,1,1,1,34500.05,1,1,1)

select * from finanza_flujo_de_caja



/*--------PROCEDIMIENTO ALMACENADO----------*/

/* PROC Instalacion de produccion*/

create proc PA_Instalacion_produccion
@ID_instalacion int
as
begin

select @ID_instalacion [INSTALACION_ID], i.ID_instalacion, d.almacenamiento_id, d.descripcion_de_almacenamiento, d.localizacion,
p.descripcion_produccion_de_marca, (p.cantidad_produccion_de_marca*p.valor_produccion*0.15) [Total de Produccion],
sum(i.valor_de_instalacion+(p.cantidad_produccion_de_marca*p.valor_produccion)*0.15)  [TOTAL DE INSTALACION]

from instalacion_de_produccion i 
inner join distribucion_y_almacenamiento d
on d.almacenamiento_id = i.almacenamiento_id
/**/
inner join produccion_marca p
on i.ID_produccion = p.ID_produccion

where i.ID_instalacion = @ID_instalacion
group by i.ID_instalacion,d.almacenamiento_ID, p.ID_produccion, d.descripcion_de_almacenamiento, d.localizacion, p.descripcion_produccion_de_marca, (p.cantidad_produccion_de_marca*p.valor_produccion*0.15)


end

exec PA_Instalacion_produccion 1


/* PROCEDURE RATIO FINANCIERO */
create procedure PA_ratio_financiero
@ID_finanzaR int
as
begin

select @ID_finanzaR, r.ID_estado, r.ID_ratio , r.total_de_ratio+e.total_de_estado [TOTAL RATO], e.fecha_valor_de_estado 

from ratio r
inner join estado_financiero e
on r.ID_estado = e.ID_estado

where r.ID_estado = @ID_finanzaR
group by r.ID_estado, r.ID_ratio, r.total_de_ratio+e.total_de_estado, e.fecha_valor_de_estado


end

execute PA_ratio_financiero 1

/* PROCEDURE INFORME DE COSTES */

create procedure PA_costes
@ID_informe_Coste int
as
begin

select @ID_informe_Coste, s.ID_responsabilidad_social, s.descripcion_responsabilidad_social, n.descripcion_costes, n.total_costes + s.valor_responsabilidad_social [TOTAL COSTES]

from informe_de_costes n
inner join responsabilidad_social s
on n.ID_responsabilidad_social = s.ID_responsabilidad_social

where @ID_informe_Coste = n.ID_informe_costes
group by s.ID_responsabilidad_social, s.descripcion_responsabilidad_social, n.descripcion_costes, n.total_costes + s.valor_responsabilidad_social


end

exec PA_costes 1

/* PROCEDURE informe de mercado RRHH y produccion*/

create procedure PA_mercado
@ID_mercadoH int
as
begin

select @ID_mercadoH [Mercado], h.ID_informe_rrhh, m.descripcion_informe_mercado,  h.total_rrhh+m.valor_de_mercado [TOTAL ALMACENADO]

/* */
from informe_de_mercado m
inner join informe_de_RRHH h
on m.ID_informe_rrhh = h.ID_informe_rrhh

where @ID_mercadoH = m.ID_informe_mercado
group by h.ID_informe_rrhh, m.descripcion_informe_mercado,  h.total_rrhh+m.valor_de_mercado 
end

exec PA_mercado 1

/* PROCEDURE tiempo en historial usuario */

create procedure PA_historial_usuario
@ID_time int
as
begin

select @ID_time [USUARIO], u.usuario_ID, f.fecha_inicial, f.fecha_inicial

from historial_de_usuario u
inner join fecha f
on f.ID_fecha = u.ID_fecha

where @ID_time = u.ID_fecha
group by u.usuario_ID, f.fecha_inicial, f.fecha_inicial

end

exec PA_historial_usuario 1


/*  FIN */





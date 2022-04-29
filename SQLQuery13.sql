/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [Pais]
      ,[Region]
  FROM [SSIS].[dbo].[Region]

  delete from Region where Pais = 'Pais'

SELECT        Actividades_Extra.Id_num, Datos_Personales.Nombre, Actividades_Extra.Actividad, Datos_Personales_1.Ciudad
FROM            Actividades_Extra INNER JOIN
                         Datos_Personales ON Actividades_Extra.Id_num = Datos_Personales.Id_num INNER JOIN
                         Datos_Personales AS Datos_Personales_1 ON Actividades_Extra.Id_num = Datos_Personales_1.Id_num

SELECT        Actividades_Extra.Id_num, Datos_Personales.Nombre, Actividades_Extra.Actividad
FROM            Actividades_Extra left JOIN
                         Datos_Personales ON Actividades_Extra.Id_num = Datos_Personales.Id_num

SELECT        Datos_Personales.Id_num, Datos_Personales.Nombre, Actividades_Extra.Actividad
FROM            Actividades_Extra right JOIN
                         Datos_Personales ON Actividades_Extra.Id_num = Datos_Personales.Id_num

SELECT        Datos_Personales.Id_num, Datos_Personales.Nombre, Actividades_Extra.Actividad
FROM            Actividades_Extra full JOIN
                         Datos_Personales ON Actividades_Extra.Id_num = Datos_Personales.Id_num


--------------    self join       ---------------------------
select * from Empleados

select *
from Empleados emp
inner join Empleados sup
	on emp.Supervisor = sup.Nombre
order by emp.Nombre

select emp.Nombre,
	   sup.Nombre As Supervisor,
	   sup.Telefono As Tel_Supervisor
from Empleados emp
inner join Empleados sup
	on emp.Supervisor = sup.Nombre
order by emp.Nombre


/* Utilizando la informacion contenida en la base de datos Alumnosy, encuentre la nacionalidad de las alumnas
solteras y los alumnos divorciados registrados en cada una de las actividades
extra_curriculares.
Incluya además la cantidad de alumnos que cumplen con estas condiciones
*/

create view Alumnos_Edo_Civil as

select Datos_Personales.Estado_Civil, Datos_Personales.Genero, Ciudad.Pais,
	   Actividades_Extra.Actividad
from Ciudad
inner join Datos_Personales on Ciudad.Ciudad = Datos_Personales.Ciudad
inner join Actividades_Extra on Actividades_Extra.Id_num = Datos_Personales.Id_num

select * from Alumnos_Edo_Civil

select Pais, Estado_Civil, Genero, Actividad, count(Actividad) As Cant_Edo_Civil
from Alumnos_Edo_Civil
where (Genero='F' and Estado_Civil = 'Single') or (Genero='M' and Estado_Civil = 'Divorced')
group by Estado_Civil, Pais, Genero, Actividad
order by Pais, Estado_Civil, Actividad

----------------  Creando tabla a partir de otra o de una vista -----------------------------------------
select gender, age, [time] Into Maraton_Nueva
from MaratonNY

select * from MaratonNY

create view Mexicanos as
select Corredor, place, gender, age, [time]
from MaratonNY
where home='Mex'

select * from Mexicanos

select * into Tabla_Mex
from Mexicanos

select * from Tabla_Mex

select distinct Actividad into Lista_de_Actividades
from Actividades_Extra

select * from Lista_de_Actividades


----------------------------------- Utilizando Variables --
declare @Id_num int, @Pais varchar(20), @Ciudad varchar(20)

set @Id_num = 5

set @Ciudad = (select Ciudad
                 from Datos_Personales
				 where Id_num = @Id_num)

set @Pais = (select Pais 
               from Ciudad
			   where Ciudad = @Ciudad)

select @Id_num as Número_de_Alumno
select @Ciudad as Ciudad
select @Pais as Pais


-----------------------------       Case              ---------------------------
select *, "Categoria" =
	case
		when time <= 200 then 'Veloz'
		when time between 200 and 300 then 'Regular'
		else 'Lento'
	end
from MaratonNY

use SSIS

select Nombre, "Comunicacion" = 
	case
		when Telefono is not null then concat('Llamar al ', Telefono)
		when Direccion is not null then concat('Enviar cardex a ', Direccion)
		else 'El alumno no tiene registrado teléfono ni Dirección'
	end
from Datos_Personales;

------------------------------------- INsert   ---------------------------------
create table Utiles_Escolares (
	Prod_Num int,
	Producto varchar(50),
	Proveedor varchar(100),
	Costo decimal(6,2)
)

create table Utiles_Escolares2 (
	Prod_Num int primary key,
	Producto varchar(50) not null,
	Proveedor varchar(100) not null,
	Costo decimal(6,2) not null
)

insert into Utiles_Escolares (Prod_Num, Producto, Proveedor, Costo)
	values( 126, 'Lápiz 2B', 'Papelería San Felipe', 3.50)

insert into Utiles_Escolares (Prod_Num, Producto, Proveedor, Costo)
	values( 129, 'Cuaderno Cuadriculado', 'Proveedora de Oficinas', 22.30)

select * from Utiles_Escolares

insert into Utiles_Escolares (Producto, Proveedor, Costo)
	values( 'Lápiz 2B', 'Papelería San Felipe', 3.50)

delete from Utiles_Escolares where Prod_Num is null

alter table Utiles_Escolares 
add primary key (Prod_Num)                -- Marca error

alter table Utiles_Escolares
alter column Prod_Num int not null        -- Corrige error anterior

alter table Utiles_Escolares
alter column Producto varchar(50) not null

alter table Utiles_Escolares
alter column Proveedor varchar(100) not null

alter table Utiles_Escolares
alter column Costo decimal(6,2) not null

alter table Utiles_Escolares
add Precio decimal(6,2)

create table Proveedores (
	Id_Proveedor int primary key,
	registro_Fiscal varchar(50) default ('Desconocido'),
	Domicilio varchar(100) not null
)

insert into Proveedores(Id_Proveedor,Domicilio)
values(345, 'Arco Vespacioano 89')

select * from Proveedores

alter table Utiles_Escolares
alter column Precio int

alter table Utiles_Escolares
drop column Precio

alter table Proveedores
add Pago_a_Proveedores int
check (Pago_a_Proveedores > 10 and Pago_a_Proveedores < 10000)

insert into Proveedores (Id_Proveedor, Domicilio, Pago_a_Proveedores)
values (478, 'Avellanos 190', 1800)



-------------------  UPDATE     ------------------------------------------------------
select * into Maraton_Modificada
from MaratonNY

alter table Maraton_Modificada
add Clasificacion varchar(50)

update Maraton_Modificada
set Clasificacion = 'Jovencito'
where gender = 'Male' and age <= 40

select * from Maraton_Modificada

update Maraton_Modificada
set Clasificacion = 'Jovencita'
where gender = 'Female' and age <=40

update Maraton_Modificada
set Clasificacion = 'Señor'
where gender = 'Male' and age > 40

update Maraton_Modificada
set gender = 'Hombre'
where gender = 'Male'

update Maraton_Modificada
set gender = 'Mujer'
where gender = 'Female'

update Maraton_Modificada
set [time] = [time]/60

alter table Actividades_Extra
add Nombre varchar(255)

update Actividades_Extra
set Nombre = Datos_Personales.Nombre
from Datos_Personales
where Actividades_Extra.Id_Num = Datos_Personales.Id_Num

select * from Actividades_Extra

delete from Maraton_Modificada
where Corredor = 53

select * from Maraton_Modificada

delete from Maraton_Modificada
where time < all 
	(select time 
		from Maraton_Modificada where home = 'MEX');


------------------ ELIMINANDO REGISTROS DUPLICADOS    ----------------------------------------------
CREATE table Tabla_con_Duplicados(
	Nombre varchar(40),
	Profesion varchar(40),
	Empresa varchar(50)
)

insert into Tabla_con_Duplicados
values ('José Chávez','Ingeniero','HP'),
	   ('Andrés Ramirez','Abogado','Notaría 16'),
	   ('Benito Macías','Contador','Seguros Monterrey'),
	   ('Rogelio Martínez','Médico','Hospital San Javier'),
	   ('Benito Macías','Contador','Seguros Monterrey'),
	   ('Benito Macías','Contador','Seguros Monterrey'),
	   ('José Chávez','Ingeniero','HP')


select *, count(*) over (partition by Nombre, Profesion, Empresa) as Conteo
from Tabla_con_Duplicados

select *, row_number() over (partition by Nombre, Profesion, Empresa order by Nombre) as Enumeracion
from Tabla_con_Duplicados

select *
from (select *, row_number() over (partition by Nombre, Profesion, Empresa order by Nombre, Profesion, Empresa) as Enumeracion
	from Tabla_con_Duplicados) as Enumeracion_Duplicados  -- Esta es una Tabla Derivada
where Enumeracion_Duplicados.Enumeracion > 1

delete Enumeracion_Duplicados
from (select *, row_number() over (partition by Nombre, Profesion, Empresa order by Nombre, Profesion, Empresa) as Enumeracion
	from Tabla_con_Duplicados) as Enumeracion_Duplicados
where Enumeracion_Duplicados.Enumeracion > 1

select *, count(*) over (partition by Nombre, Profesion, Empresa order by Nombre, Profesion, Empresa) as Conteo
from Tabla_con_Duplicados

select * 
from Tabla_con_Duplicados


------------------------------  DROP Y TRUNCATE  ------------------------------------------------

DELETE FROM Maraton_Modificada
where time < all
	(select time 
		from Maraton_Modificada where home = 'MEX');


create table Profesionistas(
	ID integer identity(1,1),
	Nombre varchar(40),
	Profesion varchar(40),
	Empresa varchar(40)
)

insert into Profesionistas
values ('José Chávez','Ingeniero','HP'),
	   ('Andrés Ramirez','Abogado','Notaría 16'),
	   ('Benito Mecías','Contador','Seguros Monterrey'),
	   ('Rogelio Martínez','Médico','Hospital San Javier')

select * from Profesionistas

delete Profesionistas

truncate table Profesionistas

alter table Profesionistas
drop column Empresa

alter table Profesionistas
drop column if exists Profesion

drop table Profesionistas

drop table if exists Profesionistas
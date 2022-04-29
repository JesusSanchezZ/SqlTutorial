/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [Corredor]
      ,[place]
      ,[gender]
      ,[age]
      ,[home]
      ,[time]
  FROM [AdventureJesus].[dbo].[Maraton]

  select * from dbo.Maraton where home in ('MEX','BRA','ARG','PER')
  -- Select dentro de select
  select Pais, Poblacion from Poblacion_Mundial
	where Poblacion >=
		(select Poblacion from Poblacion_Mundial
			where Pais = 'Mexico')
		order by Poblacion               -- Ordena los datos de menor a mayor

select Pais, Poblacion from Poblacion_Mundial
	where Poblacion >=
		(select Poblacion from Poblacion_Mundial
			where Pais = 'Mexico')
		order by Poblacion  desc         -- Ordena los datos de mayor a menor

select Age, Time from Maraton
	order by Age

select Age, Time from Maraton
	order by Age,Time

select home from Maraton order by 1

select distinct home from Maraton order by 1

select min(Time) from Maraton

select max(Time) from Maraton

select sum(Time) from Maraton

select avg(Time) from Maraton

select round(avg(Time),2) from Maraton

select count(distinct(home)) from Maraton

select gender,min(time) as Tiempo_Minimo from Maraton group by gender

select gender,max(time) as Timepo_Maximo from Maraton group by gender

select home, count(Corredor) as Cant_Particip from Maraton group by home

select home,gender, count(Corredor) as Cant_Particip from Maraton group by home,gender

select home, gender, min(time) as Tiempo_Minimo
	from Maraton
		where home = 'MEX'
	group by home, gender

select home, gender, min(time) as Tiempo_Minimo
	from Maraton
		where home in ('MEX','PER')
	group by home, gender

select home, count(Corredor) As Cant_Particip, Min(time) As Tiempo_Minimo,
	max(time) As Tiempo_Maximo, avg(time) as Tiempo_promedio
from Maraton
group by home

select home, count(Corredor) As Cant_Particip, Min(time) As Tiempo_Minimo,
	max(time) As Tiempo_Maximo, avg(time) as Tiempo_promedio
from Maraton
group by home
order by Tiempo_Minimo

select home, count(Corredor) As Cant_Particip, Min(time) As Tiempo_Minimo,
	max(time) As Tiempo_Maximo, avg(time) as Tiempo_promedio
from Maraton
group by home
having count(Corredor) > 1
order by Tiempo_Minimo


---         UNION           ---------------------------------
select gender, age, home, [time], 'Lento' As Categoria
from Maraton 
where time > 300

union

select gender, age, home, time, 'Regular' As Categoria
from Maraton 
where time between 200 and 300

union

select gender, age, home, time, 'Veloz' As Categoria
from Maraton 
where time < 200

order by age


------------  CONCAT    -------------------------------------------
select FirstName, LastName from Clientes

select FirstName, LastName, FirstName + ' ' + LastName As Full_Name from Clientes

select FirstName, LastName, concat(FirstName, ' ',LastName) from Clientes

------  CONCAT_WS        ---------------------------------------
select CONCAT_WS(' - ', Direccion, Ciudad) As Ubicacion from Datos_Personales

select Direccion, Ciudad,CONCAT_WS(' - ', Ciudad, Direccion) As Ubicacion from Datos_Personales

------------- Mostrar informacion como un directorio  -----------------------------
select
	concat_ws
	(
		char(13),
		Nombre,
		Correo,
		Direccion,
		Ciudad,
		Telefono,
		'---'
	) Directorio
from Datos_Personales
order by Nombre


-------------------------------------------------------- quitar espacios en blanco

select ltrim('           Quita espacios en blanco a la izq.')
select rtrim('           Quita espacios en blanco a la der.            ')
select trim('           Quita espacios en blanco a ambos lados.            ')

-------------------------------------------------------------------CAST  --- CONVERT--------
SELECT '09/02/1970'

SELECT CAST('09/02/1970' AS DATETIME)

SELECT CAST(CAST('12/06/1970' AS datetime) -
	CAST('02/09/1970' AS datetime) AS int) 

select cast(DateTime AS char(12))
from PODatetime

select convert(varchar, DateTime, 100) from podatetime

select convert(varchar, DateTime, 101) from podatetime

select convert(varchar, DateTime, 102) from podatetime



select * from podatetime
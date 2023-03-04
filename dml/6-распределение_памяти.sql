
/* распределение памяти */
use master  
create database UNIVER on primary
( name = N'UNIVER_mdf', filename = N'E:\Универ\Лабораторные работы\3 семестр\БД\лаба 3\UNIVER\UNIVER_mdf.mdf', 
   size = 10240Kb, maxsize=UNLIMITED, filegrowth=1024Kb),
( name = N'UNIVER_ndf', filename = N'E:\Универ\Лабораторные работы\3 семестр\БД\лаба 3\UNIVER\UNIVER_ndf.ndf', 
   size = 10240KB, maxsize=1Gb, filegrowth=25%),
filegroup FG1
( name = N'UNIVER_fg1_1', filename = N'E:\Универ\Лабораторные работы\3 семестр\БД\лаба 3\UNIVER\UNIVER_fgq-1.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
( name = N'UNIVER_fg1_2', filename = N'E:\Универ\Лабораторные работы\3 семестр\БД\лаба 3\UNIVER\UNIVER_fgq-2.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%)
log on
( name = N'UNIVER_log', filename=N'E:\Универ\Лабораторные работы\3 семестр\БД\лаба 3\UNIVER\UNIVER_log.ldf',       
   size=10240Kb,  maxsize=2048Gb, filegrowth=10%)

   /* распределение по файловым группам */
   CREATE TABLE AUDITORIUM 
          (     AUDITORIUM   char(20)  primary key,              
				AUDITORIUM_TYPE  char(10) foreign key, 
                AUDITORIUM_CAPACITY  int ,  
                AUDITORIUM_NAME  varchar(50)                                     
          ) on FG1;


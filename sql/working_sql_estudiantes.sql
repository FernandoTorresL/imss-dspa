
--Instrucciones para borrar tablas:
DROP TABLE est_renapo_confronta2;
DROP TABLE est_renapo_confronta1;
DROP TABLE est_renapo_confronta0;
DROP TABLE est_layout_didt;
DROP TABLE est_layout_excel;  
DROP TABLE est_enlaces_subs;
DROP TABLE est_archivos;
DROP TABLE est_rps;
DROP TABLE est_enlaces;
-------------------------------------

CREATE TABLE sexo (
  id_sexo       INT,
  id_alf_sexo   CHAR(1) NOT NULL,
  descripcion   VARCHAR(6) NOT NULL,
  PRIMARY KEY (id_sexo)
)
  ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO sexo VALUES (1, "H", "HOMBRE");
INSERT INTO sexo VALUES (2, "M", "MUJER");

CREATE TABLE entidades_renapo (
  id_entidad_renapo   CHAR(2) NOT NULL,
  id_lugar_nacimiento CHAR(2) NOT NULL,
  descripcion         VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_entidad_renapo)
)
  ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO entidades_renapo VALUES ("AS", 1, "AGUASCALIENTES");
INSERT INTO entidades_renapo VALUES ("BC", 2, "BAJA CALIFORNIA");
INSERT INTO entidades_renapo VALUES ("BS", 3, "BAJA CALIFORNIA SUR");
INSERT INTO entidades_renapo VALUES ("CC", 4, "CAMPECHE");
INSERT INTO entidades_renapo VALUES ("CL", 5, "COAHUILA");
INSERT INTO entidades_renapo VALUES ("CM", 6, "COLIMA");
INSERT INTO entidades_renapo VALUES ("CS", 7, "CHIAPAS");
INSERT INTO entidades_renapo VALUES ("CH", 8, "CHIHUAHUA");
INSERT INTO entidades_renapo VALUES ("DF", 9, "CIUDAD DE MÉXICO");
INSERT INTO entidades_renapo VALUES ("DG", 10, "DURANGO");
INSERT INTO entidades_renapo VALUES ("GT", 11, "GUANAJUATO");
INSERT INTO entidades_renapo VALUES ("GR", 12, "GUERRERO");
INSERT INTO entidades_renapo VALUES ("HG", 13, "HIDALGO");
INSERT INTO entidades_renapo VALUES ("JC", 14, "JALISCO");
INSERT INTO entidades_renapo VALUES ("MC", 15, "MÉXICO");
INSERT INTO entidades_renapo VALUES ("MN", 16, "MICHOACÁN");
INSERT INTO entidades_renapo VALUES ("MS", 17, "MORELOS");
INSERT INTO entidades_renapo VALUES ("NT", 18, "NAYARIT");
INSERT INTO entidades_renapo VALUES ("NL", 19, "NUEVO LEÓN");
INSERT INTO entidades_renapo VALUES ("OC", 20, "OAXACA");
INSERT INTO entidades_renapo VALUES ("PL", 21, "PUEBLA");
INSERT INTO entidades_renapo VALUES ("QT", 22, "QUERÉTARO");
INSERT INTO entidades_renapo VALUES ("QR", 23, "QUINTANA ROO");
INSERT INTO entidades_renapo VALUES ("SP", 24, "SAN LUIS POTOSÍ");
INSERT INTO entidades_renapo VALUES ("SL", 25, "SINALOA");
INSERT INTO entidades_renapo VALUES ("SR", 26, "SONORA");
INSERT INTO entidades_renapo VALUES ("TC", 27, "TABASCO");
INSERT INTO entidades_renapo VALUES ("TS", 28, "TAMAULIPAS");
INSERT INTO entidades_renapo VALUES ("TL", 29, "TLAXCALA");
INSERT INTO entidades_renapo VALUES ("VZ", 30, "VERACRUZ");
INSERT INTO entidades_renapo VALUES ("YN", 31, "YUCATÁN");
INSERT INTO entidades_renapo VALUES ("ZS", 32, "ZACATECAS");
INSERT INTO entidades_renapo VALUES ("NE", 35, "NACIDO EN EL EXTRANJERO");

CREATE TABLE est_enlaces (
  id_enlace         INT AUTO_INCREMENT,
  nombre            VARCHAR(50) NOT NULL,
  primer_apellido   VARCHAR(50) NOT NULL,
  segundo_apellido  VARCHAR(50),
  email             VARCHAR(100),
  PRIMARY KEY (id_enlace)
)
  ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO est_enlaces (nombre, primer_apellido, segundo_apellido,email) VALUES ('SIN ENLACE DESIGNADO','','', NULL);
INSERT INTO est_enlaces (nombre, primer_apellido, segundo_apellido,email) VALUES ('Fernando','Torres','Laguna','fernando.torresl@imss.gob.mx');
INSERT INTO est_enlaces (nombre, primer_apellido, segundo_apellido,email) VALUES ('Eduardo','Bautista','Salazar','eduardo.bautista@imss.gob.mx');
INSERT INTO est_enlaces (nombre, primer_apellido, segundo_apellido,email) VALUES ('Carlos','Guarneros','Chávez','carlos.guarneros@imss.gob.mx');
INSERT INTO est_enlaces (nombre, primer_apellido, segundo_apellido,email) VALUES ('Mario','Maldonado','Martínez','mario.maldonadom@imss.gob.mx');
INSERT INTO est_enlaces (nombre, primer_apellido, segundo_apellido,email) VALUES ('Patricia','Vargas','García','patricia.vargasg@imss.gob.mx');
INSERT INTO est_enlaces (nombre, primer_apellido, segundo_apellido,email) VALUES ('Lucero','Torres','Lira','lucero.torres@imss.gob.mx');
INSERT INTO est_enlaces (nombre, primer_apellido, segundo_apellido,email) VALUES ('Alexandra Paola','Burbano','Baca','alexandra.burbano@imss.gob.mx');
INSERT INTO est_enlaces (nombre, primer_apellido, segundo_apellido,email) VALUES ('Juan Manuel','Montañez','González','juan.montanez@imss.gob.mx');
INSERT INTO est_enlaces (nombre, primer_apellido, segundo_apellido,email) VALUES ('Elisheba','Hubert','Ruiz','elisheba.hubertr@imss.gob.mx');
INSERT INTO est_enlaces (nombre, primer_apellido, segundo_apellido,email) VALUES ('Adán','Ramírez','Baeza','adan.ramirez@imss.gob.mx');
INSERT INTO est_enlaces (nombre, primer_apellido, segundo_apellido,email) VALUES ('Juan Carlos','Pérez','Nava','carlos.perezn@imss.gob.mx');
INSERT INTO est_enlaces (nombre, primer_apellido, segundo_apellido,email) VALUES ('Martha','López','Pérez','martha.lopezp@imss.gob.mx');

CREATE TABLE est_rps (
  id_rp           INT AUTO_INCREMENT,
  rp              CHAR(11) NOT NULL,
  rp_conv         CHAR(11) DEFAULT NULL,
  rfc             CHAR(12) NOT NULL,
  denominacion_rp VARCHAR(100) NOT NULL,
  delegacion      TINYINT UNSIGNED,
  subdelegacion   TINYINT UNSIGNED,
  PRIMARY KEY (id_rp),
  FOREIGN KEY (delegacion)                REFERENCES delegaciones(delegacion),
  FOREIGN KEY (delegacion, subdelegacion) REFERENCES subdelegaciones(delegacion, subdelegacion)
)
  ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO est_rps (rp, rfc, denominacion_rp, delegacion, subdelegacion) VALUES ('SIN-RP', 'SIN-RP', 'SIN-RP', 0, 0);
INSERT INTO est_rps (rp, rfc, denominacion_rp, delegacion, subdelegacion) VALUES ('Z3710035323', 'CBE8008274T6', 'COLEGIO DE BACHILLERES EMSAD DE VALLERMOSO', 24, 1);

CREATE TABLE est_archivos (
  id_archivo      INT AUTO_INCREMENT,
  nombre_archivo  VARCHAR(64) NOT NULL,
  id_rp           INT,
  id_enlace       INT,
  fecha_recepcion DATETIME DEFAULT NOW(),
  comentario      VARCHAR(256) DEFAULT NULL,
  PRIMARY KEY (id_archivo),
  FOREIGN KEY (id_rp)                     REFERENCES est_rps(id_rp),
  FOREIGN KEY (id_enlace)                 REFERENCES est_enlaces(id_enlace)
)
  ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO est_archivos (nombre_archivo, id_rp, id_enlace, fecha_recepcion) VALUES ('SIN-ARCHIVO-ASIGNADO', 1, 1, NOW());
INSERT INTO est_archivos (nombre_archivo, id_rp, id_enlace, fecha_recepcion) VALUES ('43001000000000SDEP01.TXT', 1, 1, '2016-02-24 18:49');
INSERT INTO est_archivos (nombre_archivo, id_rp, id_enlace, fecha_recepcion) VALUES ('Z3710035323.xlsx', 2, 6, '2016-02-24 18:49');
INSERT INTO est_archivos (nombre_archivo, id_rp, id_enlace, fecha_recepcion) VALUES ('Estudiantes.TXT', 2, 6, NOW());
INSERT INTO est_archivos (nombre_archivo, id_rp, id_enlace, fecha_recepcion) VALUES ('Beneficiarios.TXT', 1, 1, NOW());
INSERT INTO est_archivos (nombre_archivo, id_rp, id_enlace, fecha_recepcion) VALUES ('Coincidentes_benef.txt', 1, 1, NOW());
INSERT INTO est_archivos (nombre_archivo, id_rp, id_enlace, fecha_recepcion) VALUES ('Coincidentes_PISP.txt', 1, 1, NOW());

INSERT INTO est_archivos (nombre_archivo, id_rp, id_enlace, fecha_recepcion, comentario) VALUES ('UDEG_CURP_ACT.txt', 1, 12, NOW(), '7,582 registros');
INSERT INTO est_archivos (nombre_archivo, id_rp, id_enlace, fecha_recepcion, comentario) VALUES ('UDEG_SIN_DIF.txt', 1, 12, NOW(), '233,036 registros');

INSERT INTO est_archivos (nombre_archivo, id_rp, id_enlace, fecha_recepcion, comentario) VALUES ('CAMPECHE_CURP_ACT.txt', 1, 12, NOW(), '2,450 registros');
INSERT INTO est_archivos (nombre_archivo, id_rp, id_enlace, fecha_recepcion, comentario) VALUES ('CAMPECHE_SIN_DIF.txt', 1, 12, NOW(), '34,369 registros');

INSERT INTO est_archivos (nombre_archivo, id_rp, id_enlace, fecha_recepcion, comentario) VALUES ('reingresoTrabajadoresSIE_0403 2016_parte1ViernesSIE.txt', 1, 13, '2016-03-04', '529,766 registros');
INSERT INTO est_archivos (nombre_archivo, id_rp, id_enlace, fecha_recepcion, comentario) VALUES ('reingresoTrabajadoresSIE_0403 2016_parte2ViernesSIE.txt', 1, 13, '2016-03-04', '529,766 registros');
INSERT INTO est_archivos (nombre_archivo, id_rp, id_enlace, fecha_recepcion, comentario) VALUES ('reingresoTrabajadoresSIE_0503 2016_parte1SabadoSIE.txt', 1, 13, '2016-03-05', '863,591 registros');
INSERT INTO est_archivos (nombre_archivo, id_rp, id_enlace, fecha_recepcion, comentario) VALUES ('reingresoTrabajadoresSIE_0503 2016_parte2SabadoSIE.txt', 1, 13, '2016-03-05', '863,591 registros');

INSERT INTO est_archivos (nombre_archivo, id_rp, id_enlace, fecha_recepcion, comentario) 
  VALUES ('reingresoTrabajadoresSIE_280216_Parte2.txt', 1, 13, '2016-02-28', '540,197 registros');
INSERT INTO est_archivos (nombre_archivo, id_rp, id_enlace, fecha_recepcion, comentario) 
  VALUES ('reingresoTrabajadoresSIE_280216_Parte1.txt', 1, 13, '2016-02-28', '540,196 registros');
INSERT INTO est_archivos (nombre_archivo, id_rp, id_enlace, fecha_recepcion, comentario) 
  VALUES ('reingresoTrabajadoresSIE_030316.txt', 1, 13, '2016-03-03', '336,185 registros');
INSERT INTO est_archivos (nombre_archivo, id_rp, id_enlace, fecha_recepcion, comentario) 
  VALUES ('reingresoTrabajadoresSIE_020316.txt', 1, 13, '2016-03-02', '240,412 registros');

INSERT INTO est_archivos (nombre_archivo, id_rp, id_enlace, fecha_recepcion, comentario) 
  VALUES ('reingresoTrabajadoresSIE.txt', 1, 13, '2016-03-07', '500,000 registros');

INSERT INTO est_archivos (nombre_archivo, id_rp, id_enlace, fecha_recepcion, comentario) 
  VALUES ('reingresoTrabajadoresSIE 09Mar2016.txt', 1, 13, '2016-03-07', '558,969 reg(reingresoTrabajadoresSIE.txt)');



UPDATE est_archivos SET id_enlace=1, id_rp=1 WHERE nombre_archivo='Estudiantes.TXT'


CREATE TABLE est_enlaces_subs (
  id_enlace         INT,
  delegacion        TINYINT UNSIGNED,
  subdelegacion     TINYINT UNSIGNED,
  PRIMARY KEY (id_enlace, delegacion, subdelegacion),
  FOREIGN KEY (id_enlace)                 REFERENCES est_enlaces(id_enlace),
  FOREIGN KEY (delegacion)                REFERENCES delegaciones(delegacion),
  FOREIGN KEY (delegacion, subdelegacion) REFERENCES subdelegaciones(delegacion, subdelegacion)
)
  ENGINE=InnoDB DEFAULT CHARSET=latin1;


--Enlace sin asignar
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (1, 0, 0);
--Enlace nivel central
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (2, 9, 0);

INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 29, 19);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 3, 8);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 39, 16);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 1, 19);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 11, 14);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 12, 13);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 13, 5);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 13, 7);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 14, 15);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 14, 39);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 14, 50);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 16, 5);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 17, 27);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 18, 15);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 2, 2);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 2, 3);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 2, 4);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 2, 5);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 20, 31);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 20, 32);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 20, 33);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 20, 34);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 20, 6);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 20, 8);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 21, 4);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 21, 53);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 24, 2);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 24, 7);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 25, 3);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 27, 10);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 27, 13);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 27, 3);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 27, 51);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 27, 57);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 29, 13);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 29, 18);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 39, 54);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 39, 56);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 39, 57);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 4, 4);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 40, 11);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 40, 58);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 40, 6);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 5, 11);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 5, 12);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 5, 17);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 5, 23);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 6, 7);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 8, 10);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 8, 60);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (3, 8, 8);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (4, 1, 1);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (4, 12, 1);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (4, 15, 54);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (4, 15, 6);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (4, 22, 1);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (4, 31, 9);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (4, 33, 33);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (5, 10, 13);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (5, 11, 17);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (5, 11, 5);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (5, 11, 8);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (5, 13, 10);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (5, 14, 12);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (5, 14, 22);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (5, 14, 38);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (5, 18, 11);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (5, 2, 1);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (5, 21, 3);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (5, 25, 60);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (5, 27, 1);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (5, 27, 7);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (5, 27, 70);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (5, 29, 1);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (5, 29, 4);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (5, 33, 1);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (5, 5, 3);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (5, 6, 3);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (5, 8, 1);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (5, 8, 22);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (5, 8, 5);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (6, 10, 1);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (6, 11, 1);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (6, 17, 13);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (6, 17, 17);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (6, 17, 9);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (6, 18, 1);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (6, 23, 1);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (6, 23, 3);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (6, 24, 1);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (6, 25, 1);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (6, 25, 5);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (6, 26, 3);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (6, 3, 1);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (6, 5, 9);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (6, 6, 1);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (6, 8, 3);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (7, 12, 3);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (7, 21, 2);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (7, 22, 22);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (7, 26, 1);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (7, 30, 1);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (7, 31, 12);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (7, 32, 3);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (7, 32, 38);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (7, 4, 1);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (8, 13, 1);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (8, 15, 80);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (8, 22, 6);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (8, 32, 45);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (8, 7, 2);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (9, 16, 1);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (9, 31, 2);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (9, 31, 7);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (9, 7, 1);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (10, 14, 40);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (10, 19, 1);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (10, 22, 8);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (10, 26, 4);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (10, 26, 5);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (10, 28, 2);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (10, 29, 10);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (10, 31, 25);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (10, 34, 9);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (10, 39, 11);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (10, 40, 1);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (10, 40, 54);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (11, 12, 2);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (11, 17, 3);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (11, 22, 5);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (11, 28, 1);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (11, 32, 2);
INSERT INTO est_enlaces_subs (id_enlace, delegacion, subdelegacion) VALUES (11, 34, 1);

CREATE TABLE est_excel_escuela (
  id_excel_escuela    INT AUTO_INCREMENT,
  id_archivo          INT,
  curp                VARCHAR(50),
  nombre              VARCHAR(100),
  apellido_paterno    VARCHAR(100),
  apellido_materno    VARCHAR(100),
  sexo                VARCHAR(5),
  lugar_nacimiento    VARCHAR(50),
  dia_nacimiento      VARCHAR(50),
  mes_nacimiento      VARCHAR(50),
  anio_nacimiento     VARCHAR(50),
  codigo_postal       VARCHAR(10),
  correo_electronico  VARCHAR(100),
  telefono_celular    VARCHAR(50),
  PRIMARY KEY (id_excel_escuela),
  FOREIGN KEY (id_archivo) REFERENCES est_archivos(id_archivo)
)
  ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOAD DATA INFILE 'Z3710035323.txt' INTO TABLE est_excel_escuela
CHARACTER SET latin1   
FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' IGNORE 1 LINES
( curp, nombre, apellido_paterno, apellido_materno, 
  sexo, 
  lugar_nacimiento, dia_nacimiento, mes_nacimiento, anio_nacimiento,   
  codigo_postal, correo_electronico, telefono_celular)
SET id_archivo = 3 ;

CREATE TABLE est_excel_dspa (
  id_excel_dspa       INT AUTO_INCREMENT,
  id_archivo          INT,
  
  curp                VARCHAR(18) NOT NULL,
  nombre              VARCHAR(50) NOT NULL,
  apellido_paterno    VARCHAR(50) NOT NULL,
  apellido_materno    VARCHAR(50) NOT NULL,
  sexo                CHAR(1) NOT NULL,
  lugar_nacimiento    CHAR(2) NOT NULL,
  dia_nacimiento      TINYINT UNSIGNED NOT NULL,
  mes_nacimiento      TINYINT UNSIGNED NOT NULL,
  anio_nacimiento     INT NOT NULL,
  codigo_postal       CHAR(5) NOT NULL,
  correo_electronico  VARCHAR(100) NOT NULL,
  telefono_celular    VARCHAR(11) NOT NULL,
  PRIMARY KEY (id_excel_dspa),
  FOREIGN KEY (id_archivo) REFERENCES est_archivos(id_archivo),
  FOREIGN KEY (lugar_nacimiento) REFERENCES entidades_renapo(id_entidad_renapo)
)
  ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOAD DATA INFILE 'Z3710035323.txt' INTO TABLE est_excel_dspa
CHARACTER SET latin1   
FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' IGNORE 1 LINES
( curp, nombre, apellido_paterno, apellido_materno, sexo, 
  lugar_nacimiento, dia_nacimiento, mes_nacimiento, anio_nacimiento, 
  codigo_postal,  correo_electronico, telefono_celular)
SET id_archivo=3;

CREATE TABLE est_layout_didtB (
  id_layout_didt    INT AUTO_INCREMENT,
  id_archivo        INT,

  ciz               TINYINT UNSIGNED NOT NULL,
  delegacion        TINYINT UNSIGNED NOT NULL,
  subdelegacion     TINYINT UNSIGNED NOT NULL,
  apellido_paterno  CHAR(27) NOT NULL,
  apellido_materno  CHAR(27) NOT NULL,
  nombre            CHAR(35) NOT NULL,
  sexo              CHAR(1) NOT NULL,
  mes_nacimiento    CHAR(2) NOT NULL,
  lugar_nacimiento  CHAR(2) NOT NULL,
  anio_nacimiento   CHAR(4) NOT NULL,
  curp              CHAR(18) NOT NULL,
  id_prospera       INT NOT NULL,
  PRIMARY KEY (id_layout_didt),
  INDEX lugar_nacimiento_FI_1 (lugar_nacimiento),
  FOREIGN KEY (id_archivo) REFERENCES est_archivos(id_archivo),
  FOREIGN KEY (delegacion)                REFERENCES delegaciones(delegacion),
  FOREIGN KEY (delegacion, subdelegacion) REFERENCES subdelegaciones(delegacion, subdelegacion)
)
  ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE est_layout_didtJC (
  id_layout_didt    INT AUTO_INCREMENT,
  id_archivo        INT,

  ciz               TINYINT UNSIGNED NOT NULL,
  delegacion        TINYINT UNSIGNED NOT NULL,
  subdelegacion     TINYINT UNSIGNED NOT NULL,
  apellido_paterno  CHAR(27) NOT NULL,
  apellido_materno  CHAR(27) NOT NULL,
  nombre            CHAR(35) NOT NULL,
  nombre2           CHAR(35) NOT NULL,

  sexo              CHAR(1) NOT NULL,
  fecha_nacimiento  DATE NOT NULL,
  lugar_nacimiento  CHAR(2) NOT NULL,
  grado             VARCHAR(40) NOT NULL,
  codigo_postal     CHAR(5) NOT NULL,
  curp              CHAR(18) NOT NULL,

  PRIMARY KEY (id_layout_didt),
  INDEX lugar_nacimiento_FI_1 (lugar_nacimiento),
  FOREIGN KEY (id_archivo) REFERENCES est_archivos(id_archivo),
  FOREIGN KEY (delegacion)                REFERENCES delegaciones(delegacion),
  FOREIGN KEY (delegacion, subdelegacion) REFERENCES subdelegaciones(delegacion, subdelegacion)
)
  ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO est_layout_didt (id_archivo, delegacion, subdelegacion, apellido_paterno, apellido_materno, nombre, 
  sexo, mes_nacimiento, lugar_nacimiento, anio_nacimiento, curp) 
(SELECT 3, SUBSTR(CONCAT("00", est_rps.delegacion), -2) AS delegacion, SUBSTR(CONCAT("00", est_rps.subdelegacion), -2) AS subdelegacion, 
      est_excel_dspa.apellido_paterno, est_excel_dspa.apellido_materno, est_excel_dspa.nombre, 
      IF(est_excel_dspa.sexo = "H", 1,  IF(est_excel_dspa.sexo = "M", 2, 0)) AS sexo, SUBSTR(CONCAT("00", est_excel_dspa.mes_nacimiento), -2) AS mes_nacimiento,
      SUBSTR(CONCAT("00", entidades_renapo.id_lugar_nacimiento), -2) AS lugar_nacimiento, est_excel_dspa.anio_nacimiento, est_excel_dspa.curp
    FROM est_excel_dspa, est_archivos, est_rps, entidades_renapo
    WHERE est_excel_dspa.id_archivo       = est_archivos.id_archivo
      AND est_archivos.id_rp              = est_rps.id_rp
      AND est_excel_dspa.lugar_nacimiento = entidades_renapo.id_entidad_renapo
      AND est_archivos.id_archivo = 3 );

INSERT INTO est_layout_didtB (id_archivo, id_prospera, ciz, delegacion, subdelegacion, apellido_paterno, apellido_materno, nombre, 
  sexo, mes_nacimiento, lugar_nacimiento, anio_nacimiento, curp) 
( SELECT id_archivo, 0, 0, delegacion, subdelegacion, apellido_paterno, apellido_materno, nombre,
  sexo, MONTH(fecha_nacimiento), lugar_nacimiento, YEAR(fecha_nacimiento), curp
FROM est_layout_didtJC
WHERE id_archivo=9 )

LOAD DATA INFILE 'coincidentes_benef.txt' INTO TABLE est_layout_didt

LOAD DATA INFILE 'Muestra_Coincidentes_benef.txt' INTO TABLE est_layout_didt


LOAD DATA INFILE 'Coincidentes_PISP.txt' INTO TABLE est_layout_didtP
LOAD DATA INFILE 'coincidentes_benef.txt' INTO TABLE est_layout_didtB

LOAD DATA INFILE 'UDEG_CURP_ACT.txt' INTO TABLE est_layout_didtJC
CHARACTER SET latin1   
FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' 
( curp, nombre, apellido_paterno, apellido_materno, nombre2, sexo, 
  @var1, lugar_nacimiento, grado, codigo_postal)
SET 
  id_archivo = 8, 
  delegacion = 0,
  subdelegacion = 0,
  ciz=0,
  fecha_nacimiento = STR_TO_DATE(@var1, '%Y-%m-%d');

LOAD DATA INFILE 'UDEG_SIN_DIF.txt' INTO TABLE est_layout_didtJC
CHARACTER SET latin1   
FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' 
( curp, nombre, apellido_paterno, apellido_materno, nombre2, sexo, 
  @var1, lugar_nacimiento, grado, codigo_postal)
SET 
  id_archivo = 9, 
  delegacion = 0,
  subdelegacion = 0,
  ciz=0,
  fecha_nacimiento = STR_TO_DATE(@var1, '%Y-%m-%d');



LOAD DATA INFILE 'Estudiantes.TXT'
  INTO TABLE est_confronta_renapo
CHARACTER SET latin1   
FIELDS TERMINATED BY '|' ENCLOSED BY '' ESCAPED BY '\\'
LINES TERMINATED BY '\n' STARTING BY ''
( bande, clave,
  curp, primer_apellido, segundo_apellido, nombre,
  sexo, @var1, entidad_nacimiento, nacionalidad,
  tipo_docto_prob, anio_registro,
  foja, tomo, libro, acta, crip,
  entidad_registro, municipio_registro,
  num_registro_ext,
  folio_carta_nat, folio_cert_nac_mex,
  clave_ent_emisora, folio_constancia, @var2, 
  estatus_curp, estatus_confiab, estatus_compara, datos_confrontados, vivencia,
  basura
  )
SET id_archivo=4, fecha_nacimiento = STR_TO_DATE(@var1, '%d/%m/%Y'), fecha_constancia = STR_TO_DATE(@var2, '%d/%m/%Y');

















UPDATE est_layout_didtB
SET delegacion = ( SELECT AA.del FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didtB.lugar_nacimiento = AA.lugar_nacimiento),
 subdelegacion = ( SELECT AA.subdel FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didtB.lugar_nacimiento = AA.lugar_nacimiento),
 ciz = ( SELECT AA.ciz FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didtB.lugar_nacimiento = AA.lugar_nacimiento)
 WHERE id_archivo = 9 OR id_archivo = 8;

SELECT 
  CONCAT(ciz, SUBSTR(CONCAT("00", delegacion), -2), SUBSTR(CONCAT("00", subdelegacion), -2), "00000000000",
    SUBSTR(CONCAT(apellido_paterno, "                           "), 1, 27),
    SUBSTR(CONCAT(apellido_materno, "                           "), 1, 27),
    SUBSTR(CONCAT(nombre, "                                   "), 1, 35),
    B.id_sexo, SUBSTR(CONCAT("00", mes_nacimiento), -2), SUBSTR(CONCAT("00", id_lugar_nacimiento), -2), SUBSTR(anio_nacimiento, -2),
    "ESTUDIA", "000", curp, "               ", 9)
FROM est_layout_didtB A, sexo B, entidades_renapo C
WHERE A.sexo = B.id_alf_sexo
AND A.lugar_nacimiento = C.id_entidad_renapo
AND A.id_archivo = 8
INTO OUTFILE 'BLayout UDEG 7582reg.txt' FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n';

SELECT 
  CONCAT(ciz, SUBSTR(CONCAT("00", delegacion), -2), SUBSTR(CONCAT("00", subdelegacion), -2), "00000000000",
    SUBSTR(CONCAT(apellido_paterno, "                           "), 1, 27),
    SUBSTR(CONCAT(apellido_materno, "                           "), 1, 27),
    SUBSTR(CONCAT(nombre, "                                   "), 1, 35),
    B.id_sexo, SUBSTR(CONCAT("00", mes_nacimiento), -2), SUBSTR(CONCAT("00", id_lugar_nacimiento), -2), SUBSTR(anio_nacimiento, -2),
    "ESTUDIA", "000", curp, "               ", 9)
FROM est_layout_didtB A, sexo B, entidades_renapo C
WHERE A.sexo = B.id_alf_sexo
AND A.lugar_nacimiento = C.id_entidad_renapo
AND A.id_archivo = 9
INTO OUTFILE 'BLayout UDEG 233036reg.txt' FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n';

mysql> UPDATE est_layout_didtB SET apellido_paterno = REPLACE(apellido_paterno,
'Ñ', '#') where id_archivo=8 and curp='VILO991022HJCLPS07';


SELECT 
  CONCAT(ciz, SUBSTR(CONCAT("00", delegacion), -2), SUBSTR(CONCAT("00", subdelegacion), -2), "00000000000",
    SUBSTR(CONCAT(apellido_paterno, "                           "), 1, 27),
    SUBSTR(CONCAT(apellido_materno, "                           "), 1, 27),
    SUBSTR(CONCAT(nombre, "                                   "), 1, 35),
    B.id_sexo, SUBSTR(CONCAT("00", mes_nacimiento), -2), SUBSTR(CONCAT("00", id_lugar_nacimiento), -2), SUBSTR(anio_nacimiento, -2),
    "PROSPER", "000", curp, "               ", 9)
FROM est_layout_didtB A, sexo B, entidades_renapo C
WHERE A.sexo = B.id_alf_sexo
AND A.lugar_nacimiento = C.id_entidad_renapo
AND A.anio_nacimiento BETWEEN 0 AND 1962
INTO OUTFILE 'prospera_benef 1900-1962.txt' FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n';

SELECT 
  CONCAT(ciz, SUBSTR(CONCAT("00", delegacion), -2), SUBSTR(CONCAT("00", subdelegacion), -2), "00000000000",
    SUBSTR(CONCAT(apellido_paterno, "                           "), 1, 27),
    SUBSTR(CONCAT(apellido_materno, "                           "), 1, 27),
    SUBSTR(CONCAT(nombre, "                                   "), 1, 35),
    B.id_sexo, SUBSTR(CONCAT("00", mes_nacimiento), -2), SUBSTR(CONCAT("00", id_lugar_nacimiento), -2), SUBSTR(anio_nacimiento, -2),
    "PROSPER", "000", curp, "               ", 9)
FROM est_layout_didtB A, sexo B, entidades_renapo C
WHERE A.sexo = B.id_alf_sexo
AND A.lugar_nacimiento = C.id_entidad_renapo
INTO OUTFILE 'prospera_benef.txt' FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n';

SELECT 
  CONCAT(ciz, SUBSTR(CONCAT("00", delegacion), -2), SUBSTR(CONCAT("00", subdelegacion), -2), "00000000000",
    SUBSTR(CONCAT(apellido_paterno, "                           "), 1, 27),
    SUBSTR(CONCAT(apellido_materno, "                           "), 1, 27),
    SUBSTR(CONCAT(nombre, "                                   "), 1, 35),
    B.id_sexo, SUBSTR(CONCAT("00", mes_nacimiento), -2), SUBSTR(CONCAT("00", id_lugar_nacimiento), -2), SUBSTR(anio_nacimiento, -2),
    "PROSPER", "000", curp, "               ", 9)
FROM est_layout_didtB A, sexo B, entidades_renapo C
WHERE A.sexo = B.id_alf_sexo
AND A.lugar_nacimiento = C.id_entidad_renapo
AND A.anio_nacimiento BETWEEN 1963 AND 1976
INTO OUTFILE 'prospera_benef 1963-1976.txt' FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n';

SELECT 
  CONCAT(ciz, SUBSTR(CONCAT("00", delegacion), -2), SUBSTR(CONCAT("00", subdelegacion), -2), "00000000000",
    SUBSTR(CONCAT(apellido_paterno, "                           "), 1, 27),
    SUBSTR(CONCAT(apellido_materno, "                           "), 1, 27),
    SUBSTR(CONCAT(nombre, "                                   "), 1, 35),
    B.id_sexo, SUBSTR(CONCAT("00", mes_nacimiento), -2), SUBSTR(CONCAT("00", id_lugar_nacimiento), -2), SUBSTR(anio_nacimiento, -2),
    "PROSPER", "000", curp, "               ", 9)
FROM est_layout_didtB A, sexo B, entidades_renapo C
WHERE A.sexo = B.id_alf_sexo
AND A.lugar_nacimiento = C.id_entidad_renapo
AND A.anio_nacimiento BETWEEN 1977 AND 1986
INTO OUTFILE 'prospera_benef 1977-1986.txt' FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n';

SELECT 
  CONCAT(ciz, SUBSTR(CONCAT("00", delegacion), -2), SUBSTR(CONCAT("00", subdelegacion), -2), "00000000000",
    SUBSTR(CONCAT(apellido_paterno, "                           "), 1, 27),
    SUBSTR(CONCAT(apellido_materno, "                           "), 1, 27),
    SUBSTR(CONCAT(nombre, "                                   "), 1, 35),
    B.id_sexo, SUBSTR(CONCAT("00", mes_nacimiento), -2), SUBSTR(CONCAT("00", id_lugar_nacimiento), -2), SUBSTR(anio_nacimiento, -2),
    "PROSPER", "000", curp, "               ", 9)
FROM est_layout_didtB A, sexo B, entidades_renapo C
WHERE A.sexo = B.id_alf_sexo
AND A.lugar_nacimiento = C.id_entidad_renapo
AND A.anio_nacimiento BETWEEN 1987 AND 1994
INTO OUTFILE 'prospera_benef 1987-1994.txt' FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n';

SELECT 
  CONCAT(ciz, SUBSTR(CONCAT("00", delegacion), -2), SUBSTR(CONCAT("00", subdelegacion), -2), "00000000000",
    SUBSTR(CONCAT(apellido_paterno, "                           "), 1, 27),
    SUBSTR(CONCAT(apellido_materno, "                           "), 1, 27),
    SUBSTR(CONCAT(nombre, "                                   "), 1, 35),
    B.id_sexo, SUBSTR(CONCAT("00", mes_nacimiento), -2), SUBSTR(CONCAT("00", id_lugar_nacimiento), -2), SUBSTR(anio_nacimiento, -2),
    "PROSPER", "000", curp, "               ", 9)
FROM est_layout_didtB A, sexo B, entidades_renapo C
WHERE A.sexo = B.id_alf_sexo
AND A.lugar_nacimiento = C.id_entidad_renapo
AND A.anio_nacimiento BETWEEN 1995 AND 2000
INTO OUTFILE 'prospera_benef 1995-2000.txt' FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n';

SELECT 
  CONCAT(ciz, SUBSTR(CONCAT("00", delegacion), -2), SUBSTR(CONCAT("00", subdelegacion), -2), "00000000000",
    SUBSTR(CONCAT(apellido_paterno, "                           "), 1, 27),
    SUBSTR(CONCAT(apellido_materno, "                           "), 1, 27),
    SUBSTR(CONCAT(nombre, "                                   "), 1, 35),
    B.id_sexo, SUBSTR(CONCAT("00", mes_nacimiento), -2), SUBSTR(CONCAT("00", id_lugar_nacimiento), -2), SUBSTR(anio_nacimiento, -2),
    "PROSPER", "000", curp, "               ", 9)
FROM est_layout_didtB A, sexo B, entidades_renapo C
WHERE A.sexo = B.id_alf_sexo
AND A.lugar_nacimiento = C.id_entidad_renapo
AND A.anio_nacimiento BETWEEN 2001 AND 2006
INTO OUTFILE 'prospera_benef 2001-2006.txt' FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n';

SELECT 
  CONCAT(ciz, SUBSTR(CONCAT("00", delegacion), -2), SUBSTR(CONCAT("00", subdelegacion), -2), "00000000000",
    SUBSTR(CONCAT(apellido_paterno, "                           "), 1, 27),
    SUBSTR(CONCAT(apellido_materno, "                           "), 1, 27),
    SUBSTR(CONCAT(nombre, "                                   "), 1, 35),
    B.id_sexo, SUBSTR(CONCAT("00", mes_nacimiento), -2), SUBSTR(CONCAT("00", id_lugar_nacimiento), -2), SUBSTR(anio_nacimiento, -2),
    "PROSPER", "000", curp, "               ", 9)
FROM est_layout_didtB A, sexo B, entidades_renapo C
WHERE A.sexo = B.id_alf_sexo
AND A.lugar_nacimiento = C.id_entidad_renapo
AND A.anio_nacimiento BETWEEN 2007 AND 2015
INTO OUTFILE 'prospera_benef 2007-2015.txt' FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n';










CREATE TABLE entidades_renapo (
  id_entidad_renapo   CHAR(2) NOT NULL,
  id_lugar_nacimiento CHAR(2) NOT NULL,
  descripcion         VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_entidad_renapo)


SELECT 
  ciz AS CIZ,
  SUBSTR(CONCAT("00", delegacion), -2) AS DELEGACION,
  SUBSTR(CONCAT("00", subdelegacion), -2) AS SUBDELEGACION,
  "00000000000" AS NSS,
  SUBSTR(CONCAT("                          ", apellido_paterno), 27) AS APELLIDO_PATERNO,
  SUBSTR(CONCAT("                          ", apellido_materno), 27) AS APELLIDO_MATERNO,
  SUBSTR(CONCAT("                                   ", nombre), 35) AS NOMBRE,
  sexo AS sexo,
  SUBSTR(CONCAT("00", mes_nacimiento), -2) AS MES_NACIMIENTO,
  SUBSTR(CONCAT("00", lugar_nacimiento), -2) AS LUGAR_NACIMIENTO,
  anio_nacimiento AS ANIO_NACIMIENTO,
  "PROSPER" AS USUARIO_CONVENCIONAL,
  "000" AS UMF,
  curp AS CURP,
  "               " AS ID_REGISTRO_PATRON,
  9 AS ESTATUS_SOLICITUD
FROM est_layout_didt
WHERE id_archivo = 6;




SELECT DISTINCT A.lugar_nacimiento, A.ciz, B.ciz, B.descripcion AS del, C.descripcion AS subdel
FROM est_layout_didt A, subdelegaciones C, delegaciones B
WHERE A.delegacion = C.delegacion
AND A.subdelegacion = C.subdelegacion
AND A.delegacion = B.delegacion
AND B.delegacion = C.delegacion
ORDER BY 2;







LOAD DATA INFILE 'Muestra_Coincidentes_benef.txt' INTO TABLE est_layout_didt
CHARACTER SET latin1   
FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' 
( apellido_paterno, apellido_materno, nombre, sexo, 
  mes_nacimiento, lugar_nacimiento, anio_nacimiento, curp, id_prospera)
SET 
  id_archivo = 6, 
  delegacion    = ( SELECT AA.del FROM tmp_table_ciz_del_subdel AA WHERE lugar_nacimiento = AA.lugar_nacimiento ), 
  subdelegacion = ( SELECT AA.subdel FROM tmp_table_ciz_del_subdel AA WHERE lugar_nacimiento = AA.lugar_nacimiento );
   ,
  ciz = ( SELECT AA.ciz FROM tmp_table_ciz_del_subdel AA WHERE lugar_nacimiento = AA.lugar_nacimiento AND AA.del = delegacion AND AA.subdel = subdelegacion) ;


UPDATE est_layout_didt 
SET delegacion = 9, subdelegacion=16 WHERE est_layout_didt.lugar_nacimiento = "NE"

UPDATE est_layout_didt 
SET delegacion = ( SELECT AA.del FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didt.lugar_nacimiento = AA.lugar_nacimiento),
 subdelegacion = ( SELECT AA.subdel FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didt.lugar_nacimiento = AA.lugar_nacimiento),
 ciz = ( SELECT AA.ciz FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didt.lugar_nacimiento = AA.lugar_nacimiento);

UPDATE est_layout_didt 
SET subdelegacion = ( SELECT AA.subdel FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didt.lugar_nacimiento = AA.lugar_nacimiento);


SELECT DISTINCT BB.lugar_nacimiento, AA.del FROM tmp_table_ciz_del_subdel AA, est_layout_didt BB 
WHERE AA.lugar_nacimiento = BB.lugar_nacimiento ORDER BY 2; 


  delegacion    = ( SELECT AA.del FROM tmp_table_ciz_del_subdel AA WHERE lugar_nacimiento = AA.lugar_nacimiento ), 
  subdelegacion = ( SELECT AA.subdel FROM tmp_table_ciz_del_subdel AA WHERE lugar_nacimiento = AA.lugar_nacimiento AND AA.del = (SELECT AA.del FROM tmp_table_ciz_del_subdel AA WHERE lugar_nacimiento = AA.lugar_nacimiento))
   ,
  ciz = ( SELECT AA.ciz FROM tmp_table_ciz_del_subdel AA WHERE lugar_nacimiento = AA.lugar_nacimiento AND AA.del = delegacion AND AA.subdel = subdelegacion) ;

SELECT A.lugar_nacimiento, B.id_entidad_renapo, B.descripcion,
  C.entidad_imss, C.ciz, C.delegacion, D.subdelegacion
FROM est_layout_didt A, entidades_renapo B, delegaciones C, subdelegaciones D 
WHERE 
  A.lugar_nacimiento = B.id_entidad_renapo
AND B.id_lugar_nacimiento = C.entidad_imss
GROUP BY A.lugar_nacimiento, B.id_entidad_renapo, B.descripcion,
  C.entidad_imss, C.delegacion
ORDER BY C.entidad_imss;

CREATE OR REPLACE VIEW view_ciz_del_subdel AS
SELECT C.ciz AS ciz, A.lugar_nacimiento AS lugar_nacimiento, B.descripcion AS entidad,
  C.entidad_imss AS num_entidad, 
  (SELECT delegacion FROM delegaciones WHERE entidad_imss = C.entidad_imss AND delegacion <> 9 AND activo = 1 LIMIT 1) AS del, 
  (SELECT subdelegacion FROM subdelegaciones WHERE DEL = delegacion AND subdelegacion <> 0 AND subdelegacion <>'' LIMIT 1) AS subdel
FROM est_layout_didt A, entidades_renapo B, delegaciones C
WHERE 
  A.lugar_nacimiento = B.id_entidad_renapo
AND B.id_lugar_nacimiento * 1 = C.entidad_imss
GROUP BY 
  C.ciz, A.lugar_nacimiento, B.descripcion,
  C.entidad_imss,
  (SELECT delegacion FROM delegaciones WHERE entidad_imss = C.entidad_imss AND delegacion <> 9 AND activo = 1 LIMIT 1), 
  (SELECT subdelegacion FROM subdelegaciones WHERE DEL = delegacion AND subdelegacion <> 0 AND subdelegacion <>'' LIMIT 1)
ORDER BY C.entidad_imss
INTO OUTFILE 'tmp_ciz_.txt' FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n';;

CREATE TABLE tmp_table_ciz_del_subdel AS
SELECT C.ciz AS ciz, A.lugar_nacimiento AS lugar_nacimiento, B.descripcion AS entidad,
  C.entidad_imss AS num_entidad, 
  (SELECT delegacion FROM delegaciones WHERE entidad_imss = C.entidad_imss AND delegacion <> 9 AND activo = 1 LIMIT 1) AS del, 
  (SELECT subdelegacion FROM subdelegaciones WHERE DEL = delegacion AND subdelegacion <> 0 AND subdelegacion <>'' LIMIT 1) AS subdel
FROM est_layout_didt A, entidades_renapo B, delegaciones C
WHERE 
  A.lugar_nacimiento = B.id_entidad_renapo
AND B.id_lugar_nacimiento * 1 = C.entidad_imss
GROUP BY 
  C.ciz, A.lugar_nacimiento, B.descripcion,
  C.entidad_imss,
  (SELECT delegacion FROM delegaciones WHERE entidad_imss = C.entidad_imss AND delegacion <> 9 AND activo = 1 LIMIT 1), 
  (SELECT subdelegacion FROM subdelegaciones WHERE DEL = delegacion AND subdelegacion <> 0 AND subdelegacion <>'' LIMIT 1)
ORDER BY C.entidad_imss




  CREATE TABLE entidades_renapo (
  id_entidad_renapo   CHAR(2) NOT NULL,
  id_lugar_nacimiento CHAR(2) NOT NULL,
  descripcion         VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_entidad_renapo)
)
  ENGINE=InnoDB DEFAULT CHARSET=latin1;



CREATE TABLE coincidentes_benef (
  id_coincidentes_benef INT AUTO_INCREMENT,
  id_archivo          INT,

  primer_apellido     CHAR(50),
  segundo_apellido    CHAR(50),
  nombre              CHAR(50),
  sexo                CHAR(1),
  mes_nacimiento      CHAR
  curp                CHAR(18),

  fecha_nacimiento    DATE,
  entidad_nacimiento  CHAR(2),
  nacionalidad        CHAR(3),
  tipo_docto_prob     CHAR(1),
  anio_registro       CHAR(4),
  foja                CHAR(5),
  tomo                CHAR(3),
  libro               CHAR(4),
  acta                CHAR(5),
  crip                CHAR(15),
  entidad_registro    CHAR(2),
  municipio_registro  CHAR(3),
  num_registro_ext    CHAR(7),
  folio_carta_nat     CHAR(5),
  folio_cert_nac_mex  CHAR(5),
  clave_ent_emisora   CHAR(14),
  folio_constancia    CHAR(9),
  fecha_constancia    DATE,
  estatus_curp        CHAR(3),
  estatus_confiab     CHAR(3),
  estatus_compara     CHAR(3),
  datos_confrontados  CHAR(50),
  vivencia            CHAR(3),
  basura              CHAR(10),
  PRIMARY KEY (id_confronta_renapo),
  FOREIGN KEY (id_archivo) REFERENCES est_archivos(id_archivo)
)
  ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOAD DATA INFILE 'Estudiantes.TXT'
  INTO TABLE est_confronta_renapo
CHARACTER SET latin1   
FIELDS TERMINATED BY '|' ENCLOSED BY '' ESCAPED BY '\\'
LINES TERMINATED BY '\n' STARTING BY ''
( bande, clave,
  curp, primer_apellido, segundo_apellido, nombre,
  sexo, @var1, entidad_nacimiento, nacionalidad,
  tipo_docto_prob, anio_registro,
  foja, tomo, libro, acta, crip,
  entidad_registro, municipio_registro,
  num_registro_ext,
  folio_carta_nat, folio_cert_nac_mex,
  clave_ent_emisora, folio_constancia, @var2, 
  estatus_curp, estatus_confiab, estatus_compara, datos_confrontados, vivencia,
  basura
  )
SET id_archivo=4, fecha_nacimiento = STR_TO_DATE(@var1, '%d/%m/%Y'), fecha_constancia = STR_TO_DATE(@var2, '%d/%m/%Y');

CREATE OR REPLACE VIEW view_confronta_dspa AS
SELECT id_confronta_renapo, id_archivo, clave, curp, primer_apellido, segundo_apellido, nombre, 
    sexo, fecha_nacimiento, entidad_nacimiento, nacionalidad
    FROM est_confronta_renapo;


--Seleccionar registros que sean iguales en datos PISP vs RENAPO_CONFRONTA
SELECT  id_confronta_renapo, id_archivo, clave, A.curp, primer_apellido, segundo_apellido, nombre, 
    A.sexo, fecha_nacimiento, A.entidad_nacimiento, B.clave_estado, C.id_entidad_renapo
    FROM est_confronta_renapo A, prospera_pisp B, entidades_renapo C, sexo D
  WHERE A.curp              = B.curp
  AND   A.primer_apellido   = B.apellido_paterno
  AND   A.segundo_apellido  = B.apellido_materno
  AND   A.nombre            = B.nombres
  AND   A.sexo              = D.id_alf_sexo
  AND   B.sexo              = D.id_sexo
  AND   B.clave_estado      = C.id_lugar_nacimiento
  AND   A.entidad_nacimiento= C.id_entidad_renapo ;

SELECT COUNT(A.curp)
    FROM est_confronta_renapo A, prospera_pisp B, entidades_renapo C, sexo D
  WHERE A.curp              = B.curp
  AND   A.primer_apellido   = B.apellido_paterno
  AND   A.segundo_apellido  = B.apellido_materno
  AND   A.nombre            = B.nombres
  AND   A.sexo              = D.id_alf_sexo
  AND   B.sexo              = D.id_sexo
  AND   B.clave_estado      = C.id_lugar_nacimiento
  AND   A.entidad_nacimiento= C.id_entidad_renapo ;

CREATE TABLE prospera_pisp (
  row               INT AUTO_INCREMENT,
  id                CHAR(9),
  curp              CHAR(18),
  nombres           VARCHAR(40),
  apellido_paterno  VARCHAR(40),
  apellido_materno  VARCHAR(40),
  sexo              INT,
  clave_estado      CHAR(2),
  nivel             VARCHAR(22),
  grado             VARCHAR(31),
  PRIMARY KEY (row),
  FOREIGN KEY (sexo) REFERENCES sexo(id_sexo),
  FOREIGN KEY (clave_estado) REFERENCES entidades_renapo(id_entidad_renapo)
)
ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOAD DATA INFILE 'PISP-ESTUDIANTES-270116.txt'
INTO TABLE prospera_pisp
CHARACTER SET latin1 
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"'
LINES STARTING BY '' TERMINATED BY '\n'
( id,
  curp,
  nombres,
  apellido_paterno,
  apellido_materno,
  @dato1,
  @dato2,
  nivel,
  grado
  )
SET 
sexo = (SELECT id_sexo FROM sexo WHERE descripcion = @dato1) ,
clave_estado = (SELECT id_entidad_renapo FROM entidades_renapo WHERE @dato2 = id_lugar_nacimiento) ;

SHOW WARNINGS;



-- 03-Marzo-2016 Proceso CAMPECHE --

LOAD DATA INFILE 'CAMPECHE_CURP_ACT.txt' INTO TABLE est_layout_didtB
CHARACTER SET latin1   
FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' 
( curp, nombre, apellido_paterno, apellido_materno, sexo, 
  @var1, lugar_nacimiento )
SET 
  id_archivo = 10,
  ciz=0,
  delegacion = 0,
  subdelegacion = 0,
  id_prospera = 0,
  mes_nacimiento = MONTH( STR_TO_DATE(@var1, '%Y-%m-%d') ),
  anio_nacimiento = YEAR( STR_TO_DATE(@var1, '%Y-%m-%d') );

LOAD DATA INFILE 'CAMPECHE_SIN_DIF.txt' INTO TABLE est_layout_didtB
CHARACTER SET latin1   
FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' 
( curp, nombre, apellido_paterno, apellido_materno, sexo, 
  @var1, lugar_nacimiento )
SET 
  id_archivo = 11,
  ciz=0,
  delegacion = 0,
  subdelegacion = 0,
  id_prospera = 0,
  mes_nacimiento = MONTH( STR_TO_DATE(@var1, '%Y-%m-%d') ),
  anio_nacimiento = YEAR( STR_TO_DATE(@var1, '%Y-%m-%d') );

UPDATE est_layout_didtB
SET delegacion = ( SELECT AA.del FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didtB.lugar_nacimiento = AA.lugar_nacimiento),
 subdelegacion = ( SELECT AA.subdel FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didtB.lugar_nacimiento = AA.lugar_nacimiento),
 ciz = ( SELECT AA.ciz FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didtB.lugar_nacimiento = AA.lugar_nacimiento)
 WHERE id_archivo = 10 OR id_archivo = 11;

SELECT 
  CONCAT(ciz, SUBSTR(CONCAT("00", delegacion), -2), SUBSTR(CONCAT("00", subdelegacion), -2), "00000000000",
    SUBSTR(CONCAT(apellido_paterno, "                           "), 1, 27),
    SUBSTR(CONCAT(apellido_materno, "                           "), 1, 27),
    SUBSTR(CONCAT(nombre, "                                   "), 1, 35),
    B.id_sexo, SUBSTR(CONCAT("00", mes_nacimiento), -2), SUBSTR(CONCAT("00", id_lugar_nacimiento), -2), SUBSTR(anio_nacimiento, -2),
    "ESTUDIA", "000", curp, "               ", 9)
FROM est_layout_didtB A, sexo B, entidades_renapo C
WHERE A.sexo              = B.id_alf_sexo
AND   A.lugar_nacimiento  = C.id_entidad_renapo
AND   A.id_archivo        = 10
INTO OUTFILE 'L_Campeche01_CURP_ACT.txt' FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n';

SELECT 
  CONCAT(ciz, SUBSTR(CONCAT("00", delegacion), -2), SUBSTR(CONCAT("00", subdelegacion), -2), "00000000000",
    SUBSTR(CONCAT(apellido_paterno, "                           "), 1, 27),
    SUBSTR(CONCAT(apellido_materno, "                           "), 1, 27),
    SUBSTR(CONCAT(nombre, "                                   "), 1, 35),
    B.id_sexo, SUBSTR(CONCAT("00", mes_nacimiento), -2), SUBSTR(CONCAT("00", id_lugar_nacimiento), -2), SUBSTR(anio_nacimiento, -2),
    "ESTUDIA", "000", curp, "               ", 9)
FROM est_layout_didtB A, sexo B, entidades_renapo C
WHERE A.sexo              = B.id_alf_sexo
AND   A.lugar_nacimiento  = C.id_entidad_renapo
AND   A.id_archivo        = 11
INTO OUTFILE 'L_Campeche01_SIN_DIF.txt' FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n';

-- 04-Marzo-2016 Proceso QUINTANA ROO --

INSERT INTO est_archivos (nombre_archivo, id_rp, id_enlace, fecha_recepcion, comentario) VALUES ('QROO_CURP_ACT.txt', 1, 12, NOW(), '1,495 registros');
INSERT INTO est_archivos (nombre_archivo, id_rp, id_enlace, fecha_recepcion, comentario) VALUES ('QROO_SIN_DIF.txt', 1, 12, NOW(), '52,495 registros');

Layout JC:
CURP
NOMBRE
PRIMER_AP
SEGUNDO_AP
SEXO
FEC_NAC (YYYY-MM-DD)
LUGAR_NAC

Ejemplo:
VAOE980923MQRRSL06|ELIAZITH SINAI|VARGUEZ|OSORIO|M|1998-09-23|QR

LOAD DATA INFILE 'QROO_CURP_ACT.txt' INTO TABLE est_layout_didtB
CHARACTER SET latin1   
FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' 
( curp, nombre, apellido_paterno, apellido_materno, sexo, 
  @var1, lugar_nacimiento )
SET 
  id_archivo = 12,
  ciz=0,
  delegacion = 0,
  subdelegacion = 0,
  id_prospera = 0,
  mes_nacimiento = MONTH( STR_TO_DATE(@var1, '%Y-%m-%d') ),
  anio_nacimiento = YEAR( STR_TO_DATE(@var1, '%Y-%m-%d') );

LOAD DATA INFILE 'QROO_SIN_DIF.txt' INTO TABLE est_layout_didtB
CHARACTER SET latin1   
FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' 
( curp, nombre, apellido_paterno, apellido_materno, sexo, 
  @var1, lugar_nacimiento )
SET 
  id_archivo = 13,
  ciz=0,
  delegacion = 0,
  subdelegacion = 0,
  id_prospera = 0,
  mes_nacimiento = MONTH( STR_TO_DATE(@var1, '%Y-%m-%d') ),
  anio_nacimiento = YEAR( STR_TO_DATE(@var1, '%Y-%m-%d') );

UPDATE est_layout_didtB
SET delegacion = ( SELECT AA.del FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didtB.lugar_nacimiento = AA.lugar_nacimiento),
 subdelegacion = ( SELECT AA.subdel FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didtB.lugar_nacimiento = AA.lugar_nacimiento),
 ciz = ( SELECT AA.ciz FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didtB.lugar_nacimiento = AA.lugar_nacimiento)
 WHERE id_archivo = 12 OR id_archivo = 13;

SELECT 
  CONCAT(ciz, SUBSTR(CONCAT("00", delegacion), -2), SUBSTR(CONCAT("00", subdelegacion), -2), "00000000000",
    SUBSTR(CONCAT(apellido_paterno, "                           "), 1, 27),
    SUBSTR(CONCAT(apellido_materno, "                           "), 1, 27),
    SUBSTR(CONCAT(nombre, "                                   "), 1, 35),
    B.id_sexo, SUBSTR(CONCAT("00", mes_nacimiento), -2), SUBSTR(CONCAT("00", id_lugar_nacimiento), -2), SUBSTR(anio_nacimiento, -2),
    "ESTUDIA", "000", curp, "               ", 9)
FROM est_layout_didtB A, sexo B, entidades_renapo C
WHERE A.sexo              = B.id_alf_sexo
AND   A.lugar_nacimiento  = C.id_entidad_renapo
AND   A.id_archivo        = 12
INTO OUTFILE 'L_QuintanaRoo01_CURP_ACT.txt' FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n';

SELECT 
  CONCAT(ciz, SUBSTR(CONCAT("00", delegacion), -2), SUBSTR(CONCAT("00", subdelegacion), -2), "00000000000",
    SUBSTR(CONCAT(apellido_paterno, "                           "), 1, 27),
    SUBSTR(CONCAT(apellido_materno, "                           "), 1, 27),
    SUBSTR(CONCAT(nombre, "                                   "), 1, 35),
    B.id_sexo, SUBSTR(CONCAT("00", mes_nacimiento), -2), SUBSTR(CONCAT("00", id_lugar_nacimiento), -2), SUBSTR(anio_nacimiento, -2),
    "ESTUDIA", "000", curp, "               ", 9)
FROM est_layout_didtB A, sexo B, entidades_renapo C
WHERE A.sexo              = B.id_alf_sexo
AND   A.lugar_nacimiento  = C.id_entidad_renapo
AND   A.id_archivo        = 13
INTO OUTFILE 'L_QuintanaRoo01_SIN_DIF.txt' FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n';


-- 08-Marzo-2016 Proceso Zacatecas01--

INSERT INTO est_archivos (nombre_archivo, id_rp, id_enlace, fecha_recepcion, comentario) VALUES ('ZACATECAS_CURP_ACT.txt', 1, 12, '2016-03-08 17:48', '6,858 registros'); 
INSERT INTO est_archivos (nombre_archivo, id_rp, id_enlace, fecha_recepcion, comentario) VALUES ('ZACATECAS_SIN_DIF.txt', 1, 12, '2016-03-08 17:48', '41,326 registros');

LOAD DATA INFILE 'ZACATECAS_CURP_ACT.txt' INTO TABLE est_layout_didtB
CHARACTER SET latin1   
FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' 
( curp, nombre, apellido_paterno, apellido_materno, sexo, 
  @var1, lugar_nacimiento )
SET 
  id_archivo = 18,
  ciz=0,
  delegacion = 0,
  subdelegacion = 0,
  id_prospera = 0,
  mes_nacimiento = MONTH( STR_TO_DATE(@var1, '%Y-%m-%d') ),
  anio_nacimiento = YEAR( STR_TO_DATE(@var1, '%Y-%m-%d') );

LOAD DATA INFILE 'ZACATECAS_SIN_DIF.txt' INTO TABLE est_layout_didtB
CHARACTER SET latin1   
FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' 
( curp, nombre, apellido_paterno, apellido_materno, sexo, 
  @var1, lugar_nacimiento )
SET 
  id_archivo = 19,
  ciz=0,
  delegacion = 0,
  subdelegacion = 0,
  id_prospera = 0,
  mes_nacimiento = MONTH( STR_TO_DATE(@var1, '%Y-%m-%d') ),
  anio_nacimiento = YEAR( STR_TO_DATE(@var1, '%Y-%m-%d') );

UPDATE est_layout_didtB
SET delegacion = ( SELECT AA.del FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didtB.lugar_nacimiento = AA.lugar_nacimiento),
 subdelegacion = ( SELECT AA.subdel FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didtB.lugar_nacimiento = AA.lugar_nacimiento),
 ciz = ( SELECT AA.ciz FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didtB.lugar_nacimiento = AA.lugar_nacimiento)
 WHERE id_archivo = 18 OR id_archivo = 19;

SELECT 
  CONCAT(ciz, SUBSTR(CONCAT("00", delegacion), -2), SUBSTR(CONCAT("00", subdelegacion), -2), "00000000000",
    SUBSTR(CONCAT(apellido_paterno, "                           "), 1, 27),
    SUBSTR(CONCAT(apellido_materno, "                           "), 1, 27),
    SUBSTR(CONCAT(nombre, "                                   "), 1, 35),
    B.id_sexo, SUBSTR(CONCAT("00", mes_nacimiento), -2), SUBSTR(CONCAT("00", id_lugar_nacimiento), -2), SUBSTR(anio_nacimiento, -2),
    "ESTUDIA", "000", curp, "               ", 9)
FROM est_layout_didtB A, sexo B, entidades_renapo C
WHERE A.sexo              = B.id_alf_sexo
AND   A.lugar_nacimiento  = C.id_entidad_renapo
AND   A.id_archivo        = 18
INTO OUTFILE 'L_Zacatecas01_CURP_ACT.txt' FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n';

SELECT 
  CONCAT(ciz, SUBSTR(CONCAT("00", delegacion), -2), SUBSTR(CONCAT("00", subdelegacion), -2), "00000000000",
    SUBSTR(CONCAT(apellido_paterno, "                           "), 1, 27),
    SUBSTR(CONCAT(apellido_materno, "                           "), 1, 27),
    SUBSTR(CONCAT(nombre, "                                   "), 1, 35),
    B.id_sexo, SUBSTR(CONCAT("00", mes_nacimiento), -2), SUBSTR(CONCAT("00", id_lugar_nacimiento), -2), SUBSTR(anio_nacimiento, -2),
    "ESTUDIA", "000", curp, "               ", 9)
FROM est_layout_didtB A, sexo B, entidades_renapo C
WHERE A.sexo              = B.id_alf_sexo
AND   A.lugar_nacimiento  = C.id_entidad_renapo
AND   A.id_archivo        = 19
INTO OUTFILE 'L_Zacatecas01_SIN_DIF.txt' FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n';

-- 08-Marzo-2016 Proceso Veracruz01--

INSERT INTO est_archivos (nombre_archivo, id_rp, id_enlace, fecha_recepcion, comentario) 
  VALUES ('VERACRUZ_CURP_ACT.txt', 1, 12, '2016-03-08 17:48', '10,309 registros'); 
INSERT INTO est_archivos (nombre_archivo, id_rp, id_enlace, fecha_recepcion, comentario) 
  VALUES ('VERACRUZ_SIN_DIF.txt', 1, 12, '2016-03-08 17:48', '324,508 registros');

LOAD DATA INFILE 'VERACRUZ_CURP_ACT.txt' INTO TABLE est_layout_didtB
CHARACTER SET latin1   
FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' 
( curp, nombre, apellido_paterno, apellido_materno, sexo, 
  @var1, lugar_nacimiento )
SET 
  id_archivo = 20,
  ciz=0,
  delegacion = 0,
  subdelegacion = 0,
  id_prospera = 0,
  mes_nacimiento = MONTH( STR_TO_DATE(@var1, '%Y-%m-%d') ),
  anio_nacimiento = YEAR( STR_TO_DATE(@var1, '%Y-%m-%d') );

LOAD DATA INFILE 'VERACRUZ_SIN_DIF.txt' INTO TABLE est_layout_didtB
CHARACTER SET latin1   
FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' 
( curp, nombre, apellido_paterno, apellido_materno, sexo, 
  @var1, lugar_nacimiento )
SET 
  id_archivo = 21,
  ciz=0,
  delegacion = 0,
  subdelegacion = 0,
  id_prospera = 0,
  mes_nacimiento = MONTH( STR_TO_DATE(@var1, '%Y-%m-%d') ),
  anio_nacimiento = YEAR( STR_TO_DATE(@var1, '%Y-%m-%d') );

UPDATE est_layout_didtB
SET delegacion = ( SELECT AA.del FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didtB.lugar_nacimiento = AA.lugar_nacimiento),
 subdelegacion = ( SELECT AA.subdel FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didtB.lugar_nacimiento = AA.lugar_nacimiento),
 ciz = ( SELECT AA.ciz FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didtB.lugar_nacimiento = AA.lugar_nacimiento)
 WHERE id_archivo = 20;

UPDATE est_layout_didtB
SET delegacion = ( SELECT AA.del FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didtB.lugar_nacimiento = AA.lugar_nacimiento),
 subdelegacion = ( SELECT AA.subdel FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didtB.lugar_nacimiento = AA.lugar_nacimiento),
 ciz = ( SELECT AA.ciz FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didtB.lugar_nacimiento = AA.lugar_nacimiento)
 WHERE id_archivo = 21;

SELECT 
  CONCAT(ciz, SUBSTR(CONCAT("00", delegacion), -2), SUBSTR(CONCAT("00", subdelegacion), -2), "00000000000",
    SUBSTR(CONCAT(apellido_paterno, "                           "), 1, 27),
    SUBSTR(CONCAT(apellido_materno, "                           "), 1, 27),
    SUBSTR(CONCAT(nombre, "                                   "), 1, 35),
    B.id_sexo, SUBSTR(CONCAT("00", mes_nacimiento), -2), SUBSTR(CONCAT("00", id_lugar_nacimiento), -2), SUBSTR(anio_nacimiento, -2),
    "ESTUDIA", "000", curp, "               ", 9)
FROM est_layout_didtB A, sexo B, entidades_renapo C
WHERE A.sexo              = B.id_alf_sexo
AND   A.lugar_nacimiento  = C.id_entidad_renapo
AND   A.id_archivo        = 20
INTO OUTFILE 'L_Veracruz01_CURP_ACT.txt' FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n';

SELECT 
  CONCAT(ciz, SUBSTR(CONCAT("00", delegacion), -2), SUBSTR(CONCAT("00", subdelegacion), -2), "00000000000",
    SUBSTR(CONCAT(apellido_paterno, "                           "), 1, 27),
    SUBSTR(CONCAT(apellido_materno, "                           "), 1, 27),
    SUBSTR(CONCAT(nombre, "                                   "), 1, 35),
    B.id_sexo, SUBSTR(CONCAT("00", mes_nacimiento), -2), SUBSTR(CONCAT("00", id_lugar_nacimiento), -2), SUBSTR(anio_nacimiento, -2),
    "ESTUDIA", "000", curp, "               ", 9)
FROM est_layout_didtB A, sexo B, entidades_renapo C
WHERE A.sexo              = B.id_alf_sexo
AND   A.lugar_nacimiento  = C.id_entidad_renapo
AND   A.id_archivo        = 21
INTO OUTFILE 'L_Veracruz01_SIN_DIF.txt' FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n';

-- 08-Marzo-2016 Proceso Tlaxcala01--

INSERT INTO est_archivos (nombre_archivo, id_rp, id_enlace, fecha_recepcion, comentario) 
  VALUES ('TLAXCALA_CURP_ACT.txt', 1, 12, '2016-03-08 17:48', '2,495 registros'); 
INSERT INTO est_archivos (nombre_archivo, id_rp, id_enlace, fecha_recepcion, comentario) 
  VALUES ('TLAXCALA_SIN_DIF.txt', 1, 12, '2016-03-08 17:48', '70,984 registros');

LOAD DATA INFILE 'TLAXCALA_CURP_ACT.txt' INTO TABLE est_layout_didtB
CHARACTER SET latin1   
FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' 
( curp, nombre, apellido_paterno, apellido_materno, sexo, 
  @var1, lugar_nacimiento )
SET 
  id_archivo = 27,
  ciz=0,
  delegacion = 0,
  subdelegacion = 0,
  id_prospera = 0,
  mes_nacimiento = MONTH( STR_TO_DATE(@var1, '%Y-%m-%d') ),
  anio_nacimiento = YEAR( STR_TO_DATE(@var1, '%Y-%m-%d') );

LOAD DATA INFILE 'TLAXCALA_SIN_DIF.txt' INTO TABLE est_layout_didtB
CHARACTER SET latin1   
FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' 
( curp, nombre, apellido_paterno, apellido_materno, sexo, 
  @var1, lugar_nacimiento )
SET 
  id_archivo = 28,
  ciz=0,
  delegacion = 0,
  subdelegacion = 0,
  id_prospera = 0,
  mes_nacimiento = MONTH( STR_TO_DATE(@var1, '%Y-%m-%d') ),
  anio_nacimiento = YEAR( STR_TO_DATE(@var1, '%Y-%m-%d') );

UPDATE est_layout_didtB
SET delegacion = ( SELECT AA.del FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didtB.lugar_nacimiento = AA.lugar_nacimiento),
 subdelegacion = ( SELECT AA.subdel FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didtB.lugar_nacimiento = AA.lugar_nacimiento),
 ciz = ( SELECT AA.ciz FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didtB.lugar_nacimiento = AA.lugar_nacimiento)
 WHERE id_archivo = 27;

UPDATE est_layout_didtB
SET delegacion = ( SELECT AA.del FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didtB.lugar_nacimiento = AA.lugar_nacimiento),
 subdelegacion = ( SELECT AA.subdel FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didtB.lugar_nacimiento = AA.lugar_nacimiento),
 ciz = ( SELECT AA.ciz FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didtB.lugar_nacimiento = AA.lugar_nacimiento)
 WHERE id_archivo = 28;

SELECT 
  CONCAT(ciz, SUBSTR(CONCAT("00", delegacion), -2), SUBSTR(CONCAT("00", subdelegacion), -2), "00000000000",
    SUBSTR(CONCAT(apellido_paterno, "                           "), 1, 27),
    SUBSTR(CONCAT(apellido_materno, "                           "), 1, 27),
    SUBSTR(CONCAT(nombre, "                                   "), 1, 35),
    B.id_sexo, SUBSTR(CONCAT("00", mes_nacimiento), -2), SUBSTR(CONCAT("00", id_lugar_nacimiento), -2), SUBSTR(anio_nacimiento, -2),
    "ESTUDIA", "000", curp, "               ", 9)
FROM est_layout_didtB A, sexo B, entidades_renapo C
WHERE A.sexo              = B.id_alf_sexo
AND   A.lugar_nacimiento  = C.id_entidad_renapo
AND   A.id_archivo        = 27
INTO OUTFILE 'L_Tlaxcala01_CURP_ACT.txt' FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n';

SELECT 
  CONCAT(ciz, SUBSTR(CONCAT("00", delegacion), -2), SUBSTR(CONCAT("00", subdelegacion), -2), "00000000000",
    SUBSTR(CONCAT(apellido_paterno, "                           "), 1, 27),
    SUBSTR(CONCAT(apellido_materno, "                           "), 1, 27),
    SUBSTR(CONCAT(nombre, "                                   "), 1, 35),
    B.id_sexo, SUBSTR(CONCAT("00", mes_nacimiento), -2), SUBSTR(CONCAT("00", id_lugar_nacimiento), -2), SUBSTR(anio_nacimiento, -2),
    "ESTUDIA", "000", curp, "               ", 9)
FROM est_layout_didtB A, sexo B, entidades_renapo C
WHERE A.sexo              = B.id_alf_sexo
AND   A.lugar_nacimiento  = C.id_entidad_renapo
AND   A.id_archivo        = 28
INTO OUTFILE 'L_Tlaxcala01_SIN_DIF.txt' FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n';

-- 08-Marzo-2016 Proceso Tamaulipas01--

INSERT INTO est_archivos (nombre_archivo, id_rp, id_enlace, fecha_recepcion, comentario) 
  VALUES ('TAMAULIPAS_CURP_ACT.txt', 1, 12, '2016-03-08 17:48', '6,476 registros'); 
INSERT INTO est_archivos (nombre_archivo, id_rp, id_enlace, fecha_recepcion, comentario) 
  VALUES ('TAMAULIPAS_SIN_DIF.txt', 1, 12, '2016-03-08 17:48', '130,638 registros');

LOAD DATA INFILE 'TAMAULIPAS_CURP_ACT.txt' INTO TABLE est_layout_didtB
CHARACTER SET latin1   
FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' 
( curp, nombre, apellido_paterno, apellido_materno, sexo, 
  @var1, lugar_nacimiento )
SET 
  id_archivo = 29,
  ciz=0,
  delegacion = 0,
  subdelegacion = 0,
  id_prospera = 0,
  mes_nacimiento = MONTH( STR_TO_DATE(@var1, '%Y-%m-%d') ),
  anio_nacimiento = YEAR( STR_TO_DATE(@var1, '%Y-%m-%d') );

LOAD DATA INFILE 'TAMAULIPAS_SIN_DIF.txt' INTO TABLE est_layout_didtB
CHARACTER SET latin1   
FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' 
( curp, nombre, apellido_paterno, apellido_materno, sexo, 
  @var1, lugar_nacimiento )
SET 
  id_archivo = 30,
  ciz=0,
  delegacion = 0,
  subdelegacion = 0,
  id_prospera = 0,
  mes_nacimiento = MONTH( STR_TO_DATE(@var1, '%Y-%m-%d') ),
  anio_nacimiento = YEAR( STR_TO_DATE(@var1, '%Y-%m-%d') );

UPDATE est_layout_didtB
SET delegacion = ( SELECT AA.del FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didtB.lugar_nacimiento = AA.lugar_nacimiento),
 subdelegacion = ( SELECT AA.subdel FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didtB.lugar_nacimiento = AA.lugar_nacimiento),
 ciz = ( SELECT AA.ciz FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didtB.lugar_nacimiento = AA.lugar_nacimiento)
 WHERE id_archivo = 29;

UPDATE est_layout_didtB
SET delegacion = ( SELECT AA.del FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didtB.lugar_nacimiento = AA.lugar_nacimiento),
 subdelegacion = ( SELECT AA.subdel FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didtB.lugar_nacimiento = AA.lugar_nacimiento),
 ciz = ( SELECT AA.ciz FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didtB.lugar_nacimiento = AA.lugar_nacimiento)
 WHERE id_archivo = 30;

SELECT 
  CONCAT(ciz, SUBSTR(CONCAT("00", delegacion), -2), SUBSTR(CONCAT("00", subdelegacion), -2), "00000000000",
    SUBSTR(CONCAT(apellido_paterno, "                           "), 1, 27),
    SUBSTR(CONCAT(apellido_materno, "                           "), 1, 27),
    SUBSTR(CONCAT(nombre, "                                   "), 1, 35),
    B.id_sexo, SUBSTR(CONCAT("00", mes_nacimiento), -2), SUBSTR(CONCAT("00", id_lugar_nacimiento), -2), SUBSTR(anio_nacimiento, -2),
    "ESTUDIA", "000", curp, "               ", 9)
FROM est_layout_didtB A, sexo B, entidades_renapo C
WHERE A.sexo              = B.id_alf_sexo
AND   A.lugar_nacimiento  = C.id_entidad_renapo
AND   A.id_archivo        = 29
INTO OUTFILE 'L_Tamaulipas01_CURP_ACT.txt' FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n';

SELECT 
  CONCAT(ciz, SUBSTR(CONCAT("00", delegacion), -2), SUBSTR(CONCAT("00", subdelegacion), -2), "00000000000",
    SUBSTR(CONCAT(apellido_paterno, "                           "), 1, 27),
    SUBSTR(CONCAT(apellido_materno, "                           "), 1, 27),
    SUBSTR(CONCAT(nombre, "                                   "), 1, 35),
    B.id_sexo, SUBSTR(CONCAT("00", mes_nacimiento), -2), SUBSTR(CONCAT("00", id_lugar_nacimiento), -2), SUBSTR(anio_nacimiento, -2),
    "ESTUDIA", "000", curp, "               ", 9)
FROM est_layout_didtB A, sexo B, entidades_renapo C
WHERE A.sexo              = B.id_alf_sexo
AND   A.lugar_nacimiento  = C.id_entidad_renapo
AND   A.id_archivo        = 30
INTO OUTFILE 'L_Tamaulipas01_SIN_DIF.txt' FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n';

-- 08-Marzo-2016 Proceso Sinaloa01--

INSERT INTO est_archivos (nombre_archivo, id_rp, id_enlace, fecha_recepcion, comentario) 
  VALUES ('SINALOA_CURP_ACT.txt', 1, 12, '2016-03-08 17:48', '5,566 registros'); 
INSERT INTO est_archivos (nombre_archivo, id_rp, id_enlace, fecha_recepcion, comentario) 
  VALUES ('SINALOA_SIN_DIF.txt', 1, 12, '2016-03-08 17:48', '192,085 registros');

LOAD DATA INFILE 'SINALOA_CURP_ACT.txt' INTO TABLE est_layout_didtB
CHARACTER SET latin1   
FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' 
( curp, nombre, apellido_paterno, apellido_materno, sexo, 
  @var1, lugar_nacimiento )
SET 
  id_archivo = 31,
  ciz=0,
  delegacion = 0,
  subdelegacion = 0,
  id_prospera = 0,
  mes_nacimiento = MONTH( STR_TO_DATE(@var1, '%Y-%m-%d') ),
  anio_nacimiento = YEAR( STR_TO_DATE(@var1, '%Y-%m-%d') );

LOAD DATA INFILE 'SINALOA_SIN_DIF.txt' INTO TABLE est_layout_didtB
CHARACTER SET latin1   
FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' 
( curp, nombre, apellido_paterno, apellido_materno, sexo, 
  @var1, lugar_nacimiento )
SET 
  id_archivo = 32,
  ciz=0,
  delegacion = 0,
  subdelegacion = 0,
  id_prospera = 0,
  mes_nacimiento = MONTH( STR_TO_DATE(@var1, '%Y-%m-%d') ),
  anio_nacimiento = YEAR( STR_TO_DATE(@var1, '%Y-%m-%d') );

UPDATE est_layout_didtB
SET delegacion = ( SELECT AA.del FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didtB.lugar_nacimiento = AA.lugar_nacimiento),
 subdelegacion = ( SELECT AA.subdel FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didtB.lugar_nacimiento = AA.lugar_nacimiento),
 ciz = ( SELECT AA.ciz FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didtB.lugar_nacimiento = AA.lugar_nacimiento)
 WHERE id_archivo = 31;

UPDATE est_layout_didtB
SET delegacion = ( SELECT AA.del FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didtB.lugar_nacimiento = AA.lugar_nacimiento),
 subdelegacion = ( SELECT AA.subdel FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didtB.lugar_nacimiento = AA.lugar_nacimiento),
 ciz = ( SELECT AA.ciz FROM tmp_table_ciz_del_subdel AA WHERE est_layout_didtB.lugar_nacimiento = AA.lugar_nacimiento)
 WHERE id_archivo = 32;

SELECT 
  CONCAT(ciz, SUBSTR(CONCAT("00", delegacion), -2), SUBSTR(CONCAT("00", subdelegacion), -2), "00000000000",
    SUBSTR(CONCAT(apellido_paterno, "                           "), 1, 27),
    SUBSTR(CONCAT(apellido_materno, "                           "), 1, 27),
    SUBSTR(CONCAT(nombre, "                                   "), 1, 35),
    B.id_sexo, SUBSTR(CONCAT("00", mes_nacimiento), -2), SUBSTR(CONCAT("00", id_lugar_nacimiento), -2), SUBSTR(anio_nacimiento, -2),
    "ESTUDIA", "000", curp, "               ", 9)
FROM est_layout_didtB A, sexo B, entidades_renapo C
WHERE A.sexo              = B.id_alf_sexo
AND   A.lugar_nacimiento  = C.id_entidad_renapo
AND   A.id_archivo        = 31
INTO OUTFILE 'L_Sinaloa01_CURP_ACT.txt' FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n';

SELECT 
  CONCAT(ciz, SUBSTR(CONCAT("00", delegacion), -2), SUBSTR(CONCAT("00", subdelegacion), -2), "00000000000",
    SUBSTR(CONCAT(apellido_paterno, "                           "), 1, 27),
    SUBSTR(CONCAT(apellido_materno, "                           "), 1, 27),
    SUBSTR(CONCAT(nombre, "                                   "), 1, 35),
    B.id_sexo, SUBSTR(CONCAT("00", mes_nacimiento), -2), SUBSTR(CONCAT("00", id_lugar_nacimiento), -2), SUBSTR(anio_nacimiento, -2),
    "ESTUDIA", "000", curp, "               ", 9)
FROM est_layout_didtB A, sexo B, entidades_renapo C
WHERE A.sexo              = B.id_alf_sexo
AND   A.lugar_nacimiento  = C.id_entidad_renapo
AND   A.id_archivo        = 32
INTO OUTFILE 'L_Sinaloa01_SIN_DIF.txt' FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n';




--08 Marzo , incorporación de NSS generados/localizados en la BD para su relación con layout original

CREATE TABLE est_layout_operados (
  id_layout_operados INT AUTO_INCREMENT,
  id_archivo        INT,
  
  ciz               CHAR(1),
  delegacion        CHAR(2),
  subdelegacion     CHAR(2),
  nss               CHAR(11),
  apellido_paterno  CHAR(27),
  apellido_materno  CHAR(27),
  nombre            CHAR(35),
  sexo              CHAR(1),
  mes_nacimiento    CHAR(2),
  lugar_nacimiento  CHAR(2),
  anio_nacimiento   CHAR(2),
  usuario_convencional CHAR(7),
  umf               CHAR(3),
  curp              CHAR(18),
  id_registro_patron CHAR(15),
  estatus_solicitud CHAR(1),
  PRIMARY KEY (id_layout_operados),
  FOREIGN KEY (id_archivo) REFERENCES est_archivos(id_archivo))
  ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOAD DATA INFILE 'reingresoTrabajadoresSIE_0403 2016_parte1ViernesSIE.txt' INTO TABLE est_layout_operados
FIELDS TERMINATED BY '' ENCLOSED BY '' ESCAPED BY '\\'
LINES TERMINATED BY '\n' STARTING BY ''
( ciz, delegacion, subdelegacion, nss, apellido_paterno, apellido_materno, nombre,
  sexo, mes_nacimiento, lugar_nacimiento, anio_nacimiento, usuario_convencional, umf, curp, id_registro_patron, estatus_solicitud )
SET id_archivo=14;

LOAD DATA INFILE 'reingresoTrabajadoresSIE_0403 2016_parte2ViernesSIE.txt' INTO TABLE est_layout_operados
FIELDS TERMINATED BY '' ENCLOSED BY '' ESCAPED BY '\\'
LINES TERMINATED BY '\n' STARTING BY ''
( ciz, delegacion, subdelegacion, nss, apellido_paterno, apellido_materno, nombre,
  sexo, mes_nacimiento, lugar_nacimiento, anio_nacimiento, usuario_convencional, umf, curp, id_registro_patron, estatus_solicitud )
SET id_archivo=15;

LOAD DATA INFILE 'reingresoTrabajadoresSIE_0503 2016_parte1SabadoSIE.txt' INTO TABLE est_layout_operados
FIELDS TERMINATED BY '' ENCLOSED BY '' ESCAPED BY '\\'
LINES TERMINATED BY '\n' STARTING BY ''
( ciz, delegacion, subdelegacion, nss, apellido_paterno, apellido_materno, nombre,
  sexo, mes_nacimiento, lugar_nacimiento, anio_nacimiento, usuario_convencional, umf, curp, id_registro_patron, estatus_solicitud )
SET id_archivo=16;

LOAD DATA INFILE 'reingresoTrabajadoresSIE_0503 2016_parte2SabadoSIE.txt' INTO TABLE est_layout_operados
FIELDS TERMINATED BY '' ENCLOSED BY '' ESCAPED BY '\\'
LINES TERMINATED BY '\n' STARTING BY ''
( ciz, delegacion, subdelegacion, nss, apellido_paterno, apellido_materno, nombre,
  sexo, mes_nacimiento, lugar_nacimiento, anio_nacimiento, usuario_convencional, umf, curp, id_registro_patron, estatus_solicitud )
SET id_archivo=17;

----------------------
LOAD DATA INFILE 'reingresoTrabajadoresSIE_280216_Parte2.txt' INTO TABLE est_layout_operados
FIELDS TERMINATED BY '' ENCLOSED BY '' ESCAPED BY '\\'
LINES TERMINATED BY '\n' STARTING BY ''
( ciz, delegacion, subdelegacion, nss, apellido_paterno, apellido_materno, nombre,
  sexo, mes_nacimiento, lugar_nacimiento, anio_nacimiento, usuario_convencional, umf, curp, id_registro_patron, estatus_solicitud )
SET id_archivo=22;

LOAD DATA INFILE 'reingresoTrabajadoresSIE_280216_Parte1.txt' INTO TABLE est_layout_operados
FIELDS TERMINATED BY '' ENCLOSED BY '' ESCAPED BY '\\'
LINES TERMINATED BY '\n' STARTING BY ''
( ciz, delegacion, subdelegacion, nss, apellido_paterno, apellido_materno, nombre,
  sexo, mes_nacimiento, lugar_nacimiento, anio_nacimiento, usuario_convencional, umf, curp, id_registro_patron, estatus_solicitud )
SET id_archivo=23;

LOAD DATA INFILE 'reingresoTrabajadoresSIE_030316.txt' INTO TABLE est_layout_operados
FIELDS TERMINATED BY '' ENCLOSED BY '' ESCAPED BY '\\'
LINES TERMINATED BY '\n' STARTING BY ''
( ciz, delegacion, subdelegacion, nss, apellido_paterno, apellido_materno, nombre,
  sexo, mes_nacimiento, lugar_nacimiento, anio_nacimiento, usuario_convencional, umf, curp, id_registro_patron, estatus_solicitud )
SET id_archivo=24;

LOAD DATA INFILE 'reingresoTrabajadoresSIE_020316.txt' INTO TABLE est_layout_operados
FIELDS TERMINATED BY '' ENCLOSED BY '' ESCAPED BY '\\'
LINES TERMINATED BY '\n' STARTING BY ''
( ciz, delegacion, subdelegacion, nss, apellido_paterno, apellido_materno, nombre,
  sexo, mes_nacimiento, lugar_nacimiento, anio_nacimiento, usuario_convencional, umf, curp, id_registro_patron, estatus_solicitud )
SET id_archivo=25;
-------------------------
LOAD DATA INFILE 'reingresoTrabajadoresSIE.txt' INTO TABLE est_layout_operados
FIELDS TERMINATED BY '' ENCLOSED BY '' ESCAPED BY '\\'
LINES TERMINATED BY '\n' STARTING BY ''
( ciz, delegacion, subdelegacion, nss, apellido_paterno, apellido_materno, nombre,
  sexo, mes_nacimiento, lugar_nacimiento, anio_nacimiento, usuario_convencional, umf, curp, id_registro_patron, estatus_solicitud )
SET id_archivo=26;
-------------------------
--09Mar2016
LOAD DATA INFILE 'reingresoTrabajadoresSIE 09Mar2016.txt' INTO TABLE est_layout_operados
FIELDS TERMINATED BY '' ENCLOSED BY '' ESCAPED BY '\\'
LINES TERMINATED BY '\n' STARTING BY ''
( ciz, delegacion, subdelegacion, nss, apellido_paterno, apellido_materno, nombre,
  sexo, mes_nacimiento, lugar_nacimiento, anio_nacimiento, usuario_convencional, umf, curp, id_registro_patron, estatus_solicitud )
SET id_archivo=33;

--------------------------------------------------

CREATE TABLE est_procesos (
  id_proceso      INT AUTO_INCREMENT,
  nombre_proceso  VARCHAR(40),
  comentario_proceso VARCHAR(64),
  PRIMARY KEY (id_proceso) )
  ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO est_procesos (nombre_proceso, comentario_proceso) VALUES ('Prospera Pisp', '');
INSERT INTO est_procesos (nombre_proceso, comentario_proceso) VALUES ('Prospera Benef', ''); 
INSERT INTO est_procesos (nombre_proceso, comentario_proceso) VALUES ('UdeG', 'Universidad de Guadalajara');
INSERT INTO est_procesos (nombre_proceso, comentario_proceso) VALUES ('QuintanaRoo01', 'Quintana Roo');
INSERT INTO est_procesos (nombre_proceso, comentario_proceso) VALUES ('Campeche01', 'Campeche');

INSERT INTO est_procesos (nombre_proceso, comentario_proceso) VALUES ('Chihuahua01', 'Chihuahua');
INSERT INTO est_procesos (nombre_proceso, comentario_proceso) VALUES ('Duranog01', 'Durango');

CREATE TABLE est_procesos_archivos (
  id_proceso      INT,
  id_archivo      INT,
  nombre_proceso  VARCHAR(40),
  comentario_proceso VARCHAR(64),
  PRIMARY KEY (id_proceso) )
  ENGINE=InnoDB DEFAULT CHARSET=latin1;
-------------------------------------------------------------------------


CREATE TABLE est_estatus_solicitudes (
  id_estatus_sol  INT,
  descripcion     CHAR(20),
  PRIMARY KEY (id_estatus_sol) )
  ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO est_estatus_solicitudes (id_estatus_sol, descripcion) VALUES (0,'NSS Asignado');
INSERT INTO est_estatus_solicitudes (id_estatus_sol, descripcion) VALUES (1,'NSS Recuperado');
INSERT INTO est_estatus_solicitudes (id_estatus_sol, descripcion) VALUES (2,'Serie no existe');
INSERT INTO est_estatus_solicitudes (id_estatus_sol, descripcion) VALUES (3,'Serie agotada');
INSERT INTO est_estatus_solicitudes (id_estatus_sol, descripcion) VALUES (9,'Para asignar');

-----------------------------------------------------------------------------------
CREATE TABLE est_usuario_conv (
  id_usuario_conv  INT AUTO_INCREMENT,
  descripcion      CHAR(7),
  PRIMARY KEY (id_usuario_conv) )
  ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO est_usuario_conv (descripcion) VALUES ('PROSPER');
INSERT INTO est_usuario_conv (descripcion) VALUES ('ESTUDIA');
INSERT INTO est_usuario_conv (descripcion) VALUES ('PROSPE2');
INSERT INTO est_usuario_conv (descripcion) VALUES ('-ERROR-');
-----------------------------------------------------------------------------------

CREATE TABLE est_curp_nss (
  curp  CHAR(18),
  nss   CHAR(11),
  PRIMARY KEY (curp, nss) )
  ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO est_curp_nss (curp, nss) 
( SELECT curp, nss
FROM est_layout_operados
WHERE id_archivo=33 );
-----------------------------------------------------------------------------------

CREATE TABLE est_curp_nss_archivo (
  curp                  CHAR(18),
  nss                   CHAR(11),
  id_usuario_conv       INT,
  id_estatus_sol        INT,
  id_archivo            INT,
  FOREIGN KEY (id_usuario_conv) REFERENCES est_usuario_conv(id_usuario_conv),
  FOREIGN KEY (id_archivo) REFERENCES est_archivos(id_archivo),
  FOREIGN KEY (id_estatus_sol) REFERENCES est_estatus_solicitudes(id_estatus_sol) )
  ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO est_curp_nss_archivo (curp, nss, id_usuario_conv, id_estatus_sol, id_archivo) 
( SELECT curp, nss, 
  CASE 
    WHEN usuario_convencional = 'PROSPER' THEN 1 
    WHEN usuario_convencional = 'ESTUDIA' THEN 2 
    WHEN usuario_convencional = 'PROSPE2' THEN 3
    ELSE 4
  END AS id_usuario_conv, 
    estatus_solicitud, id_archivo
FROM est_layout_operados
WHERE id_archivo=33 );

--------------------------------------------

mysql> SELECT usuario_convencional, COUNT(*) FROM est_layout_operados GROUP BY usuario_convencional;
+----------------------+----------+
| usuario_convencional | COUNT(*) |
+----------------------+----------+
| ESTUDIA              |    53591 |
| PROSPE2              |     5872 |
| PROSPER              |  2727182 |
| STUDIA0              |       67 |
| TUDIA00              |        2 |
+----------------------+----------+
5 rows in set (1 min 2.19 sec)

+----------------------+----------+
| usuario_convencional | COUNT(*) |
+----------------------+----------+
| ESTUDIA              |    89777 |
| PROSPE2              |     5872 |
| PROSPER              |  4847986 |
| STUDIA0              |       67 |
| TUDIA00              |        2 |
+----------------------+----------+
5 rows in set (33.68 sec)

09Mar2016
+----------------------+----------+
| usuario_convencional | COUNT(*) |
+----------------------+----------+
| ESTUDIA              |    89843 |
| PROSPE2              |     5872 |
| PROSPER              |  5406889 |
| STUDIA0              |       67 |
| TUDIA00              |        2 |
+----------------------+----------+






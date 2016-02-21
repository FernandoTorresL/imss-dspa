CREATE TABLE `dspa_user` (
  `user_id` INT AUTO_INCREMENT,
  `username` VARCHAR(32),
  `password` VARCHAR(40),
  `join_date` DATETIME,
  `first_name` VARCHAR(32),
  `first_last_name` VARCHAR(32),
  `second_last_name` VARCHAR(32),
  `gender` VARCHAR(1),
  `birthdate` DATE,
  -- `city` VARCHAR(32),
  -- `state` VARCHAR(2),
  `picture` VARCHAR(32),
  PRIMARY KEY (`user_id`)
)
  ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `dspa_archivos` (
  `archivo` VARCHAR(50),
  `num_registros` INT,
  `fecha_carga` DATETIME DEFAULT NOW(),
  PRIMARY KEY (`archivo`)
)
ENGINE=InnoDB DEFAULT CHARSET=latin1;


/*Crear la tabla acreditados# con el nombre por defecto del archivo*/

CREATE TABLE `acreditadosx` (
  `tipo_registro` CHAR(1),
  `rp` CHAR(11),
  `nss` CHAR(11),
  `numero_credito_vivienda` CHAR(10),
  `rfc` CHAR(13),
  `curp` CHAR(18),
  `nombre_trabajador` CHAR(50),
  `tipo_descuento` CHAR(1),
  `valor_descuento` CHAR(8),  
  `tipo_trabajador` CHAR(1),
  `fecha_inicio_descuento` CHAR(8),
  `espacios` CHAR(8),
  `id` INT AUTO_INCREMENT,
  `archivo` VARCHAR(50) DEFAULT "NOT_ACR_2015_06_01.TXT.TXT",
  PRIMARY KEY (`id`)
)
ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Cargar el archivo en la tabla creada
El archivo debe estar en C:\xampp\mysql\data\dspa_db 
Si el archivo contiene caracteres extraños que se interpretan como 2 caracteres, esto se 
evita cargandolo con SET latin1 al crear la tabla y al hacer LOAD*/
LOAD DATA INFILE 'NOT_ACR_2015_06_01.TXT.TXT'
  INTO TABLE acreditadosx
CHARACTER SET latin1   
FIELDS TERMINATED BY '' ENCLOSED BY '' ESCAPED BY '\\'
LINES TERMINATED BY '\n' STARTING BY ''
( tipo_registro,
  rp,
  nss,
  numero_credito_vivienda,
  rfc,
  curp,
  nombre_trabajador,
  tipo_descuento,
  valor_descuento,  
  tipo_trabajador,
  fecha_inicio_descuento,
  espacios
  );

/*Actualizar la tabla dspa_archivos. Esto solo es un apoyo visual, pero el nombre del archivo debe coincidir*/
INSERT INTO dspa_archivos(archivo, num_registros) VALUES ("NOT_ACR_2015_06_01.TXT.TXT", 4113521);



/* ---------------------------------------*/
CREATE TABLE delegaciones
  (
    delegacion          TINYINT UNSIGNED,
    entidad_imss        TINYINT UNSIGNED DEFAULT NULL,
    ciz                 TINYINT UNSIGNED DEFAULT NULL,
    descripcion         VARCHAR(128) DEFAULT NULL,
    descripcion_SINDO   VARCHAR(128) DEFAULT NULL,
    activo              CHAR(1) DEFAULT NULL,
    tipo_delegacion     CHAR(1) DEFAULT NULL,
    depto_laboral       CHAR(1) DEFAULT NULL,
    anio_ini_oper       YEAR DEFAULT NULL,
    fecha_ini_oper      DATE DEFAULT NULL,
    domicilio           VARCHAR(255) DEFAULT NULL,
    comentario          VARCHAR(4096) DEFAULT NULL,
    PRIMARY KEY (delegacion)
    )
    ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Origen: General.accdb */
LOAD DATA LOCAL INFILE "c:\\xampp\\mysql\\bin\\T_Delegaciones2.txt"
INTO TABLE delegaciones
FIELDS TERMINATED BY "|" ENCLOSED BY "" LINES TERMINATED BY '\r\n'
IGNORE 1 LINES ( delegacion, entidad_imss, ciz, descripcion, descripcion_SINDO, 
activo, tipo_delegacion, depto_laboral, anio_ini_oper, @var1, domicilio, comentario )
SET fecha_ini_oper = STR_TO_DATE(@var1, '%d/%m/%Y');

/* ---------------------------------------*/

/* ---------------------------------------*/
CREATE TABLE subdelegaciones
  (
    delegacion          TINYINT UNSIGNED,
    subdelegacion       TINYINT UNSIGNED,
    ciz                 TINYINT UNSIGNED,
    cdsss_subdelegacion TINYINT UNSIGNED,
    descripcion         VARCHAR(128),
    descripcion_SINDO   VARCHAR(128),
    activo              CHAR(1),
    tipo_subdelegacion  CHAR(1),
    depto_audpatrones   CHAR(1),
    anio_ini_oper       YEAR,
    fecha_ini_oper      DATE,
    fecha_fin_oper      DATE,
    comentarios         VARCHAR(4096),
    PRIMARY KEY (delegacion, subdelegacion), FOREIGN KEY (delegacion) REFERENCES delegaciones(delegacion)
    )
    ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOAD DATA LOCAL INFILE "c:\\xampp\\mysql\\bin\\T_Subdelegaciones3.txt"
INTO TABLE subdelegaciones
FIELDS TERMINATED BY "|" ENCLOSED BY "" LINES TERMINATED BY '\r\n'
IGNORE 1 LINES ( delegacion, subdelegacion, ciz, cdsss_subdelegacion, descripcion, 
descripcion_SINDO, activo, tipo_subdelegacion, depto_audpatrones, anio_ini_oper, @varf_Alta, @varf_Baja, comentarios )
SET fecha_ini_oper = STR_TO_DATE(@varf_Alta, '%d/%m/%Y'), fecha_fin_oper = STR_TO_DATE(@varf_Baja, '%d/%m/%Y');
/* ---------------------------------------*/

--Creación de tablas para Gestión de Cuentas SINDO
--Tabla de Tipos de movimiento
CREATE TABLE `movimientos` (
  `id_movimiento` INT,
  `descripcion` VARCHAR(32),
  PRIMARY KEY (`id_movimiento`)
)
  ENGINE=InnoDB DEFAULT CHARSET=latin1;

--Poblar la tabla, valores iniciales
INSERT INTO movimientos VALUES (1,'ALTA');
INSERT INTO movimientos VALUES (2,'BAJA');
INSERT INTO movimientos VALUES (3,'CAMBIO');
INSERT INTO movimientos VALUES (4,'CONNECT');

--Tabla de Grupos
CREATE TABLE `grupos` (
  `id_grupo` INT,
  `descripcion` CHAR(8) UNIQUE,
  PRIMARY KEY (`id_grupo`)
)
  ENGINE=InnoDB DEFAULT CHARSET=latin1;

--Poblar la tabla, valores iniciales
INSERT INTO grupos VALUES (0, '');
INSERT INTO grupos VALUES (1,'SSJSAV');
INSERT INTO grupos VALUES (2,'SSJDAV');
INSERT INTO grupos VALUES (3,'SSJOFA');
INSERT INTO grupos VALUES (4,'SSJVIG');
INSERT INTO grupos VALUES (5,'SSCERT');
INSERT INTO grupos VALUES (6,'SSOPER');
INSERT INTO grupos VALUES (7,'SSCONS');
INSERT INTO grupos VALUES (8,'SSCAMC');
INSERT INTO grupos VALUES (9,'SSCAUM');
INSERT INTO grupos VALUES (10,'SSCAPC');
INSERT INTO grupos VALUES (11,'SSCAMP');
INSERT INTO grupos VALUES (12,'SSADIF');
INSERT INTO grupos VALUES (13,'TSOS');
INSERT INTO grupos VALUES (14,'TSCIAS');
INSERT INTO grupos VALUES (15,'TSHU');
INSERT INTO grupos VALUES (16,'TSCS');
INSERT INTO grupos VALUES (17,'TSCO');
INSERT INTO grupos VALUES (18,'TSEM');
INSERT INTO grupos VALUES (19,'TSAI');

INSERT INTO grupos VALUES (21,'SSSTRA');
INSERT INTO grupos VALUES (22,'TSMF23');

INSERT INTO grupos VALUES (24,'SSCLAS');
INSERT INTO grupos VALUES (25,'SSCFIZ');
INSERT INTO grupos VALUES (26,'TSCIPE');
INSERT INTO grupos VALUES (27,'SSNVIG');
INSERT INTO grupos VALUES (28,'SSSART');
INSERT INTO grupos VALUES (29,'TSCIAN');
INSERT INTO grupos VALUES (30,'TSMF');

INSERT INTO grupos VALUES (32,'TSAC');
INSERT INTO grupos VALUES (33,'SSACCI');
INSERT INTO grupos VALUES (34,'TS5X');

--Tabla de Valijas/Oficios
CREATE TABLE `valijas` (
  `id_valija` INT AUTO_INCREMENT,
  `num_oficio_ca` VARCHAR(32) UNIQUE,
  `num_oficio_del` VARCHAR(32),
  `fecha_recepcion_ca` DATE,
  `fecha_captura_ca` DATETIME DEFAULT NOW(),
  `fecha_valija_del` DATE,
  `id_remitente` INT,
  `delegacion` TINYINT UNSIGNED,
  `comentario` VARCHAR(256),
  `archivo` VARCHAR(64),
  PRIMARY KEY (id_valija), FOREIGN KEY (delegacion) REFERENCES delegaciones(delegacion)
)
  ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `lotes` (
  `id_lote` INT AUTO_INCREMENT,
  `lote_anio` CHAR(9) UNIQUE,
  `fecha_creacion` DATETIME DEFAULT NOW(),
  `fecha_modificacion` DATETIME DEFAULT NOW(),
  `comentario` VARCHAR(256) DEFAULT NULL,
  PRIMARY KEY (id_lote)
)
    ENGINE=InnoDB DEFAULT CHARSET=latin1;

--Tabla de Solicitudes
CREATE TABLE `solicitudes` (
  `id_solicitud` INT AUTO_INCREMENT,
  `id_valija` INT,
  `id_lote` INT,
  `fecha_captura_ca` DATETIME DEFAULT NOW(),
  `fecha_solicitud_del` DATE,
  `fecha_modificacion` DATETIME DEFAULT NOW(),
  `delegacion` TINYINT UNSIGNED,
  `subdelegacion` TINYINT UNSIGNED,
  `nombre` VARCHAR(32),
  `primer_apellido` VARCHAR(32),
  `segundo_apellido` VARCHAR(32),
  `matricula` CHAR(10),
  `curp`  VARCHAR(20),
  `curp_correcta`  VARCHAR(18),
  `cargo` VARCHAR(50),
  `usuario` CHAR(8),
  `id_movimiento` INT,
  `id_grupo_nuevo` INT,
  `id_grupo_actual` INT,
  `comentario` VARCHAR(256),
  `rechazado` CHAR(1) DEFAULT 0,
  `archivo` VARCHAR(64),
  PRIMARY KEY (id_solicitud),
  FOREIGN KEY (id_lote) REFERENCES lotes(id_lote),
  FOREIGN KEY (delegacion) REFERENCES delegaciones(delegacion),
  FOREIGN KEY (delegacion, subdelegacion) REFERENCES subdelegaciones(delegacion, subdelegacion),
  FOREIGN KEY (id_valija) REFERENCES valijas(id_valija),
  FOREIGN KEY (id_movimiento) REFERENCES movimientos(id_movimiento),
  FOREIGN KEY (id_grupo_nuevo) REFERENCES grupos(id_grupo),
  FOREIGN KEY (id_grupo_actual) REFERENCES grupos(id_grupo)
)
  ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `dspa_archivos_estudiantes` (
  `archivo` VARCHAR(50),
  `num_registros` INT,
  `fecha_carga` DATETIME DEFAULT NOW(),
  PRIMARY KEY (`archivo`)
)
ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Actualizar la tabla dspa_archivos. Esto solo es un apoyo visual, pero el nombre del archivo debe coincidir*/
INSERT INTO dspa_archivos_estudiantes (archivo, num_registros) VALUES ("Archivo_Oscar.TXT", 500000);


CREATE TABLE `estudiantes` (
  `tipo_registro` CHAR(1),
  `rp` CHAR(11),
  `nss` CHAR(11),
  `numero_credito_vivienda` CHAR(10),
  `rfc` CHAR(13),
  `curp` CHAR(18),
  `nombre_trabajador` CHAR(50),
  `tipo_descuento` CHAR(1),
  `valor_descuento` CHAR(8),  
  `tipo_trabajador` CHAR(1),
  `fecha_inicio_descuento` CHAR(8),
  `espacios` CHAR(8),
  `id` INT AUTO_INCREMENT,
  `archivo` VARCHAR(50) DEFAULT "Archivo_Oscar.TXT",
  PRIMARY KEY (`id`)
)
ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Cargar el archivo en la tabla creada
El archivo debe estar en C:\xampp\mysql\data\dspa_db 
Si el archivo contiene caracteres extraños que se interpretan como 2 caracteres, esto se 
evita cargandolo con SET latin1 al crear la tabla y al hacer LOAD*/
LOAD DATA INFILE 'Archivo_Oscar.TXT'
  INTO TABLE estudiantes
CHARACTER SET latin1   
FIELDS TERMINATED BY '' ENCLOSED BY '' ESCAPED BY '\\'
LINES TERMINATED BY '\n' STARTING BY ''
( tipo_registro,
  rp,
  nss,
  numero_credito_vivienda,
  rfc,
  curp,
  nombre_trabajador,
  tipo_descuento,
  valor_descuento,  
  tipo_trabajador,
  fecha_inicio_descuento,
  espacios
  );
CREATE TABLE `acreditados2` (
  `id` INT AUTO_INCREMENT,
  `archivo` VARCHAR(50),
  `num_linea` INT,
  `tipo_registro` CHAR(1),
  `rp` CHAR(11),
  `nss` CHAR(11),
  `numero_credito_vivienda` CHAR(10),
  `rfc` CHAR(11),
  `curp` CHAR(18),
  `nombre_trabajador` CHAR(50),
  `tipo_descuento` CHAR(1),
  `valor_descuento` CHAR(8),  
  `tipo_trabajador` CHAR(1),
  `fecha_inicio_descuento` CHAR(8),
  `espacios` CHAR(8),
  PRIMARY KEY (`id`)
);


CREATE TABLE `acreditados4` (
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
  `espacios` CHAR(8)
);

LOAD DATA INFILE 'NOT_ACR_2015_04_02.TXT'
  INTO TABLE acreditados4 
FIELDS TERMINATED BY '' ENCLOSED BY '' ESCAPED BY '\\'
LINES TERMINATED BY '\n' STARTING BY '';

--------------------------

CREATE TABLE `acreditados5` (
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
  `espacios` CHAR(8)
)
ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOAD DATA INFILE 'NOT_ACR_2015_05_02.TXT'
  INTO TABLE acreditados5 
CHARACTER SET utf8   
FIELDS TERMINATED BY '' ENCLOSED BY '' ESCAPED BY '\\'
LINES TERMINATED BY '\n' STARTING BY '' 
;

/*
"LOAD DATA INFILE '$myFile'" . 
" INTO TABLE test FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' 
(@col1,@col2,@col3,@col4,@col5,@col6,@col7,@col8,@col9,@col10,@col11,@col12,@col13,@col14,@col15,@col16)

SET sdate = STR_TO_DATE(@col1,'%m/%d/%Y'),
acq = @col2,
iss = @col3,
tdate = STR_TO_DATE(@col4,'%m/%d/%Y');
*/


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


/*Instrucción para extraer archivo de texto con registros para importar a ACCESS*/
select  id_valija, num_oficio_ca, num_oficio_del, DATE_FORMAT(fecha_recepcion_ca, '%d-%m-%Y'), DATE_FORMAT(fecha_captura_ca, '%d-%m-%Y %T'), DATE_FORMAT(
fecha_valija_del, '%d-%m-%Y'), id_remitente, 0, delegacion, concat(comentario,'',archivo) from VALIJAS INTO OUTFILE 'valija-FTL13.txt' FIELDS TERMINATED BY '\t
' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n';

SELECT id_solicitud, id_valija, DATE_FORMAT(fecha_captura_ca, '%d-%m-%Y %T'), DATE_FORMAT(fecha_solicitud_del, '%d-%m-%Y'), lotes.lote_anio, '', '', delegacion, subdelegacion, nombre, primer_apellido, segundo_apellido, matricula, curp, '', 0, '', '', usuario, id_movimiento, id_grupo_nuevo, id_grupo_actual, 0, 0, '', 0, concat(solicitudes.comentario,'',archivo) FROM SOLICITUDES, lotes WHERE solicitudes.id_lote = lotes.id_lote INTO OUTFILE 'solicitudes-FTL05.txt' FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n';

/*Instrucción para extraer la información para las tablas del oficio:*/

/*ALTAS*/
SELECT solicitudes.primer_apellido, solicitudes.segundo_apellido, solicitudes.nombre, 
  movimientos.descripcion AS movimiento_descripcion, 
  grupos1.descripcion AS grupo_nuevo, solicitudes.usuario, solicitudes.matricula
    FROM solicitudes, valijas, lotes, delegaciones, subdelegaciones, movimientos, grupos grupos1, grupos grupos2
    WHERE solicitudes.id_lote       = lotes.id_lote
    AND   solicitudes.id_valija     = valijas.id_valija
    AND   solicitudes.delegacion    = subdelegaciones.delegacion
    AND   solicitudes.subdelegacion = subdelegaciones.subdelegacion
    AND   solicitudes.delegacion    = delegaciones.delegacion
    AND   solicitudes.id_movimiento = movimientos.id_movimiento
    AND   solicitudes.id_grupo_nuevo= grupos1.id_grupo
    AND   solicitudes.id_grupo_actual= grupos2.id_grupo
    AND   solicitudes.rechazado <> 1
    AND   solicitudes.id_movimiento = 1
    AND   solicitudes.id_lote = 11
    ORDER BY solicitudes.usuario ASC
    INTO OUTFILE 'ALTAS-D009 2016.txt' FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n';

/*CAMBIOS*/
SELECT solicitudes.primer_apellido, solicitudes.segundo_apellido, solicitudes.nombre, 
  movimientos.descripcion AS movimiento_descripcion, 
  grupos2.descripcion AS grupo_actual, grupos1.descripcion AS grupo_nuevo, 
  solicitudes.usuario, solicitudes.matricula
    FROM solicitudes, valijas, lotes, delegaciones, subdelegaciones, movimientos, grupos grupos1, grupos grupos2
    WHERE solicitudes.id_lote       = lotes.id_lote
    AND   solicitudes.id_valija     = valijas.id_valija
    AND   solicitudes.delegacion    = subdelegaciones.delegacion
    AND   solicitudes.subdelegacion = subdelegaciones.subdelegacion
    AND   solicitudes.delegacion    = delegaciones.delegacion
    AND   solicitudes.id_movimiento = movimientos.id_movimiento
    AND   solicitudes.id_grupo_nuevo= grupos1.id_grupo
    AND   solicitudes.id_grupo_actual= grupos2.id_grupo
    AND   solicitudes.rechazado <> 1
    AND   solicitudes.id_movimiento = 3
    AND   solicitudes.id_lote = 11
    ORDER BY solicitudes.usuario ASC
    INTO OUTFILE 'CAMBIOS-D009 2016.txt' FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n';

/*BAJAS*/
SELECT solicitudes.primer_apellido, solicitudes.segundo_apellido, solicitudes.nombre, 
  movimientos.descripcion AS movimiento_descripcion, 
  grupos2.descripcion AS grupo_actual, 
  solicitudes.usuario, solicitudes.matricula
    FROM solicitudes, valijas, lotes, delegaciones, subdelegaciones, movimientos, grupos grupos1, grupos grupos2
    WHERE solicitudes.id_lote       = lotes.id_lote
    AND   solicitudes.id_valija     = valijas.id_valija
    AND   solicitudes.delegacion    = subdelegaciones.delegacion
    AND   solicitudes.subdelegacion = subdelegaciones.subdelegacion
    AND   solicitudes.delegacion    = delegaciones.delegacion
    AND   solicitudes.id_movimiento = movimientos.id_movimiento
    AND   solicitudes.id_grupo_nuevo= grupos1.id_grupo
    AND   solicitudes.id_grupo_actual= grupos2.id_grupo
    AND   solicitudes.rechazado <> 1
    AND   solicitudes.id_movimiento = 2
    AND   solicitudes.id_lote = 11
    ORDER BY solicitudes.usuario ASC
    INTO OUTFILE 'BAJAS-D009 2016.txt' FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n';

/*Números de descargo para oficios*/
SELECT DISTINCT concat("[",valijas.delegacion, 
  IF(valijas.delegacion <> solicitudes.delegacion, concat( "(", solicitudes.delegacion, ")-" ), "-" ), 
  valijas.num_oficio_del, "-", valijas.num_oficio_ca, "]")
    FROM solicitudes, valijas, lotes, delegaciones, subdelegaciones, movimientos, grupos grupos1, grupos grupos2
    WHERE solicitudes.id_lote       = lotes.id_lote
    AND   solicitudes.id_valija     = valijas.id_valija
    AND   solicitudes.delegacion    = subdelegaciones.delegacion
    AND   solicitudes.subdelegacion = subdelegaciones.subdelegacion
    AND   solicitudes.delegacion    = delegaciones.delegacion
    AND   solicitudes.id_movimiento = movimientos.id_movimiento
    AND   solicitudes.id_grupo_nuevo= grupos1.id_grupo
    AND   solicitudes.id_grupo_actual= grupos2.id_grupo
    AND   solicitudes.id_lote = 11
    ORDER BY valijas.delegacion, solicitudes.delegacion, valijas.num_oficio_del, valijas.num_oficio_ca ASC
    INTO OUTFILE 'DESCARGO-D009 2016.txt' LINES TERMINATED BY '\n';

CREATE TABLE `curps` (
  `id` INT AUTO_INCREMENT,
  `curp` VARCHAR(18),
  `archivo4` VARCHAR(50),
  `archivo5` VARCHAR(50),
  PRIMARY KEY (`id`)
)
  ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO curps(curp, archivo4, archivo5) VALUES ("CAGR950526HMCSNB06", (SELECT 1 FROM estudiantes4 WHERE CURP="CAGR950526HMCSNB06"), (SELECT 1 FROM estudiantes5 WHERE CURP="CAGR950526HMCSNB06"));
INSERT INTO curps(curp, archivo4, archivo5) VALUES ("CARC960130MMNSYN09", (SELECT 1 FROM estudiantes4 WHERE CURP="CARC960130MMNSYN09"), (SELECT 1 FROM estudiantes5 WHERE CURP="CARC960130MMNSYN09"));
INSERT INTO curps(curp, archivo4, archivo5) VALUES ("CORV930819MMCLDC02", (SELECT 1 FROM estudiantes4 WHERE CURP="CORV930819MMCLDC02"), (SELECT 1 FROM estudiantes5 WHERE CURP="CORV930819MMCLDC02"));
INSERT INTO curps(curp, archivo4, archivo5) VALUES ("COVE971107HMCRLR04", (SELECT 1 FROM estudiantes4 WHERE CURP="COVE971107HMCRLR04"), (SELECT 1 FROM estudiantes5 WHERE CURP="COVE971107HMCRLR04"));
INSERT INTO curps(curp, archivo4, archivo5) VALUES ("COVJ960619HMSRLN04", (SELECT 1 FROM estudiantes4 WHERE CURP="COVJ960619HMSRLN04"), (SELECT 1 FROM estudiantes5 WHERE CURP="COVJ960619HMSRLN04"));
INSERT INTO curps(curp, archivo4, archivo5) VALUES ("DEAJ950613HMCLLS01", (SELECT 1 FROM estudiantes4 WHERE CURP="DEAJ950613HMCLLS01"), (SELECT 1 FROM estudiantes5 WHERE CURP="DEAJ950613HMCLLS01"));
INSERT INTO curps(curp, archivo4, archivo5) VALUES ("DEGA970902HMCLNN00", (SELECT 1 FROM estudiantes4 WHERE CURP="DEGA970902HMCLNN00"), (SELECT 1 FROM estudiantes5 WHERE CURP="DEGA970902HMCLNN00"));
INSERT INTO curps(curp, archivo4, archivo5) VALUES ("DOLR950128HMCMPD06", (SELECT 1 FROM estudiantes4 WHERE CURP="DOLR950128HMCMPD06"), (SELECT 1 FROM estudiantes5 WHERE CURP="DOLR950128HMCMPD06"));
INSERT INTO curps(curp, archivo4, archivo5) VALUES ("FALR970324HMCRPL09", (SELECT 1 FROM estudiantes4 WHERE CURP="FALR970324HMCRPL09"), (SELECT 1 FROM estudiantes5 WHERE CURP="FALR970324HMCRPL09"));
INSERT INTO curps(curp, archivo4, archivo5) VALUES ("FOHE971125HMCLRD00", (SELECT 1 FROM estudiantes4 WHERE CURP="FOHE971125HMCLRD00"), (SELECT 1 FROM estudiantes5 WHERE CURP="FOHE971125HMCLRD00"));
INSERT INTO curps(curp, archivo4, archivo5) VALUES ("HEVC970102HMCRLR08", (SELECT 1 FROM estudiantes4 WHERE CURP="HEVC970102HMCRLR08"), (SELECT 1 FROM estudiantes5 WHERE CURP="HEVC970102HMCRLR08"));
INSERT INTO curps(curp, archivo4, archivo5) VALUES ("IAGJ970422HMCBRS00", (SELECT 1 FROM estudiantes4 WHERE CURP="IAGJ970422HMCBRS00"), (SELECT 1 FROM estudiantes5 WHERE CURP="IAGJ970422HMCBRS00"));
INSERT INTO curps(curp, archivo4, archivo5) VALUES ("JEMJ960821HMCSNN04", (SELECT 1 FROM estudiantes4 WHERE CURP="JEMJ960821HMCSNN04"), (SELECT 1 FROM estudiantes5 WHERE CURP="JEMJ960821HMCSNN04"));
INSERT INTO curps(curp, archivo4, archivo5) VALUES ("MALF961210HMCRNR15", (SELECT 1 FROM estudiantes4 WHERE CURP="MALF961210HMCRNR15"), (SELECT 1 FROM estudiantes5 WHERE CURP="MALF961210HMCRNR15"));
INSERT INTO curps(curp, archivo4, archivo5) VALUES ("MOGU921206HMCNRR05", (SELECT 1 FROM estudiantes4 WHERE CURP="MOGU921206HMCNRR05"), (SELECT 1 FROM estudiantes5 WHERE CURP="MOGU921206HMCNRR05"));
INSERT INTO curps(curp, archivo4, archivo5) VALUES ("MXCO950929HMCNRS02", (SELECT 1 FROM estudiantes4 WHERE CURP="MXCO950929HMCNRS02"), (SELECT 1 FROM estudiantes5 WHERE CURP="MXCO950929HMCNRS02"));
INSERT INTO curps(curp, archivo4, archivo5) VALUES ("NEOF970130HMCSSR08", (SELECT 1 FROM estudiantes4 WHERE CURP="NEOF970130HMCSSR08"), (SELECT 1 FROM estudiantes5 WHERE CURP="NEOF970130HMCSSR08"));
INSERT INTO curps(curp, archivo4, archivo5) VALUES ("OOUE900526HMCCRM04", (SELECT 1 FROM estudiantes4 WHERE CURP="OOUE900526HMCCRM04"), (SELECT 1 FROM estudiantes5 WHERE CURP="OOUE900526HMCCRM04"));
INSERT INTO curps(curp, archivo4, archivo5) VALUES ("RARJ930503HMCMSS01", (SELECT 1 FROM estudiantes4 WHERE CURP="RARJ930503HMCMSS01"), (SELECT 1 FROM estudiantes5 WHERE CURP="RARJ930503HMCMSS01"));
INSERT INTO curps(curp, archivo4, archivo5) VALUES ("SAFD971015HMCLLN09", (SELECT 1 FROM estudiantes4 WHERE CURP="SAFD971015HMCLLN09"), (SELECT 1 FROM estudiantes5 WHERE CURP="SAFD971015HMCLLN09"));
INSERT INTO curps(curp, archivo4, archivo5) VALUES ("SAGJ970822MMCLNN06", (SELECT 1 FROM estudiantes4 WHERE CURP="SAGJ970822MMCLNN06"), (SELECT 1 FROM estudiantes5 WHERE CURP="SAGJ970822MMCLNN06"));
INSERT INTO curps(curp, archivo4, archivo5) VALUES ("SAGR970816HMCNNB19", (SELECT 1 FROM estudiantes4 WHERE CURP="SAGR970816HMCNNB19"), (SELECT 1 FROM estudiantes5 WHERE CURP="SAGR970816HMCNNB19"));
INSERT INTO curps(curp, archivo4, archivo5) VALUES ("SASJ971208HMCNNS00", (SELECT 1 FROM estudiantes4 WHERE CURP="SASJ971208HMCNNS00"), (SELECT 1 FROM estudiantes5 WHERE CURP="SASJ971208HMCNNS00"));
INSERT INTO curps(curp, archivo4, archivo5) VALUES ("VAGM870812HMCLNG02", (SELECT 1 FROM estudiantes4 WHERE CURP="VAGM870812HMCLNG02"), (SELECT 1 FROM estudiantes5 WHERE CURP="VAGM870812HMCLNG02"));
INSERT INTO curps(curp, archivo4, archivo5) VALUES ("VEME920320HMCLRD01", (SELECT 1 FROM estudiantes4 WHERE CURP="VEME920320HMCLRD01"), (SELECT 1 FROM estudiantes5 WHERE CURP="VEME920320HMCLRD01"));
INSERT INTO curps(curp, archivo4, archivo5) VALUES ("ZAGF960823MMCPRR04", (SELECT 1 FROM estudiantes4 WHERE CURP="ZAGF960823MMCPRR04"), (SELECT 1 FROM estudiantes5 WHERE CURP="ZAGF960823MMCPRR04"));
INSERT INTO curps(curp, archivo4, archivo5) VALUES ("ZAZE940317HMCRMD03", (SELECT 1 FROM estudiantes4 WHERE CURP="ZAZE940317HMCRMD03"), (SELECT 1 FROM estudiantes5 WHERE CURP="ZAZE940317HMCRMD03"));


SELECT 
  A.curp,
  concat(B.curp, B.nombre, "-", B.apellido_paterno, "-", B.apellido_materno),
  concat(C.curp, C.nombre, "-", C.apellido_paterno, "-", C.apellido_materno)
FROM curps A, estudiantes4 B, estudiantes5 C
WHERE 

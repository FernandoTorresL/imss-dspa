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

/*--------------------------------------------
*/

CREATE TABLE `dspa_archivos_estudiantes` (
  `archivo` VARCHAR(50),
  `num_registros` INT,
  `fecha_carga` DATETIME DEFAULT NOW(),
  PRIMARY KEY (`archivo`)
)
ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Actualizar la tabla dspa_archivos. Esto solo es un apoyo visual, pero el nombre del archivo debe coincidir*/
INSERT INTO dspa_archivos_estudiantes (archivo, num_registros) VALUES ("500RegistrosA formateados.txt", 500);

CREATE TABLE `estudiantes6` (
  `id`                INT AUTO_INCREMENT,
  `curp`              VARCHAR(18),
  `nombre`            VARCHAR(100),
  `apellido_paterno`  VARCHAR(100),
  `apellido_materno`  VARCHAR(100),
  `sexo`              CHAR(2),
  `lugar_nacimiento`  CHAR(2),
  `dia_nacimiento`    CHAR(2),
  `mes_nacimiento`    CHAR(2),
  `anio_nacimiento`   CHAR(4),
  `ocupacion`         VARCHAR(40),
  `descripcion_ocupacion`  VARCHAR(40),
  `codigo_postal`     CHAR(5),
  `archivo` VARCHAR(50) DEFAULT "500RegistrosA formateados.txt",
  PRIMARY KEY (`id`)
)
ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Cargar el archivo en la tabla creada
El archivo debe estar en C:\xampp\mysql\data\dspa_db 
Si el archivo contiene caracteres extraños que se interpretan como 2 caracteres, esto se 
evita cargandolo con SET latin1 al crear la tabla y al hacer LOAD*/
LOAD DATA INFILE '500RegistrosA formateados.txt'
  INTO TABLE estudiantes6
CHARACTER SET latin1   
FIELDS TERMINATED BY '\t' ENCLOSED BY '' ESCAPED BY '\\'
LINES TERMINATED BY '\n' STARTING BY ''
IGNORE 1 LINES 
( curp,
  nombre,
  apellido_paterno,
  apellido_materno,
  sexo,
  lugar_nacimiento,
  dia_nacimiento,
  mes_nacimiento,
  anio_nacimiento,
  ocupacion,
  descripcion_ocupacion,
  codigo_postal
  );

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
LOAD DATA INFILE 'prueba_ftl_prospera.txt'
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

CREATE TABLE `prospera_benef` (
  `row`               INT AUTO_INCREMENT,
  `id`                CHAR(9),
  `folio_padron`      CHAR(13),
  `curp`              CHAR(18),
  `nombres`           VARCHAR(40),
  `apellido_paterno`  VARCHAR(40),
  `apellido_materno`  VARCHAR(40),
  `sexo`              CHAR(1),
  `fecha_nacimiento`  DATE,
  `clave_estado`      CHAR(2),
  PRIMARY KEY (`row`)
)
ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOAD DATA INFILE '12012016_BENEFICIARIO.txt'
INTO TABLE prospera_benef
CHARACTER SET latin1   
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '\\'
LINES TERMINATED BY '\n' STARTING BY ''
( id,
  folio_padron,
  curp,
  nombres,
  apellido_paterno,
  apellido_materno,
  @col2,
  @col1,
  clave_estado
  )
SET fecha_nacimiento = STR_TO_DATE(@col1,'%d/%m/%Y'),
 sexo = FIELD(@col2,"M","H");

--Para definir el año de nacimiento en una CURP.
SELECT 
    CURP,
    SUBSTRING(CURP,17,1),
  SUBSTRING(curp,5,2) AS anio_curp, 
    IF(SUBSTRING(CURP,17,1) REGEXP '[A-Z]',SUBSTRING(curp,5,2)+2000,SUBSTRING(curp,5,2)+1900)
FROM `prospera_pisp`
LIMIT 0,25;

--Agrupación de año de nacimiento según CURP para PROSPERA_PISP
SELECT
  COUNT(*),
  IF(SUBSTRING(CURP,17,1) REGEXP '[0-9]', SUBSTRING(curp,5,2)+1900,
     IF(SUBSTRING(CURP,17,1) REGEXP '[A-Z]',SUBSTRING(curp,5,2)+2000,"Error")) AS anio_nacimiento
FROM `prospera_pisp`
GROUP BY anio_nacimiento;

SELECT
COUNT(*) AS Cantidad_registros,
  IF((curp REGEXP '^[A-Z][AEIOUX][A-Z]{2}([0-9]{2})(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])[H|M](AS|BC|BS|CC|CH|CL|CM|CS|DF|DG|GR|GT|HG|JC|MC|MN|MS|NE|NL|NT|OC|PL|QR|QT|SL|SP|SR|TC|TL|TS|VZ|YN|ZS)[BCDFGHJKLMNPQRSTVWXYZ][A-Z]{2}[0-9|A-Z][0-9]$') = FALSE,
    IF( curp<>'', "CURP inválida", "CURP nula"), 
     IF(SUBSTRING(curp,17,1) REGEXP '[0-9]', SUBSTRING(curp,5,2)+1900, 
        IF(SUBSTRING(curp,17,1) REGEXP '[O]', 
           IF( SUBSTRING(curp,5,2)+2000>2016, "Posición 17 igual a 'O'", SUBSTRING(curp,5,2)+2000) ,
           IF(SUBSTRING(curp,17,1) REGEXP '[A-Z]', 
            IF( SUBSTRING(curp,5,2)+2000>2016, "Nacimiento a futuro. Probable CURP incorrecta", SUBSTRING(curp,5,2)+2000)
            , "Error al calcular el año nacimiento")))) AS anio_nacimiento
  FROM prospera_pisp
GROUP BY anio_nacimiento
INTO OUTFILE 'Dispersion_anio-prospera_pisp.txt' FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n';


--Agrupación de año de nacimiento según CURP para PROSPERA_BENEF
SELECT
  COUNT(*),
  IF(SUBSTRING(CURP,17,1) REGEXP '[0-9]', SUBSTRING(curp,5,2)+1900,
     IF(SUBSTRING(CURP,17,1) REGEXP '[A-Z]',SUBSTRING(curp,5,2)+2000,"Error")) AS anio_nacimiento
FROM `prospera_benef`
GROUP BY anio_nacimiento;

SELECT
  COUNT(*) AS Cantidad_registros,
  IF((curp REGEXP '^[A-Z][AEIOUX][A-Z]{2}([0-9]{2})(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])[H|M](AS|BC|BS|CC|CH|CL|CM|CS|DF|DG|GR|GT|HG|JC|MC|MN|MS|NE|NL|NT|OC|PL|QR|QT|SL|SP|SR|TC|TL|TS|VZ|YN|ZS)[BCDFGHJKLMNPQRSTVWXYZ][A-Z]{2}[0-9|A-Z][0-9]$') = FALSE,
    IF( curp<>'', "CURP inválida", "CURP nula"), 
     IF(SUBSTRING(curp,17,1) REGEXP '[0-9]', SUBSTRING(curp,5,2)+1900, 
        IF(SUBSTRING(curp,17,1) REGEXP '[O]', 
           IF( SUBSTRING(curp,5,2)+2000>2016, "Posición 17 igual a 'O'", SUBSTRING(curp,5,2)+2000) ,
           IF(SUBSTRING(curp,17,1) REGEXP '[A-Z]', 
            IF( SUBSTRING(curp,5,2)+2000>2016, "Nacimiento a futuro. Probable CURP incorrecta", SUBSTRING(curp,5,2)+2000)
            , "Error al calcular el año nacimiento")))) AS anio_nacimiento
FROM prospera_benef
GROUP BY anio_nacimiento
INTO OUTFILE 'Dispersion_anio-prospera_benef.txt' FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n';

SELECT
  curp,
  IF((curp REGEXP '^[A-Z][AEIOUX][A-Z]{2}([0-9]{2})(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])[H|M](AS|BC|BS|CC|CH|CL|CM|CS|DF|DG|GR|GT|HG|JC|MC|MN|MS|NE|NL|NT|OC|PL|QR|QT|SL|SP|SR|TC|TL|TS|VZ|YN|ZS)[BCDFGHJKLMNPQRSTVWXYZ][A-Z]{2}[0-9|A-Z][0-9]$') = FALSE,
    "CURP inválida", 
     IF(SUBSTRING(curp,17,1) REGEXP '[0-9]', SUBSTRING(curp,5,2)+1900, 
        IF(SUBSTRING(curp,17,1) REGEXP '[O]', 
           IF( SUBSTRING(curp,5,2)+2000>2015, "Posición 17 inválida", SUBSTRING(curp,5,2)+2000) ,
           IF(SUBSTRING(curp,17,1) REGEXP '[A-Z]', SUBSTRING(curp,5,2)+2000, "Error al calcular el año nacimiento")))) AS anio_nacimiento
FROM prospera_benef
WHERE curp <> ''
AND 
IF((curp REGEXP '^[A-Z][AEIOUX][A-Z]{2}([0-9]{2})(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])[H|M](AS|BC|BS|CC|CH|CL|CM|CS|DF|DG|GR|GT|HG|JC|MC|MN|MS|NE|NL|NT|OC|PL|QR|QT|SL|SP|SR|TC|TL|TS|VZ|YN|ZS)[BCDFGHJKLMNPQRSTVWXYZ][A-Z]{2}[0-9|A-Z][0-9]$') = FALSE,
    "CURP inválida", 
     IF(SUBSTRING(curp,17,1) REGEXP '[0-9]', SUBSTRING(curp,5,2)+1900, 
        IF(SUBSTRING(curp,17,1) REGEXP '[O]', 
           IF( SUBSTRING(curp,5,2)+2000>2015, "Posición 17 inválida", SUBSTRING(curp,5,2)+2000) ,
           IF(SUBSTRING(curp,17,1) REGEXP '[A-Z]', SUBSTRING(curp,5,2)+2000, "Error al calcular el año nacimiento")))) >2015
GROUP BY anio_nacimiento
INTO OUTFILE 'Curps mayores a 2015.txt' FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n';



--Consulta con las diferencias entre año-curp y año-fecha_nacimiento
SELECT
  IF(SUBSTRING(CURP,17,1) REGEXP '[A-Z]',SUBSTRING(curp,5,2)+2000,SUBSTRING(curp,5,2)+1900) AS anio_nacimiento_curp,
  YEAR(fecha_nacimiento) AS anio_nacimiento,
IF(IF(SUBSTRING(CURP,17,1) REGEXP '[A-Z]',SUBSTRING(curp,5,2)+2000,SUBSTRING(curp,5,2)+1900)<>YEAR(fecha_nacimiento),"DIF","OK")
FROM `prospera_benef`
GROUP BY 1,2,3
ORDER BY IF(IF(SUBSTRING(CURP,17,1) REGEXP '[A-Z]',SUBSTRING(curp,5,2)+2000,SUBSTRING(curp,5,2)+1900)<>YEAR(fecha_nacimiento),"DIF","OK") ASC

--Selecciona todos los registros donde el año de nacimiento calculado según CURP es mayor a 2016:
SELECT  *
FROM `prospera_pisp`
WHERE 2016<(IF(SUBSTRING(CURP,17,1) REGEXP '[A-Z]',SUBSTRING(curp,5,2)+2000,SUBSTRING(curp,5,2)+1900))
INTO OUTFILE 'CURPs mayores a 2016.txt' FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n';

SELECT  *
FROM `prospera_benef`
WHERE 2015<(IF(SUBSTRING(CURP,17,1) REGEXP '[A-Z]',SUBSTRING(curp,5,2)+2000,SUBSTRING(curp,5,2)+1900))
INTO OUTFILE 'CURPs mayores a 2015.txt' FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n';

SELECT *,
  IF(SUBSTRING(CURP,17,1) REGEXP '[A-Z]',SUBSTRING(curp,5,2)+2000,SUBSTRING(curp,5,2)+1900) AS anio_nacimiento_curp,
  YEAR(fecha_nacimiento) AS anio_nacimiento,
IF(IF(SUBSTRING(CURP,17,1) REGEXP '[A-Z]',SUBSTRING(curp,5,2)+2000,SUBSTRING(curp,5,2)+1900)<>YEAR(fecha_nacimiento),"DIF","OK") AS Resultado
FROM `prospera_benef`
WHERE "DIF"=(IF(IF(SUBSTRING(CURP,17,1) REGEXP '[A-Z]',SUBSTRING(curp,5,2)+2000,SUBSTRING(curp,5,2)+1900)<>YEAR(fecha_nacimiento),"DIF","OK"))
INTO OUTFILE 'CURPs con error en fecha.txt' FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n';



SELECT *,
  IF(SUBSTRING(CURP,17,1) REGEXP '[A-Z]',SUBSTRING(curp,5,2)+2000,SUBSTRING(curp,5,2)+1900) AS anio_nacimiento
FROM `prospera_pisp`
WHERE 1900=(IF(SUBSTRING(CURP,17,1) REGEXP '[A-Z]',SUBSTRING(curp,5,2)+2000,SUBSTRING(curp,5,2)+1900))


SELECT curp FROM est_renapo_confronta0  WHERE curp <> '' AND (curp REGEXP '^[A-Z][AEIOUX][A-Z]{2}([0-9]{2})(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])[H|M](AS|BC|BS|CC|CH|CL|CM|CS|DF|DG|GR|GT|HG|JC|MC|MN|MS|NE|NL|NT|OC|PL|QR|QT|SL|SP|SR|TC|TL|TS|VZ|YN|ZS)[A-Z]{3}[0-9|A-Z][0-9]$') = FALSE;
SELECT curp FROM est_renapo_confronta0  WHERE curp <> '' AND (curp REGEXP '^[A-Z][AEIOUX][A-Z]{2}([0-9]{2})(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])[H|M](AS|BC|BS|CC|CH|CL|CM|CS|DF|DG|GR|GT|HG|JC|MC|MN|MS|NE|NL|NT|OC|PL|QR|QT|SL|SP|SR|TC|TL|TS|VZ|YN|ZS)[BCDFGHJKLMNPQRSTVWXYZ][A-Z]{2}[0-9|A-Z][0-9]$') = FALSE;
SELECT curp FROM prospera_pisp          WHERE curp <> '' AND (curp REGEXP '^[A-Z][AEIOUX][A-Z]{2}([0-9]{2})(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])[H|M](AS|BC|BS|CC|CH|CL|CM|CS|DF|DG|GR|GT|HG|JC|MC|MN|MS|NE|NL|NT|OC|PL|QR|QT|SL|SP|SR|TC|TL|TS|VZ|YN|ZS)[BCDFGHJKLMNPQRSTVWXYZ][A-Z]{2}[0-9|A-Z][0-9]$') = FALSE;
SELECT curp FROM prospera_benef         WHERE curp <> '' AND (curp REGEXP '^[A-Z][AEIOUX][A-Z]{2}([0-9]{2})(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])[H|M](AS|BC|BS|CC|CH|CL|CM|CS|DF|DG|GR|GT|HG|JC|MC|MN|MS|NE|NL|NT|OC|PL|QR|QT|SL|SP|SR|TC|TL|TS|VZ|YN|ZS)[BCDFGHJKLMNPQRSTVWXYZ][A-Z]{2}[0-9|A-Z][0-9]$') = FALSE;

EXPRESION REGULAR PARA VALIDAR LA CURP: 
curp REGEXP '^[A-Z][AEIOUX][A-Z]{2}([0-9]{2})(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])[H|M](AS|BC|BS|CC|CH|CL|CM|CS|DF|DG|GR|GT|HG|JC|MC|MN|MS|NE|NL|NT|OC|PL|QR|QT|SL|SP|SR|TC|TL|TS|VZ|YN|ZS)[BCDFGHJKLMNPQRSTVWXYZ][A-Z]{2}[0-9|A-Z][0-9]$'
curp REGEXP '^[A-Z][AEIOUX][A-Z]{2}([0-9]{2})(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])[H|M](AS|BC|BS|CC|CH|CL|CM|CS|DF|DG|GR|GT|HG|JC|MC|MN|MS|NE|NL|NT|OC|PL|QR|QT|SL|SP|SR|TC|TL|TS|VZ|YN|ZS)[A-Z]{3}[0-9|A-Z][0-9]$'




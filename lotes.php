<?php
	
	header('Content-Type: text/html; charset=iso-8859-1'); // Para que devuelva correctamente los acentos de los registros

	require_once('appvars.php');
	require_once('connectvars.php');


	$dbc = mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
	
	$result = mysqli_query($dbc, "SELECT * FROM lotes ORDER BY fecha_modificacion DESC");

	echo '<option value="0">Seleccione # Lote</option>';	

	$primer_renglon = "si";

	while ($row = mysqli_fetch_array($result)) {
		if ($primer_renglon == "si") {
			echo '<option value="' . $row['id_lote'] . '" selected>' .$row['lote_anio'] . '</option>';
			$primer_renglon = "no";
		}
		else {
			echo '<option value="' . $row['id_lote'] . '">' .$row['lote_anio'] . '</option>';
		}
	}


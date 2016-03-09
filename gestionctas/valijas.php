<?php
	
	header('Content-Type: text/html; charset=iso-8859-1'); // Para que devuelva correctamente los acentos de los registros

	require_once('appvars.php');
	require_once('connectvars.php');


	$dbc = mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);

	$result = mysqli_query($dbc, "SELECT valijas.id_valija, 
							  		valijas.delegacion AS num_del, 
							  		delegaciones.descripcion AS delegacion_descripcion, 
							    	valijas.num_oficio_del,
							    	valijas.num_oficio_ca
							    	FROM valijas, delegaciones 
							    	WHERE valijas.delegacion = delegaciones.delegacion 
							    	ORDER BY 1 DESC");

	echo '<option value="0">Seleccione # Valija</option>';	

	$primer_renglon = "si";

	while ($row = mysqli_fetch_array($result)) {
		if ($primer_renglon == "si") {
		//echo '<option value="' . $row['id_lote'] . '" selected>' .$row['lote_anio'] . '</option>';
			echo '<option value="' . $row['id_valija'] . '" selected>' . $row['num_oficio_ca'] . ': ' . $row['num_del'] . '-' . $row['delegacion_descripcion'] . '</option>';
			$primer_renglon = "no";
		}
		else {
			echo '<option value="' . $row['id_valija'] . '">' . $row['num_oficio_ca'] . ': ' . $row['num_del'] . '-' . $row['delegacion_descripcion'] . '</option>';
		}
	}
	
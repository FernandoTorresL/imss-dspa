<?php
  // Start the session
  require_once('startsession.php');

  // Insert the page header
  $page_title = 'Genera reporte archivo Acreditados INFONAVIT';
  require_once('header.php');

  // Show the navigation menu
  require_once('navmenu.php');

  // Make sure the user is logged in before going any further.
  if (!isset($_SESSION['user_id'])) {
    echo '<p class="login">Por favor <a href="login.php">inicia sesi&oacute;n</a> para acceder a esta p&aacute;gina.</p>';
    // Insert the page footer
    require_once('footer.php');
    exit();
  }

  require_once('appvars.php');
  require_once('connectvars.php');

  $timetime = time();
  // Connect to the database
  $dbc = mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
  
  if (!isset($_GET['archivo'])) {
    //echo "Variable de sesión:" . $_SESSION['archivo'] . PHP_EOL;
    //echo "Variable de sesión:" . $_SESSION['num_registros'] . PHP_EOL;

    //$query = "SELECT * FROM acreditados9 WHERE archivo = '" . $_SESSION['archivo'] . "'";
    //$target = MM_UPLOADPATH_VAL . $timetime . " Reporte_" . $_SESSION['archivo'];
  }
  else {
    //echo "Variable de GET:" . $_GET['archivo'] . PHP_EOL;
    //echo "Variable de GET:" . $_GET['num_registros'] . PHP_EOL;
    $total_registros = $_GET['num_registros'];
    $nombre_archivo = $_GET['archivo'];
    $target = MM_UPLOADPATH_VAL . $timetime . " Reporte_" . $nombre_archivo;
  }

  $fh = fopen($target, 'w') or die("Falló la generación del archivo");
    //Línea de títulos de columna
  $text = "Número de Registro|Campo|Valor|Observaciones" . PHP_EOL;
  fwrite($fh, $text) or die($text . ":No se pudo escribir en el archivo");
  echo '<table>';
  echo '<tr>';
  echo '<td align="center" font-weight="bold">N&uacute;m. de Registro</td>';
  echo '<td align="center">Campo</td>';
  echo '<td align="center">Valor</td>';
  echo '<td align="center">Observaci&oacute;n</td>';
  echo '</tr>';

  for ($i = 1; $i <= $total_registros; $i++) {
    $query = "SELECT * FROM acreditados1 WHERE id = " . $i . " AND archivo = '" . $nombre_archivo . "'";
    //echo '<p class="error">' . $query .'</p></td></tr>';

    $data = mysqli_query($dbc, $query);

    while ($row = mysqli_fetch_array($data)) {
      // At least one row was founded so display the user data
      $renglon = $row['id'];
      $celda_num_renglon ='<tr><td class="txt" align="right">' . $row['id'] . '</td>';

      //Hacer las validaciones, una por una:
      if ( empty($row['tipo_registro']) || ($row['tipo_registro'] <> 1) ) {
        // $tipo_registro is blank and not equal to 1
        $campo = "Tipo de Registro";
        $valor = $row['tipo_registro'];
        $observacion = "Tipo de Registro <> 1";
        $text = $renglon . "|" . $campo . "|" . $valor . "|" . $observacion . PHP_EOL;
        fwrite($fh, $text) or die($text . ":No se pudo escribir en el archivo");
        //echo $celda_num_renglon;
        //echo '<td class="txt">Tipo de Registro</td>';
        //echo '<td class="txt" align="right"><pre>|' . $row['tipo_registro'] . '|</td>';
        //echo '<td class="txt"><p class="error">Tipo de Registro <> 1</p></td></tr>';
      }

      if (!preg_match('/^[A-Z0-9]\d{10}$/', utf8_encode($row['rp']))) { 
        //RP is invalid
        $campo = "RP";
        $valor = utf8_encode($row['rp']);
        $observacion = "RP inválido";
        $text = $renglon . "|" . $campo . "|" . $valor . "|" . $observacion . PHP_EOL;
        fwrite($fh, $text) or die($text . ":No se pudo escribir en el archivo");
        //echo $celda_num_renglon;
        //echo '<td class="txt">RP</td>';
        //echo '<td class="txt" align="right"><pre>|' . utf8_encode($row['rp']) . '|</td>';
        //echo '<td class="txt"><p class="error">RP inv&aacute;lido</p></td></tr>';
      }

      if (!preg_match('/^\d{11}$/', utf8_encode($row['nss']))) { 
        //NSS is invalid
        $campo = "NSS";
        $valor = utf8_encode($row['nss']);
        $observacion = "NSS inválido";
        $text = $renglon . "|" . $campo . "|" . $valor . "|" . $observacion . PHP_EOL;
        fwrite($fh, $text) or die($text . ":No se pudo escribir en el archivo");
        //echo $celda_num_renglon;
        //echo '<td class="txt">NSS</td>';
        //echo '<td class="txt" align="right"><pre>|' . utf8_encode($row['nss']) . '|</td>';
        //echo '<td class="txt"><p class="error">NSS inv&aacute;lido</p></td></tr>';
      }

      if (!preg_match('/^\d{10}$/', utf8_encode($row['numero_credito_vivienda']))) { 
        //numero_credito_vivienda is invalid
        $campo = "Número de Crédito de Vivienda";
        $valor = utf8_encode($row['numero_credito_vivienda']);
        $observacion = "Número de Crédito de Vivienda inválido";
        $text = $renglon . "|" . $campo . "|" . $valor . "|" . $observacion . PHP_EOL;
        fwrite($fh, $text) or die($text . ":No se pudo escribir en el archivo");
        //echo $celda_num_renglon;
        //echo '<td class="txt">N&uacute;mero de Cr&eacute;dito de Vivienda</td>';
        //echo '<td class="txt" align="right"><pre>|' . utf8_encode($row['numero_credito_vivienda']) . '|</td>';
        //echo '<td class="txt"><p class="error">N&uacute;mero de Cr&eacute;dito de Vivienda inv&aacute;lido</p></td></tr>';
      }

      /*
      if (!preg_match('/^[A-Z]{4}\d{6}[A-Z0-9][A-Z0-9][A0-9]$/', utf8_encode($row['rfc']))) { 
        //RFC is invalid
        $campo = "RFC";
        $valor = utf8_encode($row['rfc']);
        $observacion = "RFC inválido";
        $text = $renglon . "|" . $campo . "|" . $valor . "|" . $observacion . PHP_EOL;
        fwrite($fh, $text) or die($text . ":No se pudo escribir en el archivo");
        //echo $celda_num_renglon;
        //echo '<td class="txt">RFC</td>';
        //echo '<td class="txt" align="right"><pre>|' . utf8_encode($row['rfc']) . '|</td>';
        //echo '<td class="txt"><p class="error">RFC inv&aacute;lido</p></td></tr>';
      }
      */

      /*
      if (!preg_match('/^[A-Z]{4}\d{6}[HM][A-Z][A-Z][A-Z][A-Z][A-Z][A-Z0-9][0-9]$/', utf8_encode($row['curp']))) { 
        $campo = "CURP";
        $valor = utf8_encode($row['curp']);
        $observacion = "CURP inválida";
        $text = $renglon . "|" . $campo . "|" . $valor . "|" . $observacion . PHP_EOL;
        fwrite($fh, $text) or die($text . ":No se pudo escribir en el archivo");
        //echo $celda_num_renglon;
        //echo '<td class="txt">CURP</td>';
        //echo '<td class="txt" align="right"><pre>|' . utf8_encode($row['curp']) . '|</td>';
        //echo '<td class="txt"><p class="error">CURP inv&aacute;lido</p></td></tr>';
      }
      */
      
      if (!preg_match('/^[A-ZÑ ]*$/', utf8_encode($row['nombre_trabajador']) )) { 
        $campo = "Nombre del Trabajador";
        $valor = utf8_encode($row['nombre_trabajador']);
        $observacion = "Nombre del Trabajador inválido";
        $text = $renglon . "|" . $campo . "|" . $valor . "|" . $observacion . PHP_EOL;
        fwrite($fh, $text) or die($text . ":No se pudo escribir en el archivo");
        //echo $celda_num_renglon;
        //echo '<td class="txt">Nombre del Trabajador</td>';
        //echo '<td class="txt" align="right"><pre>|' . utf8_encode($row['nombre_trabajador']) . '|</td>';
        //echo '<td class="txt"><p class="error">Nombre del Trabajador inv&aacute;lido</p></td></tr>';
      }

      if (!preg_match('/^[1-3]$/', utf8_encode($row['tipo_descuento']) )) { 
        $campo = "Tipo de Descuento";
        $valor = utf8_encode($row['tipo_descuento']);
        $observacion = "Tipo de Descuento inválido";
        $text = $renglon . "|" . $campo . "|" . $valor . "|" . $observacion . PHP_EOL;
        fwrite($fh, $text) or die($text . ":No se pudo escribir en el archivo");
        //echo $celda_num_renglon;
        //echo '<td class="txt">Tipo de Descuento</td>';
        //echo '<td class="txt" align="right"><pre>|' . utf8_encode($row['tipo_descuento']) . '|</td>';
        //echo '<td class="txt"><p class="error">Tipo de Descuento inv&aacute;lido</p></td></tr>';
      }

      $descuento_invalido = false;
      if (utf8_encode($row['tipo_descuento']) == 1 ) { 
        if (!preg_match('/^[0]{2}[0-9]{2}[0]{4}$/', utf8_encode($row['valor_descuento']) )) {
          $descuento_invalido = true;
        }
      }
      else if (utf8_encode($row['tipo_descuento']) == 2 ) { 
        if (!preg_match('/^[0-9]{6}[0]{2}$/', utf8_encode($row['valor_descuento']) )) {
          $descuento_invalido = true;
        }
      }
      else if (utf8_encode($row['tipo_descuento']) == 3 ) { 
        if (!preg_match('/^[0]{1}[0-9]{7}$/', utf8_encode($row['valor_descuento']) )) {
          $descuento_invalido = true;
        }
      }

      if ($descuento_invalido) {
        $campo = "Valor de descuento";
        $valor = utf8_encode($row['valor_descuento']);
        $observacion = "Valor de Descuento inválido para Tipo de Descuento=" . utf8_encode($row['tipo_descuento']);
        $text = $renglon . "|" . $campo . "|" . $valor . "|" . $observacion . PHP_EOL;
        fwrite($fh, $text) or die($text . ":No se pudo escribir en el archivo");

        //echo $celda_num_renglon;
        //echo '<td class="txt">Valor de descuento</td>';
        //echo '<td class="txt" align="right"><pre>|' . utf8_encode($row['valor_descuento']) . '|</td>';
        //echo '<td class="txt"><p class="error">Valor de Descuento inv&aacute;lido para Tipo de Descuento=' . utf8_encode($row['tipo_descuento']) .' </p></td></tr>';
        //$output_form = 'yes';
      }

      if (!preg_match('/^[1-3]$/', utf8_encode($row['tipo_trabajador']) )) {
        $campo = "Tipo de Trabajador";
        $valor = utf8_encode($row['tipo_trabajador']);
        $observacion = "Tipo de Trabajador inválido";
        $text = $renglon . "|" . $campo . "|" . $valor . "|" . $observacion . PHP_EOL;
        fwrite($fh, $text) or die($text . ":No se pudo escribir en el archivo");
        //echo $celda_num_renglon;
        //echo '<td class="txt">' . $renglon . '</td>';
        //echo '<td class="txt">Tipo de Trabajador</td>';
        //echo '<td class="txt" align="right"><pre>|' . utf8_encode($row['tipo_trabajador']) . '|</td>';
        //echo '<td class="txt"><p class="error">Tipo de Trabajador inv&aacute;lido</p></td></tr>';
      }

      if (!preg_match('/^[0-9]{9}$/', utf8_encode($row['fecha_inicio_descuento']) )) {
        $anio        = substr(utf8_encode($row['fecha_inicio_descuento']), 0, 4);
        $mes        = substr(utf8_encode($row['fecha_inicio_descuento']), 4, 2);
        $dia        = substr(utf8_encode($row['fecha_inicio_descuento']), 6, 2);
        if (!checkdate($mes, $dia, $anio) ) {
          $campo = "Fecha de Inicio de Descuento";
          $valor = utf8_encode($row['fecha_inicio_descuento']);
          $observacion = "Fecha de Inicio de Descuento inválida";
          $text = $renglon . "|" . $campo . "|" . $valor . "|" . $observacion . PHP_EOL;
          fwrite($fh, $text) or die($text . ":No se pudo escribir en el archivo");
          //echo $celda_num_renglon;
          //echo '<td class="txt">Fecha de Inicio de Descuento</td>';
          //echo '<td class="txt" align="right"><pre>|' . utf8_encode($row['fecha_inicio_descuento']) . '|</td>';
          //echo '<td class="txt"><p class="error">Fecha de Inicio de Descuento inv&aacute;lida</p></td></tr>';
        }
      }

/*
      if (!preg_match('/^[ ]{8}$/', utf8_encode($row['espacios']) )) {
        $campo = "Campo Final Espacios";
        $valor = utf8_encode($row['espacios']);
        $observacion = "Campo Espacios inválido";
        $text = $renglon . "|" . $campo . "|" . $valor . "|" . $observacion . PHP_EOL;
        fwrite($fh, $text) or die($text . ":No se pudo escribir en el archivo");
        //echo $celda_num_renglon;
        //echo '<td class="txt">Campo Final Espacios</td>';
        //echo '<td class="txt" align="right"><pre>|' . utf8_encode($row['espacios']) . '|</td>';
        //echo '<td class="txt"><p class="error">Campo Espacios inv&aacute;lido</p></td></tr>';
      }
*/      

    }//Fin del While
  }//Fin del ciclo For
  echo '</table>';

  mysqli_close($dbc);

  fclose($fh);
  echo "Archivo |" . $target . "| escrito exitosamente";

?>

<?php
  // Insert the page footer
  require_once('footer.php');
?>

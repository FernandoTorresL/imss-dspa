<?php
  // Start the session
  require_once('startsession.php');

  // Insert the page header
  $page_title = 'Gesti&oacute;n Cuentas SINDO - Capturar Solicitud';
  require_once('headerCuentasSINDO.php');

  // Show the navigation menu
  require_once('navmenu.php');

  // Make sure the user is logged in before going any further.
  if (!isset($_SESSION['user_id'])) {
    echo '<p class="login">Por favor <a href="login.php">inicia sesi&oacute;n</a> para acceder a esta p&aacutegina.</p>';
    // Insert the page footer
    require_once('footer.php');
    exit();
  }

  require_once('appvars.php');
  require_once('connectvars.php');

  // Conectarse a la BD
  $dbc = mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);

  //$id_valija = 3;
  //Mostrar solicitudes
  // Grab the profile data from the database
  if (!isset($_GET['id_solicitud'])) {
    echo '<p class="error">Error en URL, sin par&aacute;metro de id_solicitud. Por favor <a href="indexCuentasSINDO.php">vuelve al inicio </a> para acceder correctamente a esta p&aacutegina.</p>';
    // Insert the page footer
    require_once('footer.php');
    exit();
  }
  else {
    $parametro = $_GET['id_solicitud'];
  }

  $query = "SELECT 
    solicitudes.id_solicitud AS num_solicitud, solicitudes.id_valija, solicitudes.fecha_captura_ca, 
    solicitudes.fecha_solicitud_del, solicitudes.id_lote, lotes.lote_anio,
    (SELECT CONCAT('(', valijas.delegacion,')', delegaciones.descripcion) FROM valijas, delegaciones WHERE valijas.id_valija = solicitudes.id_valija AND delegaciones.delegacion = valijas.delegacion) AS delsolicitante_descripcion, 
    solicitudes.delegacion AS num_del, delegaciones.descripcion AS delegacion_descripcion, 
    solicitudes.subdelegacion AS num_subdel, subdelegaciones.descripcion AS subdelegacion_descripcion, 
    solicitudes.nombre, solicitudes.primer_apellido, solicitudes.segundo_apellido, 
    solicitudes.matricula, solicitudes.curp, solicitudes.cargo, solicitudes.usuario, 
    movimientos.descripcion AS movimiento_descripcion, 
    grupos1.descripcion AS grupo_nuevo, grupos2.descripcion AS grupo_actual, 
    solicitudes.comentario, solicitudes.rechazado, solicitudes.archivo
    FROM solicitudes, delegaciones, subdelegaciones, movimientos, grupos grupos1, grupos grupos2, lotes
    WHERE solicitudes.id_solicitud  = '" . $parametro . "'
    AND   solicitudes.delegacion    = subdelegaciones.delegacion
    AND   solicitudes.subdelegacion = subdelegaciones.subdelegacion
    AND   solicitudes.delegacion    = delegaciones.delegacion
    AND   solicitudes.id_movimiento = movimientos.id_movimiento
    AND   solicitudes.id_grupo_nuevo= grupos1.id_grupo
    AND   solicitudes.id_grupo_actual= grupos2.id_grupo
    AND   solicitudes.id_lote       = lotes.id_lote
    ORDER BY solicitudes.id_movimiento ASC, solicitudes.usuario ASC";

//AND   solicitudes.id_valija     = $id_valija
    echo $query;
  $data = mysqli_query($dbc, $query);

  if (mysqli_num_rows($data) == 1) {
    $row = mysqli_fetch_array($data);
    // The user row was found so display the user data
    echo '<p class="titulo1">Detalle de la solicitud #' . $parametro . ' - ' . $row['usuario'] . '</p>';

    echo '<table>';
    echo '<tr><td class="titulo2"># de Lote:</td><td class="dato">' . $row['id_lote'] . ' / ' . $row['lote_anio'] . '</td></tr>';
    echo '<tr><td class="titulo2"># Valija:</td><td class="dato">' . $row['id_valija'] . '</td></tr>';
    echo '<tr><td class="titulo2"># Solicitud:</td><td class="dato">' . $row['num_solicitud'] . '</td></tr>';
    echo '<tr><td class="titulo2">Fecha captura:</td><td class="dato">' . $row['fecha_captura_ca'] . '</td></tr>';
    echo '<tr><td class="titulo2">Fecha de solicitud:</td><td class="dato">' . $row['fecha_solicitud_del'] . '</td></tr>';
    echo '<tr><td class="titulo2">Delegación que envía:</td><td class="dato">' . $row['delsolicitante_descripcion'] . '</td></tr>';
    echo '<tr><td class="titulo2">Delegación / Subdelegación:</td><td class="dato">(' . $row['num_del'] . ')' . $row['delegacion_descripcion'] . ' - (' . $row['num_subdel'] . ')' . $row['subdelegacion_descripcion'] . '</td></tr>';
    echo '<tr><td class="titulo2">Nombre completo:</td><td class="dato">' . $row['primer_apellido'] . '-' . $row['segundo_apellido'] . '-' . $row['nombre'] . '</td></tr>';
    echo '<tr><td class="titulo2">Matrícula - CURP:</td><td class="dato">' . $row['matricula'] . ' - ' . $row['curp'] . '</td></tr>';
    echo '<tr><td class="titulo2">Cargo:</td><td class="dato">' . $row['cargo'] . '</td></tr>';
    //echo '<tr><td class="titulo2">CURP:</td><td class="dato">' . $row['curp_correcta'] . '</td></tr>';
    echo '<tr><td class="titulo2">Usuario:</td><td class="dato">' . $row['usuario'] . '</td></tr>';
    echo '<tr><td class="titulo2">Movimiento:</td><td class="dato">' . $row['movimiento_descripcion'] . '</td></tr>';
    echo '<tr><td class="titulo2">Grupo actual / Grupo nuevo:</td><td class="dato">' . $row['grupo_actual'] . ' / ' . $row['grupo_nuevo'] . '</td></tr>';
    echo '<tr><td class="titulo2">¿Rechazado?:</td><td class="dato">';
    if ($row['rechazado'] == 1) {
      echo 'NO PROCEDE';
    }
    else {
      echo '-';
    }
    echo '</td></tr>';
    echo '<tr><td class="titulo2">Comentario:</td><td class="dato">' . $row['comentario'] . '</td></tr>';
    echo '<tr><td class="titulo2">Archivo(s):</td><td class="dato">' . $row['archivo'] . '</td></tr>';
    echo '</table>';
    echo '<p><a href="editarsolicitud.php?id_solicitud=' . $row['num_solicitud'] . '">¿Deseas editar esta solicitud?</a></p>';
                                      
  } // End of check for a single row of user results
  else {
    echo '<p class="error">Hubo un problema al acceder al detalle de la solicitud. Reportalo al administrador</p>';
  }
  echo '</br>';
  //Mostrar solicitudes
  //$id_valija = 3;
  // Obtener todas las solicitudes capturadas al momento para la última valija
  echo '<p class="titulo1">&Uacute;ltimas solicitudes modificadas para la valija ' . $id_valija . '</p>';

  $query = "SELECT 
    solicitudes.id_solicitud, solicitudes.id_valija, solicitudes.fecha_captura_ca, 
    solicitudes.fecha_solicitud_del, solicitudes.id_lote, lotes.lote_anio,
    delegaciones.descripcion AS delegacion_descripcion, subdelegaciones.descripcion AS subdelegacion_descripcion, 
    solicitudes.nombre, solicitudes.primer_apellido, solicitudes.segundo_apellido, 
    solicitudes.matricula, solicitudes.curp, solicitudes.cargo, solicitudes.usuario, 
    movimientos.descripcion AS movimiento_descripcion, 
    grupos1.descripcion AS grupo_nuevo, grupos2.descripcion AS grupo_actual, 
    solicitudes.comentario, solicitudes.rechazado, solicitudes.archivo
    FROM solicitudes, delegaciones, subdelegaciones, movimientos, grupos grupos1, grupos grupos2
    WHERE solicitudes.id_valija     = $id_valija
    AND   solicitudes.delegacion    = subdelegaciones.delegacion
    AND   solicitudes.subdelegacion = subdelegaciones.subdelegacion
    AND   solicitudes.delegacion    = delegaciones.delegacion
    AND   solicitudes.id_movimiento = movimientos.id_movimiento
    AND   solicitudes.id_grupo_nuevo= grupos1.id_grupo
    AND   solicitudes.id_grupo_actual= grupos2.id_grupo
    AND   solicitudes.id_lote       = lotes.id_lote
    ORDER BY solicitudes.id_movimiento ASC, solicitudes.usuario ASC";
  $data = mysqli_query($dbc, $query);

  echo '<table border="1">';
  echo '<tr class="titulo2"><th># Solicitud</th>';
  echo '<th># Valija</th>';
  echo '<th># de Lote</th>';
  echo '<th>Fecha captura</th>';
  echo '<th>Delegaci&oacute;n que env&iacute;a</th>';
  echo '<th>Subdelegaci&oacute;n</th>';
  echo '<th>Primer apellido</th>';
  echo '<th>Segundo apellido</th><th>Nombre</th>';
  echo '<th>Matr&iacute;cula</th><th>CURP</th><th>Usuario</th>';
  echo '<th>Movimiento</th><th>Grupo nuevo</th><th>Grupo actual</th>';
  echo '<th>Comentario</th><th>Archivo</th>';
  echo '</tr>';

  if (mysqli_num_rows($data) == 0) {
    echo '</table></br><p class="error">No hay solicitudes capturadas para la valija ' . $id_valija . '</p></br>';
    require_once('footer.php');
    exit();
  }

  while ( $row = mysqli_fetch_array($data) ) {
    echo '<tr class="dato"><td class="lista"><a href="versolicitud.php?id_solicitud=' . $row['id_solicitud'] . '">' . $row['id_solicitud'] . '</a></td>';
    echo '<td class="lista"><a href="editarvalija.php?id_valija=' . $row['id_valija'] . '">' . $row['id_valija'] . '</a></td>';
    echo '<td class="lista">' . $row['id_lote'] . ' / ' . $row['lote_anio'] . '</td>'; echo '<td class="lista">' . $row['fecha_captura_ca'] . '</td>';
    echo '<td class="lista">' . $row['delegacion_descripcion'] . '</td>'; echo '<td class="lista">' . $row['subdelegacion_descripcion'] . '</td>';
    echo '<td class="lista">' . $row['primer_apellido'] . '</td>'; echo '<td class="lista">' . $row['segundo_apellido'] . '</td>'; echo '<td>' . $row['nombre'] . '</td>';
    echo '<td class="lista">' . $row['matricula'] . '</td>'; echo '<td class="lista">' . $row['curp'] . '</td>'; echo '<td class="lista">' . $row['usuario'] . '</td>';
    echo '<td class="lista">' . $row['movimiento_descripcion'] . '</td>'; echo '<td class="lista">' . $row['grupo_nuevo'] . '</td>'; echo '<td>' . $row['grupo_actual'] . '</td>';
    echo '<td class="lista">' . $row['comentario'] . '</td>'; echo '<td class="lista">' . $row['archivo'] . '</td>';
    echo '</tr>';
  }    

  echo '</table></br></br>';

  mysqli_close($dbc);
    
  // Insert the page footer
  require_once('footer.php');
?>

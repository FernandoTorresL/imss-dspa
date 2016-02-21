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

  if (isset($_POST['submit'])) {
    // Grab the profile data from the POST

    $fecha_solicitud_del = mysqli_real_escape_string($dbc, trim($_POST['fecha_solicitud_del']));
    $primer_apellido = mysqli_real_escape_string($dbc, trim($_POST['primer_apellido']));
    $segundo_apellido = mysqli_real_escape_string($dbc, trim($_POST['segundo_apellido']));
    $nombre = mysqli_real_escape_string($dbc, trim($_POST['nombre']));
    $matricula = mysqli_real_escape_string($dbc, trim($_POST['matricula']));
    $curp = mysqli_real_escape_string($dbc, trim($_POST['curp']));
    $usuario = mysqli_real_escape_string($dbc, trim($_POST['usuario']));


    $delnum = mysqli_real_escape_string($dbc, trim($_POST['cmbDelegaciones']));
    //echo 'del:' . $_POST['cmbDelegaciones'];
    //echo 'delnum:' . $delnum;
    $cmbDelegaciones = mysqli_real_escape_string($dbc, trim($_POST['cmbDelegaciones']));

    $subdelnum = mysqli_real_escape_string($dbc, trim($_POST['cmbSubdelegaciones']));
    $cmbSubdelegaciones = mysqli_real_escape_string($dbc, trim($_POST['cmbSubdelegaciones']));

    $cmbLotes = mysqli_real_escape_string($dbc, trim($_POST['cmbLotes']));
    $cmbValijas = mysqli_real_escape_string($dbc, trim($_POST['cmbValijas']));

    $cmbtipomovimiento = mysqli_real_escape_string($dbc, trim($_POST['cmbtipomovimiento']));

    $cmbgponuevo = mysqli_real_escape_string($dbc, trim($_POST['cmbgponuevo']));
    $cmbgpoactual = mysqli_real_escape_string($dbc, trim($_POST['cmbgpoactual']));


    $comentario = mysqli_real_escape_string($dbc, trim($_POST['comentario']));
    $timetime = time();
    $new_file = mysqli_real_escape_string($dbc, trim($_FILES['new_file']['name']));
    $new_file_type = $_FILES['new_file']['type'];
    $new_file_size = $_FILES['new_file']['size']; 
    $error = false;

    if (  !empty($cmbLotes) && !empty($cmbValijas) && !empty($fecha_solicitud_del) &&  
          ( !empty($primer_apellido) || !empty($segundo_apellido) || !empty($nombre) ) &&
          !empty($matricula) && !empty($curp) && !empty($usuario) && 
          !empty($cmbtipomovimiento) &&
          ( !empty($cmbgponuevo) || !empty($cmbgpoactual) ) &&
          !empty($new_file) &&
          ( ($cmbLotes <> 0) && ($cmbValijas <> 0) && 
            ($cmbtipomovimiento <> 0) && ( ($cmbgpoactual <> 0) || ($cmbgponuevo <> 0)) ) ) {
      
      if ( (($new_file_type == 'application/pdf') || ($new_file_type == 'image/gif') || 
            ($new_file_type == 'image/jpeg')      || ($new_file_type == 'image/pjpeg') ||
            ($new_file_type == 'image/png')
           ) && ($new_file_size > 0) && ($new_file_size <= MM_MAXFILESIZE_VALIJA) ) {

        if ($_FILES['new_file']['error'] == 0) {
          //Move the file to the target upload folder
          $timetime = time();
          // Move the file to the target upload folder
          $target = MM_UPLOADPATH_CTASSINDO . $timetime . " " . $new_file;
          //$target = MM_UPLOADPATH_CTASSINDO . basename($new_file);
          //echo 'Target:' . $target . '<br />';

          if (move_uploaded_file($_FILES['new_file']['tmp_name'], $target)) {
            // The new file file move was successful, now make sure any old file is deleted
            //if (!empty($old_file) && ($old_file != $new_file)) {
              //@unlink(MM_UPLOADPATH_CTASSINDO . $old_file);
              //echo 'unlink';

            //echo 'New_file_insert:' . $new_file . '<br />';
            $query = "INSERT INTO solicitudes 
              ( id_valija, id_lote, 
                fecha_solicitud_del, 
                delegacion, subdelegacion, 
                nombre, primer_apellido, segundo_apellido, matricula, curp, 
                usuario, id_movimiento, id_grupo_nuevo, id_grupo_actual,
                comentario, rechazado, archivo)
              VALUES 
              ( '$cmbValijas', '$cmbLotes',
                '$fecha_solicitud_del',
                '$cmbDelegaciones', '$cmbSubdelegaciones',
                '$nombre', '$primer_apellido', '$segundo_apellido', '$matricula', '$curp',
                '$usuario', '$cmbtipomovimiento', '$cmbgponuevo', '$cmbgpoactual',
                '$comentario', 0, '$timetime $new_file' )";
            //echo $query;

            mysqli_query($dbc, $query);

            // Confirm success with the user
            echo '<p><strong>La nueva solicitud ha sido creada exitosamente.</strong></p>';
            echo '<p>Volver al <a href="indexCuentasSINDO.php">inicio</a></p>';
            // Clear the score data to clear the form
            
            $fecha_solicitud_del = "";
            $cmbDelegaciones = "";
            $cmbSubdelegaciones = "";
            $nombre = "";
            $primer_apellido = "";
            $segundo_apellido = "";
            $matricula = "";
            $curp = "";
            $cargo = "";
            $usuario = "";
            $cmbtipomovimiento = "";
            $cmbgponuevo = "";
            $cmbgpoactual = "";
            $comentario = "";
            
            //mysqli_close($dbc);
            //exit();
          }
          else {
            echo '<p class="error">Lo sentimos, hubo un problema al cargar tu archivo.</p>';
          }
        }
      }
      else {
        echo '<p class="error">El archivo debe ser GIF, JPEG, PNG o PDF no mayor de '. (MM_MAXFILESIZE_VALIJA / 1024) . ' KB de tama&ntilde;o.</p>';
      }

      // Try to delete the temporary screen shot image file
      @unlink($_FILES['new_file']['tmp_name']); 
    }
    else {
      echo '<p class="error">Debes ingresar todos los datos obligatorios para registrar la solicitud.</p>';
    }
  //mysqli_close($dbc);
  }

  ?>

  <p>Por favor captura los datos solicitados para crear una nueva solicitud.</p>
    <form enctype="multipart/form-data" method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>">
      <fieldset>
        
        <legend>Informaci&oacute;n de la solicitud</legend>
        <input type="hidden" name="MAX_FILE_SIZE" value="<?php echo MM_MAXFILESIZE_SOLICITUD; ?>" />
        
        <label># de Lote:</label>
        <select id="cmbLotes" name="cmbLotes"></select><br />
        <label># de Valija:</label>
        <select id="cmbValijas" name="cmbValijas"></select><br />
        <label for="fecha_solicitud_del">Fecha solicitud:</label>
        <input type="date" id="fecha_solicitud_del" name="fecha_solicitud_del" value="<?php if (!empty($fecha_solicitud_del)) echo $fecha_solicitud_del; ?>" /><br />
        <label>Tipo de movimiento:</label>
        <select id="cmbtipomovimiento" name="cmbtipomovimiento"></select><br />
        <label>Delegaci&oacute;n IMSS:</label>
        <select id="cmbDelegaciones" name="cmbDelegaciones" value=32></select><br />
        <label>Subdelegaci&oacute;n IMSS:</label>
        <select id="cmbSubdelegaciones" name="cmbSubdelegaciones"></select><br />

        <label for="primer_apellido">Primer Apellido:</label>
        <input type="text" id="primer_apellido" name="primer_apellido" value="<?php if (!empty($primer_apellido)) echo $primer_apellido; ?>" /><br />
        <label for="segundo_apellido">Segundo Apellido:</label>
        <input type="text" id="segundo_apellido" name="segundo_apellido" value="<?php if (!empty($segundo_apellido)) echo $segundo_apellido; ?>" /><br />
        <label for="nombre">Nombre(s):</label>
        <input type="text" id="nombre" name="nombre" value="<?php if (!empty($nombre)) echo $nombre; ?>" /><br />

        <label for="matricula">Matr&iacute;cula:</label>
        <input type="text" id="matricula" name="matricula" value="<?php if (!empty($matricula)) echo $matricula; ?>" /><br />
        <label for="curp">CURP:</label>
        <input type="text" id="curp" name="curp" value="<?php if (!empty($curp)) echo $curp; ?>" /><br />

        <label for="usuario">Usuario:</label>
        <input type="text" id="usuario" name="usuario" value="<?php if (!empty($usuario)) echo $usuario; ?>" /><br />
        
        <label>Grupo Nuevo:</label>
        <select id="cmbgponuevo" name="cmbgponuevo"></select><br />
        <label>Grupo Actual:</label>
        <select id="cmbgpoactual" name="cmbgpoactual"></select><br />

        <label for="comentario">Comentario u observaci&oacute;n:</label>
        <textarea id="comentario" name="comentario"><?php if (!empty($comentario)) echo $comentario; ?></textarea><br />
        <label for="new_file">Archivo:</label>
        <input type="file" id="new_file" name="new_file" />

      </fieldset>
      <input type="submit" value="Registra solicitud" name="submit" />
    </form>

    <?php
      // Insert the page footer
      require_once('footer.php');
    ?>

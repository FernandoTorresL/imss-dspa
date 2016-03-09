<?php
// Start the session
  require_once('startsession.php');

  // Insert the page header
  $page_title = 'Listado de archivos Estudiantes-Enero 2016';
  require_once('header.php');

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

  // Connect to the database
  $dbc = mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);

  // Clear the error message
  $error_msg = "";

  //Si el usuario ya envío el archivo, empieza a validarlo.
  if (isset($_POST['submit'])) {
    $old_layout = mysqli_real_escape_string($dbc, trim($_POST['old_layout']));
    $new_layout = mysqli_real_escape_string($dbc, trim($_FILES['new_layout']['name']));
    $new_layout_type = $_FILES['new_layout']['type'];
    $new_layout_size = $_FILES['new_layout']['size']; 

    /*
    echo '<p>1. ' . $old_layout . '</p>';
    echo '<p>2. ' . $new_layout . '</p>';
    echo '<p>3. ' . $new_layout_type . '</p>';
    echo '<p>4. ' . $new_layout_size . '</p>';
    echo '<p>5. ' . MM_MAXFILESIZE_VAL . '</p>';
    */
    
    $error = false;

    // Validate and move the uploaded layout file, if necessary
    if (!empty($new_layout)) {
      //list($new_layout_width, $new_layout_height) = getimagesize($_FILES['new_picture']['tmp_name']);
      if ( ($new_layout_type == 'text/plain') && ($new_layout_size > 0) && ($new_layout_size <= MM_MAXFILESIZE_VAL) ) {
        if ($_FILES['new_layout']['error'] == 0) {
          // Move the file to the target upload folder for layouts
          $timetime = time();
          $target = MM_UPLOADPATH_VAL . $timetime . " " . basename($new_layout);

          if (move_uploaded_file($_FILES['new_layout']['tmp_name'], $target)) {
            // The new layout file move was successful, now make sure any old layout is deleted
            if (!empty($old_layout) && ($old_layout != $new_layout)) {
              @unlink(MM_UPLOADPATH_VAL . $old_layout);
            }
          }
          else {
            // The new layout file move failed, so delete the temporary file and set the error flag
            @unlink($_FILES['new_layout']['tmp_name']);
            $error = true;
            echo '<p class="error">Lo sentimos, hubo un problema al tratar de cargar el layout.</p>';
          }
        }
      }
      else {
        // The new picture file is not valid, so delete the temporary file and set the error flag
        @unlink($_FILES['new_layout']['tmp_name']);
        $error = true;
        echo '<p class="error">El archivo debe ser un archivo .txt y no mayor de ' . (MM_MAXFILESIZE_VAL / 1024) . ' KB .</p>';
      }
    }
    
    //Empieza a validar archivo layout
    if ( !$error ) {
      if ( !empty($new_layout) ) {
        //Validate...
        //echo "Aquí inicia validación...";
      }
      else {
        echo '<p class="error">Debes seleccionar un archivo para validar.</p>';
      }
    }
  } // End of check for form submission
  else{

    $query = "SELECT archivo, num_registros FROM dspa_archivos_estudiantes";
    //echo $query;
    $data = mysqli_query($dbc, $query);

    // Loop through the array of user data, formatting it as HTML
    echo '<h4>&Uacute;ltimos archivos cargados:</h4>';
    echo '<table>';

    while ($row = mysqli_fetch_array($data)) {

      echo '<tr><td>' . $row['archivo'] . '</td>';
      echo '<td>' . $row['num_registros'] . ' registros.</td>';
      // Only if the user is logged in show the link to the report details
      if (isset($_SESSION['user_id'])) {
        //echo '<td><a href="valreportdetail.php?archivo=' . $row['archivo'] . '">' . 'Ver reporte detallado</a></td></tr>';
        echo '<td><a href="generaxmlestudiantes.php?archivo=' . $row['archivo'] . '&num_registros=' . $row['num_registros'] . '">Genera reporte detallado</a></td></tr>';
      }
      else {
        echo '</tr>';
      }
    }
    echo '</table>';
  } 

  echo '<h4>Nota: Si el archivo a validar no se encuentra en la tabla anterior, favor de cargar el nuevo archivo.</h4>';
  echo '<p></p>';

  ?>

  <form enctype="multipart/form-data" method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>">
    <input type="hidden" name="MM_MAXFILESIZE_VAL" value="<?php echo MM_MAXFILESIZE_VAL; ?>" />
    <fieldset>
      <legend>Cargar nuevo archivo de Estudiantes</legend>

      <!-- <label for="new_picture">Imagen:</label> -->
      <!-- //<input type="file" id="new_picture" name="new_picture" /> -->
      <input type="hidden" name="old_layout" value="<?php if (!empty($old_layout)) echo $old_layout; ?>" />
      <label for="new_layout">Archivo:</label>
      <input type="file" id="new_layout" name="new_layout" />
      
      <?php if (!empty($old_layout)) {
          //echo '<img class="profile" src="' . MM_UPLOADPATH_PROFILE . $old_picture . '" alt="Imagen de Perfil" />';
          echo '<p class="error">No se encontró archivo de estudiantes</p>';
        } 
      ?>

    </fieldset>
    <input type="submit" value="Cargar Archivo" name="submit" />
  </form>

  <?php
  // Insert the page footer
  require_once('footer.php');
  ?>
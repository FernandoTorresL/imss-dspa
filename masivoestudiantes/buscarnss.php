<?php
  // Start the session
  require_once('startsession.php');

  require_once('appvars.php');
  require_once('connectvars.php');

  // Insert the page header
  $page_title = 'Proceso Masivo de Asignaci&oacute;n NSS 2016';
  require_once('header.php');

  // Make sure the user is logged in before going any further.
  if (!isset($_SESSION['user_id'])) {
    echo '<p class="login">Por favor <a href="../login.php">inicia sesión</a> para acceder a esta página.</p>';
    exit();
  }

  // Show the navigation menu
  require_once('navmenu.php');

  // Connect to the database
  $dbc = mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);

  if (isset($_POST['submit'])) {
    // Grab the profile data from the POST
    $curp = mysqli_real_escape_string($dbc, trim($_POST['curp']));
    // Check the CAPTCHA pass-phrase for verification
    
    //$user_pass_phrase = SHA1($_POST['verify']);
    //if ($_SESSION['pass_phrase'] == $user_pass_phrase) {

      if (!empty($curp)) {

        $query = "SELECT est_layout_operados.nss, est_layout_operados.curp, est_layout_operados.usuario_convencional,
          est_archivos.nombre_archivo, est_estatus_solicitudes.descripcion
          FROM est_layout_operados, est_archivos, est_estatus_solicitudes
          WHERE est_layout_operados.estatus_solicitud = est_estatus_solicitudes.id_estatus_sol
          AND   est_layout_operados.id_archivo = est_archivos.id_archivo
          AND curp = '$curp'";
        $data = mysqli_query($dbc, $query);

        if (mysqli_num_rows($data) == 0) {
          echo '</table></br><p class="error">No se ha asignado un NSS o no se cuenta a&uacute;n con la informaci&oacute;n</p></br>';
        }
        else {
          while ( $row = mysqli_fetch_array($data) ) {
            echo '<p class="titulo1">Registros localizados</p>';
            echo '<table border="1">';
            echo '<tr class="dato">';
              echo '<th>NSS</th>';
              echo '<th>CURP</th>';
              echo '<th>Identificador</th>';
              echo '<th>Archivo origen</th>';
              echo '<th>Estatus</th>';
            echo '</tr>';
            echo '<tr class="dato">';
              echo '<td class="lista">' . $row['nss'] . '</td>';
              echo '<td class="lista">' . $row['curp'] . '</td>';
              echo '<td class="lista">' . $row['usuario_convencional'] . '</td>';
              echo '<td class="lista">' . $row['nombre_archivo']  . '</td>';
              echo '<td class="lista">' . $row['descripcion'] . '</td>';
            echo '</tr>';
            echo '</table></br></br>';
          }
        }
         
        $query = "SELECT A.curp, 
          A.ciz, A.delegacion, E.descripcion, 
          A.subdelegacion, F.descripcion AS descripcionsubdel,
          A.apellido_paterno, A.apellido_materno, A.nombre,
          A.sexo, D.descripcion AS descripcionsexo,
          A.mes_nacimiento, 
          A.lugar_nacimiento, C.descripcion AS descripcionlugar, 
          A.anio_nacimiento, 
          B.nombre_archivo
        FROM est_layout_didtB A, est_archivos B, entidades_renapo C, sexo D, delegaciones E, subdelegaciones F
        WHERE A.id_archivo = B.id_archivo
        AND   A.sexo = D.id_alf_sexo
        AND   A.lugar_nacimiento = C.id_entidad_renapo
        AND   A.delegacion = E.delegacion
        AND   A.delegacion = F.delegacion
        AND   A.subdelegacion = F.subdelegacion
        AND   A.curp = '$curp'";
        $data = mysqli_query($dbc, $query);

        if (mysqli_num_rows($data) == 0) {
          echo '</table></br><p class="error">No se ha encontrado el NSS en los archivos enviados</p></br>';
        }
        else {
          while ( $row = mysqli_fetch_array($data) ) {
            echo '<p class="titulo1">Registros localizados en Layouts</p>';
            echo '<table border="1">';
            echo '<tr class="dato">';
              echo '<th>CURP</th>';
              echo '<th>CIZ</th>';
              echo '<th>Delegacion</th>';
              echo '<th>Subdelegacion</th>';
              echo '<th>Apellido Paterno</th>';
              echo '<th>Apellido Materno</th>';
              echo '<th>Nombre</th>';
              echo '<th>Sexo</th>';
              echo '<th>Mes de nacimiento</th>';
              echo '<th>Lugar de nacimiento</th>';
              echo '<th>Anio de nacimiento</th>';
              echo '<th>Archivo origen</th>';
            echo '</tr>';
          
            echo '<tr class="dato">';
              echo '<td class="lista">' . $row['curp'] . '</td>';
              echo '<td class="lista">' . $row['ciz'] . '</td>';
              echo '<td class="lista">' . '(' . $row['delegacion'] . ')' . $row['descripcion'] . '</td>';
              echo '<td class="lista">' . '(' . $row['subdelegacion'] . ')' . $row['descripcionsubdel'] . '</td>';
              echo '<td class="lista">' . $row['apellido_paterno']  . '</td>';
              echo '<td class="lista">' . $row['apellido_materno']  . '</td>';
              echo '<td class="lista">' . $row['nombre']  . '</td>';
              echo '<td class="lista">' . '(' . $row['sexo'] . ')' . $row['descripcionsexo'] . '</td>';
              echo '<td class="lista">' . $row['mes_nacimiento'] . '</td>';
              echo '<td class="lista">' . '(' . $row['lugar_nacimiento'] . ')' . $row['descripcionlugar'] . '</td>';
              echo '<td class="lista">' . $row['anio_nacimiento'] . '</td>';
              echo '<td class="lista">' . $row['nombre_archivo'] . '</td>';
            echo '</tr>';
            echo '</table></br></br>';
          }
        }
      }
      else {
        echo '<p class="error">Debes ingresar todos los datos.</p>';
      }
  }

?>
  
<p>Por favor captura la CURP deseada para mostrar la informaci&oacute;n.</p>
  <form method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>">
    <fieldset>
      <legend>B&uacute;squeda de informaci&oacute;n</legend>
      <label for="curp">CURP</label>
      <input type="text" id="curp" name="curp" value="<?php if (!empty($curp)) echo $curp; ?>" /><br />
    </fieldset>
    <input type="submit" value="Busca CURP" name="submit" />
  </form>

<?php
  // Insert the page footer
  require_once('footer.php');
?>


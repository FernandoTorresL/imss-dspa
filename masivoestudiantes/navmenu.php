<?php
  // Generate the navigation menu
  echo '<hr />';
  if (isset($_SESSION['username'])) {
    echo '<a href="../index.php">Inicio</a> &#10070; ';
    
    echo '<a href="indexme.php">Proceso Masivo Estudiantes 2016</a> &#10070; ';

    echo '&#10070; <a href="../logout.php">Cerrar Sesi&oacute;n (' . $_SESSION['username'] . ')</a>';
  }
  else {
    echo '<a href="../index.php">Inicio</a> &#10070; ';
    
    echo '<a href="../login.php">Iniciar sesi&oacute;n</a> &#10070; ';
    echo '<a href="../signup.php">Registrar nuevo usuario</a>';
  }
  echo '<hr />';
?>

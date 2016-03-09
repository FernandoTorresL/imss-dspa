<?php
  // Start the session
  require_once('startsession.php');

  require_once('appvars.php');
  require_once('connectvars.php');

  // Insert the page header
  $page_title = 'Proceso Masivo de Asignaci&oacute;n NSS 2016';
  require_once('header.php');

  if (!isset($_SESSION['user_id'])) {
    echo '<p class="login">Por favor <a href="../login.php">inicia sesión</a> para acceder a esta página.</p>';
    // Insert the page footer
    require_once('footer.php');
    exit();
  }

  // Show the navigation menu
  require_once('navmenu.php');

  echo '<p class="login">Ir a <a href="buscarnss.php">buscar NSS</a>.</p>';

  require_once('footer.php');
?>


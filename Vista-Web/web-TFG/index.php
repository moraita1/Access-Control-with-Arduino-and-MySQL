<?php
    require_once("utils/header.php");
    require_once("utils/dbutils.php");
    $miConexion= conectarDB();
    if ($miConexion->connect_error) {
        die("Error de conexión: " . $miConexion->connect_error);
    }
    $vectorCiclo=getCiclos($miConexion);
?>

<html>
  <head>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f2f2f2;
      margin: 0;
      padding: 0;
    }

    .container {
      width: 80%;
      max-width: 800px;
      margin: 0 auto;
      padding: 20px;
      background-color: #ffffff;
      border-radius: 5px;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    h1 {
      font-size: 24px;
      margin-bottom: 20px;
    }

    select {
      width: 100%;
      padding: 10px;
      margin-bottom: 10px;
      border: 1px solid #ccc;
      border-radius: 4px;
      box-sizing: border-box;
    }

    input[type="submit"] {
      padding: 10px 20px;
      background-color: #4CAF50;
      color: #ffffff;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }

    input[type="submit"]:hover {
      background-color: #45a049;
    }
  </style>
 </head>
  <body>
    <form action="horario.php" method="post">
    <div class="container">
      <h1>Selecciona el modulo y el curso</h1>
      <select name="ciclo" required>
            <option disabled selected>Selecciona un ciclo</option>
            <?php
                if ($vectorCiclo->num_rows > 0) {
                    while ($row = $vectorCiclo->fetch_assoc()) {
                        $ciclo = $row['nombre_ciclo'];
                        $cod_ciclo = $row['cod_ciclo'];
                        echo "<option value='$cod_ciclo'>$ciclo</option>" ;
                    }
                }
             else {
                echo "<option value=''>No hay ciclos disponibles</option>";
            }
            ?>
        </select>
        <select name="curso" required>
            <option disabled selected>Selecciona un curso</option>
            <option value='1'>Primero</option>
            <option value='2'>Segundo</option>
        </select>
        <br><br>
      <div class="form-group">
        <input type="submit" name="confirm"class="form-control" placeholder="Confirmar" value="confirmar">
      </div>
    </div>
    </form>
  </body>
</html>
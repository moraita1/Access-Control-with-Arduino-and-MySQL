<?php
require_once("utils/header.php");
require_once("utils/dbutils.php");

//var_export($_POST);
$cod_ciclo=$_POST['ciclo'];
$curso=$_POST['curso'];
$miConexion= conectarDB();
//var_export($miConexion);
if ($miConexion->connect_error) {
    die("Error de conexión: " . $miConexion->connect_error);
}
$vectorHorario=getAllHorario($miConexion,$cod_ciclo,$curso);
//var_export($vectorHorario);
?>

<!DOCTYPE html>
<html>
<head>
    <title>HORARIO</title>
    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            overflow: hidden;
        }
        .container {
            margin-top: 2%;
            height: 100vh;
            width: 100vw;
            margin-bottom: 0%;
        }
        .horario {
            width: 100%;
            border-collapse: collapse;
        }

        .horario th, .horario td {
            padding: 10px;
            text-align: center;
            border: 1px solid #ccc;
        }

        .horario th {
            background-color: #f2f2f2;
        }

        .horario tr:first-child th {
            background-color: #ddd;
        }
    </style>
</head>
<body>
    <div class="container">
    <center>
    <table class="horario">
        <tr>
            <th>HORAS</th>
            <th>LUNES</th>
            <th>MARTES</th>
            <th>MIERCOLES</th>
            <th>JUEVES</th>
            <th>VIERNES</th>
        </tr>
        <?php
            if ($vectorHorario->num_rows > 0) {
                $horario = array();
            
                while ($row = $vectorHorario->fetch_assoc()) {
                    $hora = $row["HORA_INICIO"];
                    $diaSemana = $row["ID_DIA"];
                    $profesor = $row["NOMBRE_PROFESOR"];
                    $asignatura = $row["NOMBRE_MODULO"];
                    $tarjeta = $row["UID_TARJETA"];
            
                    $horario[$hora][$diaSemana] = array(
                        "profesor" => $profesor,
                        "asignatura" => $asignatura,
                        "tarjeta" => $tarjeta
                    );
                }
            
                foreach ($horario as $hora => $dias) {
                    echo "<tr>";
                    echo "<td>$hora</td>";
            
                    for ($i = 0; $i < 5; $i++) {
                        echo "<td>";
                        if (isset($dias[$i])) {
                            $dia = $dias[$i];
                            echo "<b>" . $dia["asignatura"] . "</b><br>";
                            echo "" . $dia["profesor"] . "<br>";
                            echo "" . $dia["tarjeta"];
                        }
                        echo "</td>";
                    }
            
                    echo "</tr>";
                }
            
                echo "</table>";
            }
        ?>
    </table>
    </center>
    </div>
</body>
</html>

<?php 

    function conectarDB()
    {
        $conexion= mysqli_connect("localhost", "root", "","DB_TFG");
        return $conexion;
    }


    function getAllHorario($db_con,$ciclo,$curso)
    {
        $sql = "SELECT concat_ws(' ', NOMBRE_USUARIO, APELLIDO1_USUARIO, APELLIDO2_USUARIO) AS NOMBRE_PROFESOR,
        NOMBRE_MODULO, UID_TARJETA, ID_DIA, DATE_FORMAT(HORA_INICIO, '%H:%i') as HORA_INICIO FROM VW_VISTA_HORARIO_COMPLETO_2asir
        WHERE COD_CICLO = ? AND CURSO = ? order by HORA_INICIO";
        $stmt = $db_con->prepare($sql);
        $stmt->bind_param("ii", $ciclo, $curso); 
        $stmt->execute();
        $result = $stmt->get_result();
        return $result;
    }

    function getCiclos($db_con)
    {
        $query="select cod_ciclo, nombre_ciclo from tb_ciclo";
        $result=$db_con->query($query);
        return $result;
    }


?>

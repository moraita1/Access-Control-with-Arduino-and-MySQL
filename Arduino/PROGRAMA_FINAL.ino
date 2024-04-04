//Declarar bibliotecas
#include <Ethernet.h>
#include <MySQL_Connection.h>
#include <MySQL_Cursor.h>
#include <Servo.h>
#include <SPI.h>			
#include <MFRC522.h>	
#include <LiquidCrystal.h>		

byte mac_addr[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED }; //MAC de tarjeta de red arduino

IPAddress server_addr(192,168,0,3);  // IP del servidor MYSQL
char user[] = "root";              // Usuario MySQL 
char password[] = "#Ismael2001";        // Contraseña MySQL 

// Query para obtener el uid de la tarjeta 
char query[] = "select t.uid_tarjeta from DB_TFG.tb_tarjeta as t inner join DB_TFG.tb_usuario as u on u.cod_tarjeta=t.cod_tarjeta inner join DB_TFG.tb_profesor as p on p.cod_profesor=u.cod_usuario inner join DB_TFG.tb_modulo as m on m.cod_profesor=p.cod_profesor inner join DB_TFG.TB_MODULO_SE_IMPARTE_HORARIO as mh on mh.cod_modulo=m.cod_modulo inner join DB_TFG.tb_horario as h on h.cod_horario=mh.cod_horario WHERE h.ID_DIA=1 AND h.hora_inicio=(SELECT MAX(CASE WHEN HORA_INICIO < NOW() THEN HORA_INICIO END) from DB_TFG.tb_horario) and m.cod_ciclo=2 and m.curso=2";
String result2; //Variable que almacena el uid de la tarjeta

//Query para conseguir el nombre del módulo
char query2[] = "SELECT M.NOMBRE_MODULO FROM DB_TFG.tb_tarjeta AS t INNER JOIN DB_TFG.tb_usuario AS u ON u.cod_tarjeta=t.cod_tarjeta INNER JOIN DB_TFG.tb_profesor AS p ON p.cod_profesor=u.cod_usuario INNER JOIN DB_TFG.tb_modulo AS m ON m.cod_profesor=p.cod_profesor INNER JOIN DB_TFG.TB_MODULO_SE_IMPARTE_HORARIO AS mh ON mh.cod_modulo=m.cod_modulo INNER JOIN DB_TFG.tb_horario AS h ON h.cod_horario=mh.cod_horario WHERE h.ID_DIA=1 AND h.hora_inicio=(SELECT MAX(CASE WHEN HORA_INICIO < NOW() THEN HORA_INICIO END) FROM DB_TFG.tb_horario) AND m.cod_ciclo=2 AND m.curso=2";
String result; // Variable para guardar el nombre del módulo

//Establecer conexión a servidor MYSQL
EthernetClient client;
MySQL_Connection conn((Client *)&client);
MySQL_Cursor cur = MySQL_Cursor(&conn);



//Constantes necesarias para establecer conexón a módulo NFC
#define RST_PIN  5			// Constante para referenciar pin de reset
#define SS_PIN  53			// Constante para referenciar pin de slave select

MFRC522 mfrc522(SS_PIN, RST_PIN);	// Crea objeto mfrc522 enviando pines de slave select y reset

//Variables utilizadas para el funcionamiento del servomotor
int servoPin = 12;
int servoPos = 0;
int servoPosFin = 90;
Servo myServo;
unsigned long tiempoInicial = 0;
unsigned long tiempoActual = 0;

//Constantes declaradas para pantalla lcd
const int rs = 41, en = 39, d4 = 37, d5 = 35, d6 = 33, d7 = 31;
LiquidCrystal lcd(rs, en, d4, d5, d6, d7);

//Declaración del bucle setup
void setup() {
  Serial.begin(115200); //Para mostrar los resultados en pantalla serial
  //Bucle para establecer conexión a través del DHCP y conectarse a MYSQL
  while (!Serial); 
  Ethernet.begin(mac_addr);
  Serial.println("Connecting...");
  if (conn.connect(server_addr, 3306, user, password)) {
    delay(1000);
  }
  else
    Serial.println("Connection failed.");

  //NFC
  SPI.begin();				// inicializa bus SPI
  mfrc522.PCD_Init();			// inicializa modulo lector

  //SERVOMOTOR
  myServo.attach(servoPin); //declarar el servo en el software
  myServo.write(servoPosFin); // Mover el servomotor a la posición servoPosFin al inicio
  delay(1000); // Esperar 1 segundo para que se complete el movimiento del servomotor
  tiempoInicial = millis(); // Guardar el tiempo inicial

  //PANTALLA LCD
  lcd.begin(16, 2); //Incicializar columnas y filas lcd
}

//Declarar bucle loop
void loop() {
  if (result2 == "") { // Comprobar que la variable result2 esta vacia
    row_values *row = NULL;

    delay(1000);
    cur.execute(query); //Ejecutar Query
    cur.get_columns(); //Recorrer columnas

    // Bucle para obtener las filas del resultado de la query
    do {
      row = cur.get_next_row();
      if (row != NULL) {
        result2 = row->values[0];
      }
    } while (row != NULL);

    // Cerramos el cursor para liberar el espacio en la memoria
    cur.close();
  }

  String resultado = ""; // Variable para almacenar el uid de la tarjeta que se pasa por el lector

if (!mfrc522.PICC_IsNewCardPresent()) { // Si no hay una tarjeta presente
  return; // Retorna al loop esperando por una tarjeta
}

if (!mfrc522.PICC_ReadCardSerial()) { // Si no puede obtener datos de la tarjeta
  return; // Retorna al loop esperando por otra tarjeta
}

for (byte i = 0; i < mfrc522.uid.size; i++) { // Bucle recorre de a un byte por vez el UID
  if (mfrc522.uid.uidByte[i] < 0x10) { // Si el byte leído es menor a 0x10
    resultado.concat("0"); // Concatena un espacio en blanco y el número cero
  } else { // Sino
    resultado.concat(""); // Concatena un espacio en blanco
  }
  resultado.concat(String(mfrc522.uid.uidByte[i], HEX)); // Concatena el byte del UID leído en hexadecimal
}

mfrc522.PICC_HaltA(); // Detiene comunicación con la tarjeta

resultado.toUpperCase(); // Convierte el contenido de la variable 'resultado' a mayúsculas
Serial.println(resultado); // Muestra el contenido en mayúsculas en el monitor serial

if (result == "") { // comprueba que la variable result está vacía
    row_values *row = NULL;

    delay(1000);

    // ejecutar la segunda query
    cur.execute(query2);
    // Recorrer las columnas de la consulta.
    cur.get_columns();

    // Bucle para obtener las filas del resultado de la query
    do {
      row = cur.get_next_row();
      if (row != NULL) {
        result = row->values[0];
      }
    } while (row != NULL);

    // Cerrar el cursor para liberar el espacio de la memoria
    cur.close();
  }
Serial.println(result);
//Condición que compara los uid de las tarjetas 
if (result2 == resultado || resultado == "034D6011") {
  // Código a ejecutar si la condición se cumple
  Serial.println("q si");
  tiempoActual = millis(); // Obtener el tiempo actual
  myServo.write(servoPos); // Actualizar la posición del motor
  lcd.print("Bienvenido a:"); // Lo escribe en la pantalla LCD
  lcd.setCursor(0, 1);
  lcd.print(result); // Escribe el nombre del módulo
  // Bucle para que se mueva el texto en la pantalla LCD
    for (int positionCounter = 0; positionCounter < result.length()-16; positionCounter++) {
    // se mueve hacia la izquierda
    lcd.scrollDisplayLeft();
    //espera un tiempo:
    delay(150);
  }


  // Bucle para que se regrese el texto en la pantalla LCD
  for (int positionCounter = 0; positionCounter < result.length()-16; positionCounter++) {
    // se mueve hacia la derecha
    lcd.scrollDisplayRight();
    // espera un tiempo:
    delay(150);
  }
  delay(1000); // Tiempo  para que se complete el movimiento del servomotor
    
  myServo.write(servoPosFin); // el servo vuelve a la posición
} else {
  // Código a ejecutar si el acceso ha sido denegado
  lcd.print("ESTA NO ES TU ");
  lcd.setCursor(0, 1);
  lcd.print("CLASE");
}



}
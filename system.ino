#include <ESP8266HTTPClient.h>
#include <ESP8266WiFi.h>

#define SS_PIN D4 
#define RST_PIN D3 

#include <Servo.h>
#include <SPI.h>
#include <MFRC522.h>

Servo servo_1;
MFRC522 mfrc522(SS_PIN, RST_PIN);   // Create MFRC522 instance.
int statuss = 0;
int out = 0;

void setup() 
{
  pinMode(LED_BUILTIN, OUTPUT);
  digitalWrite(LED_BUILTIN, HIGH);
  Serial.begin(9600);   // Initiate a serial communication
  SPI.begin();      // Initiate  SPI bus
  mfrc522.PCD_Init();   // Initiate MFRC522
  servo_1.attach(4);
  WiFi.begin("WIFI-NAME", "WIFI-PASSWORD");
  
  while (WiFi.status() != WL_CONNECTED) {  //Wait for the WiFI connection completion
    delay(500);
    Serial.println("Waiting for connection");
  }

  if (WiFi.status() == WL_CONNECTED) {
    digitalWrite(LED_BUILTIN, LOW);
    delay(1000);
    digitalWrite(LED_BUILTIN, HIGH);
    Serial.println("Connected!");
  }
    
}
void loop() 
{
  // Look for new cards
  if ( ! mfrc522.PICC_IsNewCardPresent()) 
  {
    return;
  }
  // Select one of the cards
  if ( ! mfrc522.PICC_ReadCardSerial()) 
  {
    return;
  }
  
  //Show RFID ID card number on serial monitor
  Serial.println();
  Serial.print(" RFID ID :");
  String content= "";
  byte letter;
  for (byte i = 0; i < mfrc522.uid.size; i++) 
  {
     Serial.print(mfrc522.uid.uidByte[i] < 0x10 ? " 0" : "");
     Serial.print(mfrc522.uid.uidByte[i], HEX);
     content.concat(String(mfrc522.uid.uidByte[i] < 0x10 ? " 0" : ""));
     content.concat(String(mfrc522.uid.uidByte[i], HEX));
  }
  content.toUpperCase();
  Serial.println();
  Serial.println(content);
  

  HTTPClient http;
  http.begin(String("http://[SERVER IP ADDRESS]/[PATH]/server.php")); //Opening the server
  int code = http.POST(content);  //Posting the RFID ID card number to the server
  Serial.print("RFID ID card number :");
  Serial.println(code);
  if (code > 0) {
    digitalWrite(LED_BUILTIN, LOW);
  }
  String payload = http.getString(); //Get the response payload
 
  Serial.println(payload); //Print request response payload

  if (payload == "0") { //Payload 0 means the RFID id card number doesn't exist on the database
    Serial.println("User is not recognized by the system, cannot enter the room.");
  } else {
    servo_1.write (45); // Servo will move to 45 degree angle.
    delay (1000);
    servo_1.write (90);  // servo will move to 90 degree angle.
    delay (1000); 
  }

  http.end();

  delay(5000);
  
} 

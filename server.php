<?php
date_default_timezone_set("Asia/Jakarta"); //Set the default timezone
echo date_default_timezone_get();

//Make the variable to connect to the database
$servername = "localhost"; 
$username = "root";
$password = "";
$dbname = "aegis";
$request = file_get_contents("php://input");

//Connect to mysql server
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 

//Make date object
$now = new DateTime();  
$datenow = $now->format("Y-m-d H:i:s");

//Make query
$validasi = "SELECT COUNT(nomor_rfid) AS ttl FROM identitas WHERE nomor_rfid = '$request'"; //Check if the RFID ID received from nodeMCU exists on the table

//Do the query
$jml = $conn->query($validasi);
$hsl = $jml->fetch_all(PDO::FETCH_ASSOC);
$jmlh = $hsl[0][0];

echo $jmlh; //Will return "1" if the RFID ID exists, will return "0" if it doesn't

if ($jmlh > 0) {
	
	//Check if the user is already in the room, will return "1" if they are and will return "0" otherwise 
	$jumlah_rfid = "SELECT COUNT(nomor_rfid) AS total FROM pengguna_ruangan WHERE nomor_rfid = '$request'";
	$jml_rfid = $conn->query($jumlah_rfid);
	$hasil = $jml_rfid->fetch_all(PDO::FETCH_ASSOC);
	$jumlah = $hasil[0][0];

	
	if ($jumlah == 0) { //Condition where the user is not inside the room, make a new row and input the current time as "entry time"
		$sql = "INSERT INTO pengguna_ruangan (nomor_rfid, waktu_masuk) VALUES ('$request', '$datenow')";
		if ($conn->query($sql) === TRUE) {
		   // echo "New record created successfully";
		} else {
		    //echo "Error: " . $sql . "<br>" . $conn->error;
		}	
	} else { //Condition where the user is not inside the room, input the current time as "exit time"

		$rfid_notnull = "SELECT COUNT(nomor_rfid) AS total2 FROM pengguna_ruangan WHERE nomor_rfid = '$request' AND waktu_keluar IS NOT NULL";
		$jml_rfid_notnull = $conn->query($rfid_notnull);
		$hasil2 = $jml_rfid_notnull->fetch_all(PDO::FETCH_ASSOC);
		$jumlah2 = $hasil2[0][0];
		

		if (($jumlah - $jumlah2) == 1) {
			$update_1 = "UPDATE pengguna_ruangan SET waktu_keluar = '$datenow' WHERE nomor_rfid LIKE ('$request') AND waktu_keluar IS NULL";
			if ($conn->query($update_1) === TRUE) {
			  //  echo "Update record created successfully";
			} else {
			    //echo "Error: " . $sql . "<br>" . $conn->error;
			}
		} else {
			$update_2 = "INSERT INTO pengguna_ruangan (nomor_rfid, waktu_masuk) VALUES ('$request', '$datenow')";
			if ($conn->query($update_2) === TRUE) {
			    //echo "New record created successfully";
			} else {
			    //echo "Error: " . $sql . "<br>" . $conn->error;
			}
		}
	}
}
$conn->close();
?>

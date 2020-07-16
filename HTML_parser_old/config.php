<?php
$username="peasfu";
$password="R1p952qw"; 
$host="139.179.21.33";
$db_name="peasf"; //change databasename

$connect=mysqli_connect($host,$username,$password,$db_name);

if(!$connect)
{
	die("Connection failed: " . mysqli_connect_error());
}

echo "Connected successfully";

?>
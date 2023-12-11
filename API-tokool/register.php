<?php
	header("Access-Control-Allow-Origin: *");
	include_once 'conexion.php';
	$uriSegments = explode("/", parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH));
	$table = 'pegawai';
	
	//$user = $_POST['username'];
	//$email = $_POST['email'];
	//$phone = $_POST['phone'];
	//$pass= $_POST['password'];
	
	$getJson = file_get_contents('php://input');
	$json = json_decode($getJson);
	$user = $json->username;
	$email = $json->email;
	$phone = $json->phone;
	$pass= $json->password;
	
	$result = $connect->query("INSERT INTO ".$table." (username,email,phone,password) 
							   VALUES ('".$user."','".$email."','".$phone."',md5('".$pass."'))");
	
	if($result)
	{
		$response=array(
		 'error' => false,
		 'message' =>null
		);
	}
	else
	{
		$response=array(
		 'error' => true,
		 'message' =>'Daftar Pegawai gagal'
		);
	}
	header('Content-Type: application/json');
	echo json_encode($response);
?>
<?php
	header("Access-Control-Allow-Origin: *");
	include_once 'conexion.php';
	$uriSegments = explode("/", parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH));
	$table = 'pegawai';
	
	//$user = $_POST['username'];
	//$email = $_POST['email'];
	//$phone = $_POST['phone'];
	
	$getJson = file_get_contents('php://input');
	$json = json_decode($getJson);
	$user = $json->username;
	$email = $json->email;
	$phone = $json->phone;
	
	$result = $connect->query("UPDATE ".$table." set email='".$email."', phone='".$phone."' 
					 where username='".$user."';");
	
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
		 'message' =>'Ubah Pegawai gagal'
		);
	}
	header('Content-Type: application/json');
	echo json_encode($response);
?>
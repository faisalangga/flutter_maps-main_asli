<?php
	header("Access-Control-Allow-Origin: *");
	include_once 'conexion.php';
	$uriSegments = explode("/", parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH));
	$table = 'pegawai';
	
	//$user = $_POST['username'];
	
	$getJson = file_get_contents('php://input');
	$json = json_decode($getJson);
	$user = $json->username;
	$queryResult=$connect->query("select * from ".$table." where username = '".$user."'");
	$cekuser = $queryResult->num_rows;

	$result=array();
	while($fetchData=$queryResult->fetch_assoc()){
		$result[]=$fetchData;
	}
	
	if ($cekuser>0)
	{
		$response=array(
			'error' => false,
			'message' =>null,
			'data' => $result
		);
	}
	else
	{
		$response=array(
			'error' => true,
			'message' =>'Get Pegawai gagal',
			'data' => null
		);
	}
	header('Content-Type: application/json');
	echo json_encode($response);
?>
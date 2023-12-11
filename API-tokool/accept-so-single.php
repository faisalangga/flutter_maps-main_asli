<?php
	header("Access-Control-Allow-Origin: *");
	include 'conexion.php';
	$uriSegments = explode("/", parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH));
	$table = 'so_check';

	$getJson = file_get_contents('php://input');
	$json = json_decode($getJson);
	$nobukti = $json->nobukti;
	$user = $json->username;
	
	$cekfield = $connect->query("SELECT COUNT(*) as ADA FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'so' AND COLUMN_NAME = 'POSTED_ACCEPT'");
	if ($cekfield->ADA==0)
	{
		$connect->query("
			ALTER TABLE `so`
			ADD COLUMN `POSTED_ACCEPT`  varchar(1) NOT NULL DEFAULT '0' AFTER `SLS`,
			ADD COLUMN `USRNM_ACCEPT`  varchar(20) NOT NULL DEFAULT '' AFTER `POSTED_ACCEPT`,
			ADD COLUMN `TGL_ACCEPT`  datetime NULL DEFAULT '2001-01-01' AFTER `USRNM_ACCEPT`");
	}
	
    $result = $connect->query("UPDATE so SET POSTED_ACCEPT=1, USRNM_ACCEPT='".$user."', TGL_ACCEPT=NOW() WHERE NO_BUKTI='".$nobukti."' and POSTED_ACCEPT=0");
	
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
		 'message' =>'Accept Job gagal'
		);
	}
	header('Content-Type: application/json');
	echo json_encode($response);
?>
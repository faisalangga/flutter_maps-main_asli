<?php
	header("Access-Control-Allow-Origin: *");
	include_once 'conexion.php';
	$table = 'so';
	
	$getJson = file_get_contents('php://input');
	$json = json_decode($getJson);
	$user = $json->username;
	
	$queryResult=$connect->query("SELECT NO_BUKTI,TGL,NAMAC,NA_BRG,NAMAT,NOTES,KG,TOTAL 
								  from ".$table." 
								  where USRNM_ASSIGN = '".$user."' and POSTED_ACCEPT=0 
								  ORDER BY NO_BUKTI");
	$cekso = $queryResult->num_rows;

	$result=array();
	while($fetchData=$queryResult->fetch_assoc()){
		$result[]=$fetchData;
	}
	
	if ($cekso>0)
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
			'message' =>'Get SO gagal',
			'data' => null
		);
	}
	header('Content-Type: application/json');
	echo json_encode($response);
?>
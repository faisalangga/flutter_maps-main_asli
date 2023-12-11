<?php
	header("Access-Control-Allow-Origin: *");
    include_once 'conexion.php';
	$table = 'pegawai';

    //$phone = $_POST['phone'];
    //$password = $_POST['password'];
	
	$getJson = file_get_contents('php://input');
	$json = json_decode($getJson);
    $phone = $json->phone;
    $password = $json->password;

    $sql=$connect->query("SELECT * FROM ".$table." WHERE phone='".$phone."' and password=md5('".$password."')");
	$ceklogin = $sql->num_rows;
	
    $hasil=array();

    while($fetchSql=$sql->fetch_assoc()){
        $hasil[]=$fetchSql;
    }

	if ($ceklogin>0)
	{
		$response=array(
			'error' => false,
			'message' =>null,
			'data' => $hasil
		);
	}
	else
	{
		$response=array(
			'error' => true,
			'message' =>'Password/Username Salah',
			'data' => null
		);
	}
	
    header('Content-Type: application/json');
    echo json_encode($response);

?>
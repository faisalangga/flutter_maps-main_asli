<?php
	header("Access-Control-Allow-Origin: *");
	include 'conexion.php';
	$uriSegments = explode("/", parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH));
	$table = 'so_check';

	$getJson = file_get_contents('php://input');
	$json = json_decode($getJson);
	$nobukti = $json->nobukti;
	$user = $json->username;
	$tipe = $json->tipe;
	$lat = $json->lat;
	$lng = $json->lng;
	$foto = $json->foto;
	$ttd = $json->ttd;
	
	$cekso = $connect->query("SELECT COUNT(NO_BUKTI) as ADA from ".$table." WHERE NO_BUKTI='".$nobukti."'");
	if ($tipe=="IN")
	{
		if ($cekso->ADA==0)
		{
			$result = $connect->query("INSERT INTO ".$table." (no_bukti, user_in, tg_in, lat_in, lng_in, foto_in, ttd_in) 
									   VALUES ('".$nobukti."', '".$user."', NOW(), ".$lat.", ".$lng.", '".$foto."', '".$ttd."')");
		}
		else
		{
			$result = $connect->query("UPDATE ".$table." SET user_in='".$user."', tg_in=NOW(), lat_in=".$lat.", lng_in=".$lng.", 
									   foto_in='".$foto."', ttd_in='".$ttd."' 
									   WHERE NO_BUKTI='".$nobukti."'");
		}
	}
	if ($tipe=="OUT")
	{
		$result = $connect->query("UPDATE ".$table." SET user_out='".$user."', tg_out=NOW(), lat_out=".$lat.", lng_out=".$lng.", 
								   foto_out='".$foto."', ttd_out='".$ttd."' 
								   WHERE NO_BUKTI='".$nobukti."'");
	}
	
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
		 'message' =>"Check ".$tipe." gagal"
		);
	}
	header('Content-Type: application/json');
	echo json_encode($response);
?>
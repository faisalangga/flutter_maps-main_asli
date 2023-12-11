<?php
	header("Access-Control-Allow-Origin: *");

	$connect = new mysqli("localhost","root","","tokool");

	if($connect){
		
	}
	else{
		echo "Gagal Konek";
		exit();
	}
?>
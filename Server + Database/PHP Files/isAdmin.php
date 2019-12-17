<?php
	include 'db.php';
	
	$username ='defaultUser';
	$session = 0;
		
	if (isset($_POST['username']))
		$username = $_POST['username'];
		
	if (isset($_POST['session']))
		$session = $_POST['session'];
	
	$queryResult = $db->query("SELECT creator from sessions WHERE code = '$session'");
	$result = $queryResult->fetch_row();
    echo json_encode($result);
?>


<?php
	include 'db.php';
	
	$username ='defaultUser';
	$password = 'defaultPW';
	$securityAnswer = 'defaultQuestion';
		
	if (isset($_POST['username']))
		$username = $_POST['username'];
		
	if (isset($_POST['password']))
		$password = $_POST['password'];
		
	if (isset($_POST['securityAnswer']))
		$securityAnswer = $_POST['securityAnswer'];

	$db->query("UPDATE `accounts` SET password = '$password' 
	    WHERE username = '$username' && safeAnswer = '$securityAnswer'");
	
	echo $db->affected_rows;
?>
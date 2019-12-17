<?php
	include 'db.php';
	
	$username = 'defaultUser';
	
	if (isset($_POST['username']))
		$username = $_POST['username'];
		
	if (isset($_POST['newPassword']))
		$newPassword = $_POST['newPassword'];
	
	$db->query("UPDATE `accounts` SET password = '$newPassword' WHERE username = '$username'");
?>

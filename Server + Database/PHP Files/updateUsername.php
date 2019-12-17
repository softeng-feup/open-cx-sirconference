<?php
	include 'db.php';
	
	$username = 'defaultUser';
	
	if (isset($_POST['username']))
		$username = $_POST['username'];
		
	if (isset($_POST['newUsername']))
		$newUsername = $_POST['newUsername'];
	
	$db->query("UPDATE `accounts` SET username = '$newUsername' WHERE username = '$username'");
?>

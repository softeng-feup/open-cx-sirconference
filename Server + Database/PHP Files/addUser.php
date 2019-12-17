<?php
	include 'db.php';
	
	$username = 'user1';
	$password = 'c592df4a8693';
	
	if (isset($_POST['username']))
		$username = $_POST['username'];
		
	if (isset($_POST['password']))
		$password = $_POST['password'];
		
	if (isset($_POST['safeAnswer']))
		$safeAnswer = $_POST['safeAnswer'];
	
	$db->query("INSERT INTO `accounts` (`username`, `password`, `safeAnswer`) VALUES ('$username', '$password', '$safeAnswer')");
?>

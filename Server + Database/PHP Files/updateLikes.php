<?php
	include 'db.php';
	
	$username ='defaultUser';
	$question = 'defaultQuestion';
	$session = 0;
	$likesCount = 0;
	
	if (isset($_POST['id']))
		$id = $_POST['id'];
		
	if (isset($_POST['username']))
		$username = $_POST['username'];
		
	if (isset($_POST['question']))
		$question = $_POST['question'];
		
	if (isset($_POST['session']))
		$session = $_POST['session'];
		
	if (isset($_POST['likesCount']))
		$likesCount = $_POST['likesCount'];
	
	$db->query("UPDATE `questions` SET likesCount = '$likesCount' 
	        WHERE username = '$username' && question = '$question' && session = '$session'");
?>

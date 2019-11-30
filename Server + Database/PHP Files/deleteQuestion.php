<?php
	include 'db.php';
	
	$username ='defaultUser';
	$question = 'defaultQuestion';
	$session = 0;
		
	if (isset($_POST['username']))
		$username = $_POST['username'];
		
	if (isset($_POST['question']))
		$question = $_POST['question'];
		
	if (isset($_POST['session']))
		$session = $_POST['session'];
	
	$db->query("DELETE FROM `questions` WHERE username = '$username' && question = '$question' && session = '$session'");
?>


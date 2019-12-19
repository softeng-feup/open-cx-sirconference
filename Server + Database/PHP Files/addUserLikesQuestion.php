<?php
	include 'db.php';
	
	$user = 'defaultUser';
	$question = 'defaultQuestion';
	$session = 0;
	
	if (isset($_POST['user']))
		$user = $_POST['user'];
		
	if (isset($_POST['question']))
		$question = $_POST['question'];
		
	if (isset($_POST['session']))
		$session = $_POST['session'];
		
	if (isset($_POST['userPoster']))
		$userPoster = $_POST['userPoster'];
	
	$db->query("INSERT INTO `userLikesQuestion` (`user`, `question`, `session`, `userPoster`) 
	        VALUES ('$user', '$question', '$session', '$userPoster')");
?>

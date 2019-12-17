<?php
	include 'db.php';
	
	$id = 0;
	$username ='defaultUser';
	$question = 'defaultQuestion';
	$session = 0;
	
	if (isset($_POST['id']))
		$id = $_POST['id'];
		
	if (isset($_POST['username']))
		$username = $_POST['username'];
		
	if (isset($_POST['question']))
		$question = $_POST['question'];
		
	if (isset($_POST['session']))
		$session = $_POST['session'];
	
	$db->query("INSERT INTO `questions` (`id`, `username`, `question`, `session`, `likesCount`) VALUES ('$id', '$username', '$question', '$session', 0)")
?>

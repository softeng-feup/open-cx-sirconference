<?php
	include 'db.php';
	
	$code = 0;
	$name ='defaultName';
	$creator ='defautlUser';
	
	if (isset($_POST['code']))
		$code = $_POST['code'];
		
	if (isset($_POST['name']))
		$name = $_POST['name'];
		
	if (isset($_POST['creator']))
		$creator = $_POST['creator'];
	
	$db->query("INSERT INTO `sessions` (`code`, `name`, `creator`) VALUES ('$code', '$name', '$creator')");
?>
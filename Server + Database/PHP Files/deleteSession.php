<?php
	include 'db.php';
	
	$code = -1;
	$creator = 'defaultUser';
	
	if (isset($_POST['code']))
		$code = $_POST['code'];
		
	if (isset($_POST['creator']))
		$creator = $_POST['creator'];
	
	$db->query("DELETE FROM `sessions` WHERE code = '$code' && creator = '$creator'");
?>
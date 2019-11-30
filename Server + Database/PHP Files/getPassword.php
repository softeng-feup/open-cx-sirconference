<?php
include 'db.php';

$username = 'defaultUser';

if (isset($_GET['username'])) {
	$username = $_GET['username'];
}

$queryResult = $db->query("SELECT password FROM accounts WHERE username = '$username'") or die($db->error);
$result = $queryResult->fetch_assoc();
echo json_encode($result);

?>




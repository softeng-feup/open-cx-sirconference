<?php
include 'db.php';
header("Access-Control-Allow-Origin: *");

$username = 'defaultUser';

if (isset($_GET['username']))
	$username = $_GET['username'];

$queryResult = $db->query("SELECT * FROM questions WHERE NOT EXISTS (SELECT * FROM userLikesQuestion where userLikesQuestion.question = questions.question && userLikesQuestion.user = '$username' && userLikesQuestion.session = questions.session) ORDER BY `likesCount` DESC") or die($db->error);

$result = array();

while($fetchData =  $queryResult->fetch_assoc()) {
    $result[] = $fetchData;
}

echo json_encode($result);

?>

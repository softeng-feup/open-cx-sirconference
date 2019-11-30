<?php
include 'db.php';
header("Access-Control-Allow-Origin: *");

$queryResult = $db->query("SELECT * FROM questions ORDER BY `likesCount` DESC ") or die($db->error);

$result = array();

while($fetchData =  $queryResult->fetch_assoc()) {
    $result[] = $fetchData;
}

echo json_encode($result);

?>

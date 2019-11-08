<?php
include 'db.php';

$queryResult = $db->query("SELECT * FROM questions") or die($db->error);

$result = array();

while($fetchData =  $queryResult->fetch_assoc()) {
    $result[] = $fetchData;
}

echo json_encode($result);

?>

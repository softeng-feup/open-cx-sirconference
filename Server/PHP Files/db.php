<?php
    $dns = 'localhost';
    $user = 'id11306612_sirconfacc';
    $pass = 'JSAN_esof';

    $db = new mysqli($dns, $user, $pass, "id11306612_sirconference_accounts");

    if ($db) {
        //echo "Successfully connected";
    }
    else echo "Connection failed"

?>
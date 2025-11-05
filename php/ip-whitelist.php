<?php

$ips = ' 0.0.0.0 ';

if(!str_contains($ips, $_SERVER['REMOTE_ADDR'])) {
    echo $_SERVER['REMOTE_ADDR'];
    exit;
}

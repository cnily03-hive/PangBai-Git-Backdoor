<?php

# Functions to handle HTML output

function print_msg($msg) {
    $content = file_get_contents('index.html');
    $content = preg_replace('/\s*<script.*<\/script>/s', '', $content);
    $content = preg_replace('/ event/', '', $content);
    $content = str_replace('点击此处载入存档', $msg, $content);
    echo $content;
}

function show_backdoor() {
    $content = file_get_contents('index.html');
    $content = str_replace('/assets/index.js', '/assets/backdoor.js', $content);
    echo $content;
}

# Backdoor

if ($_POST['papa'] !== 'o31uGSgxKmj7') {
    show_backdoor();
} else if ($_GET['NewStar_CTF.2024'] !== 'Welcome' && preg_match('/^Welcome$/', $_GET['NewStar_CTF.2024'])) {
    print_msg('PangBai loves you!');
    call_user_func($_POST['func'], $_POST['args']);
} else {
    print_msg('PangBai hates you!');
}

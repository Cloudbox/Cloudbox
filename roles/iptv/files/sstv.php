<?php
// EPG - http://sstv.fog.pt/feed.xml

if (isset($_GET['ch'])) {
    $config = parse_ini_file('config.ini');

    $auth = file_exists('./cache/auth.ini') ? parse_ini_file('./cache/auth.ini') : null;

    if (is_null($auth) || $auth['time'] < time()) {
        $hash = json_decode(file_get_contents('https://auth.smoothstreams.tv/hash_api.php?username='
            . urlencode($config['username']) . '&password=' . urlencode($config['password']) . '&site='
            . urlencode($config['service'])), true)['hash'];

        file_put_contents('./cache/auth.ini', '[auth]' . PHP_EOL
            . 'hash = "' . $hash . '"' . PHP_EOL . 'time = ' . (time() + 12600) . PHP_EOL);

        $auth = parse_ini_file('./cache/auth.ini');
    }

    $url = 'http://' . $config['server'] . '.smoothstreams.tv:9100/' . $config['service']
        . '/ch' . ($_GET['ch'] < 10 ? '0' : '') . $_GET['ch'] . 'q1.stream/';

    $count = null;
    $returnValue = preg_replace('/(chunks(\\.m3u8)).*?(wmsAuthSign=[^&]*)/', $url . 'playlist\\2?\\3', file_get_contents($url . 'playlist.m3u8?wmsAuthSign=' . $auth['hash'] . '=='), -1, $count);

    file_put_contents('./cache/playlist.m3u8', $returnValue);

    header('Content-Disposition: attachment; filename="playlist.m3u8"');
    header('Content-Length: ' . filesize('./cache/playlist.m3u8'));
    header('Content-Type: ' . mime_content_type('./cache/playlist.m3u8'));

    readfile('./cache/playlist.m3u8');

    exit();
}

phpinfo();

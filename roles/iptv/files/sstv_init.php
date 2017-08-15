<?php
error_reporting(E_ERROR);
set_time_limit(0);

// EPG - http://sstv.fog.pt/feed.xml

function init()
{
    file_put_contents('./cache/init.running', '', LOCK_EX);

    // ---------------------------------

    $config = parse_ini_file('config.ini');

    // ---------------------------------

    $hash = json_decode(file_get_contents('https://auth.smoothstreams.tv/hash_api.php?username='
        . urlencode($config['username']) . '&password=' . urlencode($config['password']) . '&site='
        . urlencode($config['service'])), true)['hash'];

    // ---------------------------------

    $id_map = array_flip(json_decode(file_get_contents('http://sstv.fog.pt/utc/chanlist.json'), true));

    // ---------------------------------

    $ch_map = [];
    foreach (preg_split('/\n/', file_get_contents('http://sstv.fog.pt/utc/SmoothStreams.m3u8')) as $ln) {
        if (strpos($ln, '#EXTINF') === 0) {
            $pos = strpos($ln, 'tvg-num') + 9;
            $len = $ln[$pos + 2] === '"' ? 2 : 3;
            $ch_map[(int)substr($ln, $pos, $len)] = substr($ln, $pos + $len + 2);
        }
    }

    // ---------------------------------

    $out_static = '#EXTM3U' . PHP_EOL;
    $out_dynamic = '#EXTM3U' . PHP_EOL;

    for ($ch = 1; $ch <= count($ch_map); $ch++) {
        $png = 'https://guide.smoothstreams.tv/assets/images/channels/' . $ch . '.png';

        if ($ok = stripos(@get_headers($png)[0], '200'))
            file_put_contents('./cache/' . $ch . '.png', file_get_contents($png));

        $inf = '#EXTINF:-1 tvg-id="' . $id_map[$ch] . '" tvg-name="' . $ch
            . '" tvg-logo="http://' . $config['ip'] . '/cache/' . ($ok ? $ch : 'empty') . '.png'
            . '" channel-id="' . $ch . '",' . $ch_map[$ch] . PHP_EOL;

        $url = 'http://' . $config['server'] . '.smoothstreams.tv:9100/' . $config['service']
            . '/ch' . ($ch < 10 ? '0' : '') . $ch . 'q1.stream/playlist.m3u8?wmsAuthSign=' . $hash . '==';

        $out_static .= $inf . $url . PHP_EOL;
        $out_dynamic .= $inf . 'http://' . $config['ip'] . '/sstv.php?ch=' . $ch . PHP_EOL;
    }

    file_put_contents('./playlist/sstv_static.m3u8', $out_static);
    file_put_contents('./playlist/sstv_dynamic.m3u8', $out_dynamic);

    // ---------------------------------

    unlink('./cache/init.running');

    echo 'init...done!';

    exit();
}

if (!file_exists('init.running'))
    init();

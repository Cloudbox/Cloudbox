# SmoothStreamsTV Playlist Generator #

sstv-playlist is forked from https://github.com/stvhwrd/SmoothStreamsTV-playlist and is released under the MIT license

```
positional arguments:
  output                Set output directory of playlist files
  
optional arguments:
  -h, --help            show this help message and exit
  -f FIND, --find FIND  Only return channels matching text (case insensitive)
  -q MINQUALITY, --minquality MINQUALITY
                        Minimum quality (540, 720, 1080)
  -c, --checkchannel    Check channels
  --nocheckchannel      Do not check channels
  -b, --includebadchannels
                        Include bad channels
  -m MINUTES, --minutes MINUTES
                        Minutes in the future to generate the guide. Channels
                        are not checked for values greater than 29
  -s SERVER, --server SERVER
                        Server to use (deu, dna, dsg)
  --rtmp                Use RTMP
  --tvheadend           Include headers used by Tvheadend when parsing .m3u8 files
  -v, --version         Show version information
  -d, --debug           Show debug information
```
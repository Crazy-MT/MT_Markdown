#!/bin/sh
#basepath=$(cd `dirname $0`; pwd)
cd /Users/mt/desktop/chuancui/mt_markdown/build/web || return
open -n /Applications/Google\ Chrome.app/ --args --disable-web-security --user-data-dir=/Users/mt/desktop/chuancui/mt_markdown/build/web/chromedata 127.0.0.1:8765
python -m SimpleHTTPServer 8765

#!/usr/bin/env sh

~/homelab/scripts/cloudflare/update_record.sh c59ef5fdadfc7c8330a520443f85ff83 "*.loty.click" &&
echo "updated *.loty.click"
~/homelab/scripts/cloudflare/update_record.sh cf8d1ae4447f1fd1a9db3c0362fdeef2 "loty.click" &&
echo "updated loty.click"

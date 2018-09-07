#!/bin/sh
CHE_DIR=$HOME/che

WS_PROXY_DIR=$CHE_DIR/.ws_proxy
WS_PROXY_EXE=$WS_PROXY_DIR/ws_proxy
mkdir -p ${CHE_DIR}
mkdir -p ${WS_PROXY_DIR}

#TODO verify version
if [ -f  $WS_PROXY_EXE ]; 
    then; 
    else; 
        echo "Files are not yet install, installing..."; 
        curl https://github.com/ariel-bentu/nxs/blob/master/ws1/bin/ws_proxy?raw=true --output $WS_PROXY_EXE
        chmod +x 
fi;

echo '[Upstream]\nURL=<TO BE REPLACED>\n\n[Cookie]\n`<TO BE REPLACED>`\n' > $WS_PROXY_DIR/proxy.ini
$WS_PROXY_EXE -f ./proxy.ini run


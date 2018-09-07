#!/bin/sh
CHE_DIR=$HOME/che

WS_PROXY_DIR=$CHE_DIR/.ws_proxy
WS_PROXY_EXE=$WS_PROXY_DIR/ws_proxy
mkdir -p ${CHE_DIR}
mkdir -p ${WS_PROXY_DIR}

#TODO verify version
if [ -f  ${WS_PROXY_EXE} ]; then 
        echo "Files are up to date."
    else 
        echo "Files are not yet install, installing..."
        curl -L https://github.com/ariel-bentu/nxs/raw/master/ws1/bin/ws_proxy --output $WS_PROXY_EXE
        chmod +x ${WS_PROXY_EXE}
fi

echo '[Upstream]\nURL=<TO BE REPLACED>\n\n[Cookie]\n`<TO BE REPLACED>`\n' > $WS_PROXY_DIR/proxy.ini
$WS_PROXY_EXE -f ./proxy.ini run


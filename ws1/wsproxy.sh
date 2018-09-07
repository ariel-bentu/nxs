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

printf 'http://localhost:80' > $WS_PROXY_DIR/url.conf
printf 'TODO Cookie to UPSTRAEM' > $WS_PROXY_DIR/cookie.conf

SUBJECT="/C=IL/O=SAP/OU=DevX/L=Raanana/ST=Israel/CN=OnPremiseWorkspaceProxy"

echo "Generating Root certificate for CA...\n"
openssl req -new -newkey 2048 -nodes -x509 -keyout $WS_PROXY_DIR/ca.key -subj "${SUBJECT}" \
     -days 1024  -out $WS_PROXY_DIR/ca.crt

$WS_PROXY_EXE -pem $WS_PROXY_DIR/ca.crt -key $WS_PROXY_DIR/ca.key \
    -url $WS_PROXY_DIR/url.conf -cookie $WS_PROXY_DIR/cookie.conf -addr :8887 run


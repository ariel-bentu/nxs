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

echo '<URL to UPSTRAEM>' > $WS_PROXY_DIR/url.conf
echo '<Cookie to UPSTRAEM>' > $WS_PROXY_DIR/cookie.conf

openssl genrsa -out $WS_PROXY_DIR/ca.key 2048
SUBJECT=/C=IL/O=SAP/OU=DevX/L=Raanana/ST=Israel/CN=OnPremise Workspace Proxy

openssl req -new -newkey rsa:4096 -key $WS_PROXY_DIR/ca.key \
    -out $WS_PROXY_DIR/ca.csr \
    -subj ${SUBJECT}

openssl req -new -newkey -sha256 -days 365 -nodes -x509 \
    -subj ${SUBJECT} \
    -out  $WS_PROXY_DIR/ca.crt


#openssl req -new -nodes -x509 -key $WS_PROXY_DIR/ca.key  -sha256 -days 1024  -out $WS_PROXY_DIR/ca.crt

$WS_PROXY_EXE -pem $WS_PROXY_DIR/ca.crt -key $WS_PROXY_DIR/ca.key \
    -urlFile $WS_PROXY_DIR/url.conf -cookieFile $WS_PROXY_DIR/cookie.conf run


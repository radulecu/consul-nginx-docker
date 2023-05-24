rm *.conf *.key *.crt *.csr

openssl req -x509 \
            -sha256 -days 356 \
            -nodes \
            -newkey rsa:2048 \
            -subj "/CN=demo.mlopshub.com/C=US/L=San Fransisco" \
            -keyout ca.key -out ca.crt 

openssl genrsa -out consul.key 2048

cat > csr.conf <<EOF
[ req ]
default_bits = 2048
prompt = no
default_md = sha256
req_extensions = req_ext
distinguished_name = dn

[ dn ]
C = US
ST = California
L = San Fransisco
O = MLopsHub
OU = MlopsHub Dev
CN = demo.mlopshub.com

[ req_ext ]
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = demo.mlopshub.com
DNS.2 = www.demo.mlopshub.com
IP.1 = 192.168.1.5
IP.2 = 192.168.1.6

EOF

openssl req -new -key consul.key -out consul.csr -config csr.conf

cat > cert.conf <<EOF

authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = demo.mlopshub.com

EOF

openssl x509 -req \
    -in consul.csr \
    -CA ca.crt -CAkey ca.key \
    -CAcreateserial -out consul.crt \
    -days 365 \
    -sha256 -extfile cert.conf


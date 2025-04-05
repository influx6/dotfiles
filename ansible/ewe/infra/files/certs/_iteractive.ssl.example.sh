#!/bin/bash

function create_ca() {
  subject="$1";
  if [[ "$subject" = "" ]]; then
    echo "Please provide a root CA CN (Common Name aka Subject)";
    return 1;
  fi

  directory="$2"
  if [ "$directory" = "" ]; then
    directory="./certs";
  fi

  expiration_dates="$3";
  if [ "$expiration_dates" = "" ]; then
    expiration_dates=1825;
  fi

  mkdir -p "${directory}";

  if [ ! -f "${directory}/rootCA.crt" ]; then
    openssl req -x509 \
                -sha256 -days 356 \
                -nodes \
                -newkey rsa:2048 \
                -subj "/CN=${subject}" \
                -keyout "${directory}/rootCA.key" \
                -out "${directory}/rootCA.crt";
  fi

  if [ ! -f "${directory}/server.key" ]; then
    openssl genrsa -out "${directory}/server.key" 2048
  fi

  # create certificate signing request configuration containing additional information to use to
  # create the server.csr
  if [ ! -f "${directory/csr.conf}" ]; then
    cat > "${directory}/csr.conf" <<EOF
[req]
default_bits = 2048
prompt = no
default_md = sha256
req_extensions = req_ext
distinguished_name = dn

[dn]
C = HK
ST = Discovery Bay
L = New Territories
O = DotfilesDev
OU = Dotfiles Dev
CN = demo.ewe-studios.com

[req_ext]
subjectAltName = @alt_names

[alt_names]
DNS.1 = demo.ewe-studios.com
DNS.2 = www.demo.ewe-studios.com
IP.1 = 192.168.128.90
IP.2 = 192.168.128.95
IP.3 = 192.168.128.140
IP.4 = 192.168.128.147
IP.5 = 192.168.128.159
IP.6 = 192.168.128.100
IP.7 = 192.168.128.105
IP.8 = 192.168.128.148
IP.9 = 192.168.128.149
EOF
  fi

 echo "created a csr configuration file at ${directory}/csr.conf";
 echo "edit the details in to match expected details you wish in ${directory}/csr.conf";
 echo "Ready? Enter any character key"
 read -r -n 1 var

  openssl req -new -key "${directory}/server.key" -out "${directory}/server.csr" -config "${directory}/csr.conf"

  # Create certificate extension document that allow us provide details for the non root certificate we will sign with
  # our root CA
  cat > "${directory}/cert.conf" <<EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = demo.ewe-studios.com
DNS.2 = www.demo.ewe-studios.com
IP.1 = 192.168.128.90
IP.2 = 192.168.128.95
IP.3 = 192.168.128.140
IP.4 = 192.168.128.147
IP.5 = 192.168.128.159
IP.6 = 192.168.128.100
IP.7 = 192.168.128.105
IP.8 = 192.168.128.148
IP.9 = 192.168.128.149

EOF

 echo "created a certificate configuration file at ${directory}/cert.conf";
 echo "edit the details in to match expected details you wish in ${directory}/cert.conf";
 echo "Ready? Enter any character key"
 read -r -n 1 var

  openssl x509 -req \
      -in "${directory}/server.csr" \
      -CA "${directory}/rootCA.crt" \
      -CAkey "${directory}/rootCA.key" \
      -CAcreateserial -out "${directory}/server.crt" \
      -days 365 \
      -sha256 -extfile "${directory}/cert.conf"


  echo "Created two files ${directory}/server.crt and ${directory}/server.key";
  echo "Use these to setup your browser SSL"
}
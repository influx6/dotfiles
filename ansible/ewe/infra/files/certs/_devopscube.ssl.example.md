Create Certificate Authority
As discussed earlier, we need to create our own root CA certificate for browsers to trust the self-signed certificate. So let’s create the root CA certificate first.

Let’s create a directory named openssl to save all the generated keys & certificates.

mkdir openssl && cd openssl
Execute the following openssl command to create the rootCA.keyand rootCA.crt. Replace demo.mlopshub.com with your domain name or IP address.

openssl req -x509 \
-sha256 -days 356 \
-nodes \
-newkey rsa:2048 \
-subj "/CN=demo.mlopshub.com/C=US/L=San Fransisco" \
-keyout rootCA.key -out rootCA.crt
We will use the rootCA.keyand rootCA.crt to sign the SSL certificate.

Note: If you get the following error, comment RANDFILE = $ENV::HOME/.rnd line in /etc/ssl/openssl.cnf

Can't load /home/vagrant/.rnd into RNG
Create Self-Signed Certificates using OpenSSL
Follow the steps given below to create the self-signed certificates. We will sign out certificates using our own root CA created in the previous step.

1. Create the Server Private Key
   openssl genrsa -out server.key 2048
2. Create Certificate Signing Request Configuration
   We will create a csr.conf file to have all the information to generate the CSR. Replace demo.mlopshub.com with your domain name or IP address.

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
3. Generate Certificate Signing Request (CSR) Using Server Private Key
   Now we will generate server.csr using the following command.

openssl req -new -key server.key -out server.csr -config csr.conf
Now our folder should have three files. csr.conf, server.csr and server.key

4. Create a external file
   Execute the following to create cert.conf for the SSL certificate. Replace demo.mlopshub.com with your domain name or IP address.

cat > cert.conf <<EOF

authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = demo.mlopshub.com

EOF
5. Generate SSL certificate With self signed CA
   Now, execute the following command to generate the SSL certificate that is signed by the rootCA.crt and rootCA.key created as part of our own Certificate Authority.

openssl x509 -req \
-in server.csr \
-CA rootCA.crt -CAkey rootCA.key \
-CAcreateserial -out server.crt \
-days 365 \
-sha256 -extfile cert.conf
The above command will generate server.crt that will be used with our server.key to enable SSL in applications.

For example, the following config shows the Nginx config using the server certificate and private key used for SSL configuration.

server {

listen   443;

ssl    on;
ssl_certificate    /etc/ssl/server.crt;
ssl_certificate_key    /etc/ssl/server.key;

server_name your.domain.com;
access_log /var/log/nginx/nginx.vhost.access.log;
error_log /var/log/nginx/nginx.vhost.error.log;
location / {
root   /home/www/public_html/your.domain.com/public/;
index  index.html;
}

}
Install Certificate Authority In Your Browser/OS
You need to install the rootCA.crt in your browser or operating system to avoid the security message that shows up in the browser when using self-signed certificates.

Installing self-signed CA certificates differs in Operating systems. For example, in MAC, you can add the certificate by double-clicking it and adding it to the keychain. Check the respective Operating system guide on installing the certificate.

For MAC check this guide
Adding certificate to chrome on Windows
Shell Script To Create Self-Signed Certificate
If you want to create self-signed certificates quite often, you can make use of the following shell script. You just need to execute the script with the domain name or IP that you want to add to the certificate.

Save the following shell script as ssl.sh

#! /bin/bash

if [ "$#" -ne 1 ]
then
echo "Error: No domain name argument provided"
echo "Usage: Provide a domain name as an argument"
exit 1
fi

DOMAIN=$1

# Create root CA & Private key

openssl req -x509 \
-sha256 -days 356 \
-nodes \
-newkey rsa:2048 \
-subj "/CN=${DOMAIN}/C=US/L=San Fransisco" \
-keyout rootCA.key -out rootCA.crt

# Generate Private key

openssl genrsa -out ${DOMAIN}.key 2048

# Create csf conf

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
CN = ${DOMAIN}

[ req_ext ]
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = ${DOMAIN}
DNS.2 = www.${DOMAIN}
IP.1 = 192.168.1.5
IP.2 = 192.168.1.6

EOF

# create CSR request using private key

openssl req -new -key ${DOMAIN}.key -out ${DOMAIN}.csr -config csr.conf

# Create a external config file for the certificate

cat > cert.conf <<EOF

authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = ${DOMAIN}

EOF

# Create SSl with self signed CA

openssl x509 -req \
-in ${DOMAIN}.csr \
-CA rootCA.crt -CAkey rootCA.key \
-CAcreateserial -out ${DOMAIN}.crt \
-days 365 \
-sha256 -extfile cert.conf
Set the script executable permission by executing the following command.

chmod +x ssl.sh
Execute the script with the domain name or IP. For example,

./ssl.sh demo.mlopshub.com
The script will create all the certificates and keys we created using the individual commands. The SSL certificate and private keys get named with the domain name you pass as the script argument. For example, demo.mlopshub.com.key & demo.mlopshub.com.crt

What are the benefits of using a self-signed certificate?
There are several benefits of using a self-signed certificate:

You don’t need to rely on a third party to sign your certificate.
You can create and use your own certificate authority.
You don’t have to pay for a certificate from a CA.
You have more control over your certificates.
What are the drawbacks of using a self-signed certificate?
There are also several drawbacks of using a self-signed certificate:

Your users will need to install the certificate in their browsers or applications.
Your users will need to trust your certificate authority manually.
They unsafe for public facing applications.
None of the browsers or operating systems trust the self-signed certificates unless the user installs them.
Prone to man-in-the-middle attacks.
In general, self-signed certificates are a good option for applications in which you need to prove your own identity. They’re also a good option for development and testing environments. However, they shouldn’t be used for production applications.

Self-Signed Certificates in Organizations
Many organizations use self-signed certificated for their internal applications that are not internet-facing. These certificates are generated using the organization’s internal PKI infrastructure.

DevOps teams and developers can request SSL certificates from the PKI infrastructure to be used in applications.

Self-Signed Certificate FAQ’s
How to create self-signed certificated on Windows?
You can create a self-signed certificate on windows using Openssl. The OpenSSL commands are the same for all operating systems. You can follow this guide to create a self-signed certificate on windows using this guide.

How do I get a self-signed certificate?
Self-signed certificate can be generated by you using tools like openSSL or CDSSL PKI toolkit.

Conclusion
In this guide, we have learned how to create self-signed SSL certificates using OpenSSL.

For production use cases, if you don’t want to spend money on SSL certificates, you can try out Letsencrypt.

Hope this self-signed SSL guide was helpful with the script to automate the certificate generation. Do let us know if you face any issues.

Also, SSL/TLS is one of the important topics in DevOps. You can check out the how to become a devops engineer blog to know more.
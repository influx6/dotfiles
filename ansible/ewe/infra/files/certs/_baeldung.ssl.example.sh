#!/bin/bash

##### Creating Self Signed SSL Certificates

# Step 1:
# First, we'll create a private key. A private key helps to enable encryption, and is the most important component of our certificate.
# Let's create a password-protected, 2048-bit RSA private key (domain.key) with the openssl command:
#
# Remove the -des3 if you want a key without a password
#
openssl genrsa -des3 -out domain.key 2048

# Step 2:
#
#  If we want our certificate signed, we need a certificate signing request (CSR). The CSR includes the public key and some additional information (such as organization and country).
#  Let's create a CSR (domain.csr) from our existing private key:
#
# You will be prompted to enter your private key password and some CSR information to complete the process
#
# E.g
# ------------------------------------------------------------------------------------
#  Enter pass phrase for domain.key:
#  You are about to be asked to enter information that will be incorporated
#  into your certificate request.
#  What you are about to enter is what is called a Distinguished Name or a DN.
#  There are quite a few fields but you can leave some blank
#  For some fields there will be a default value,
#  If you enter '.', the field will be left blank.
#  -----
#  Country Name (2 letter code) [AU]:AU
#  State or Province Name (full name) [Some-State]:stateA
#  Locality Name (eg, city) []:cityA
#  Organization Name (eg, company) [Internet Widgits Pty Ltd]:companyA
#  Organizational Unit Name (eg, section) []:sectionA
#  Common Name (e.g. server FQDN or YOUR name) []:domain
#  Email Address []:email@email.com
#
#  Please enter the following 'extra' attributes
#  to be sent with your certificate request
#  A challenge password []:
#  An optional company name []:
# ------------------------------------------------------------------------------------
#
#  An important field is “Common Name,” which should be the exact Fully Qualified Domain Name (FQDN) of our domain.
#
#  “A challenge password” and “An optional company name” can be left empty.
#
#  We can also create both the private key and CSR with a single command:
#      openssl req -newkey rsa:2048 -keyout domain.key -out domain.csr
#
#  If we want our private key unencrypted, we can add the -nodes option:
#
#      openssl req -newkey rsa:2048 -nodes -keyout domain.key -out domain.csr
#
openssl req -key domain.key -new -out domain.csr

# Step 3:
#
#  A self-signed certificate is a certificate that's signed with its own private key. It can be used to encrypt data just as
#  well as CA-signed certificates, but our users will be shown a warning that says the certificate isn't trusted.
#
#  Let's create a self-signed certificate (domain.crt) with our existing private key and CSR:
#  The -days option specifies the number of days that the certificate will be valid.
#
#  We can create a self-signed certificate with just a private key:
#
#    openssl req -key domain.key -new -x509 -days 365 -out domain.crt
#
#  This command will create a temporary CSR. We still have the CSR information prompt, of course.
#
#  We can even create a private key and a self-signed certificate with just a single command:
#
#  openssl req -newkey rsa:2048 -keyout domain.key -x509 -days 365 -out domain.crt
#
openssl x509 -signkey domain.key -in domain.csr -req -days 365 -out domain.crt

# Step 4:
#
# View our certificate
#
openssl x509 -text -noout -in domain.crt

# Step 5: Convert from PEM to DER
#
#  Our certificate (domain.crt) is an X.509 certificate that's ASCII PEM-encoded. We can use OpenSSL to convert it to other formats for multi-purpose use.
#
#  1. Convert PEM to DER
#  The DER format is usually used with Java. Let's convert our PEM-encoded certificate to a DER-encoded certificate:
#
openssl x509 -in domain.crt -outform der -out domain.der

# Step 6: Convert from PEM to PKCS12
#
#
#  2. Convert PEM to PKCS12
#  PKCS12 files, also known as PFX files, are usually used for importing and exporting certificate chains in Microsoft IIS.
#
#  We'll use the following command to take our private key and certificate, and then combine them into a PKCS12 file:
#
openssl pkcs12 -inkey domain.key -in domain.crt -export -out domain.pfx



##### Creating RootCA to sign other certificates

# Step 1:
#
# Creating a CA-Signed Certificate With Our Own CA
#
# We can be our own certificate authority (CA) by creating a self-signed root CA certificate, and then installing it as a trusted certificate in the local browser.
#
#  1. Create a Self-Signed Root CA
#  Let's create a private key (rootCA.key) and a self-signed root CA certificate (rootCA.crt) from the command line:
#
openssl req -x509 -sha256 -days 1825 -newkey rsa:2048 -keyout rootCA.key -out rootCA.crt
#
#  2. Sign Our CSR With Root CA
#
#  First, we'll create a configuration text-file (domain.ext) with the following content:
##
#    authorityKeyIdentifier=keyid,issuer
#    basicConstraints=CA:FALSE
#    subjectAltName = @alt_names
#    [alt_names]
#    DNS.1 = domain
#
# The “DNS.1” field should be the domain of our website.
#
#  3. Then we can sign our CSR (domain.csr) with the root CA certificate and its private key:
#  As a result, the CA-signed certificate will be in the domain.crt file.
#
openssl x509 -req -CA rootCA.crt -CAkey rootCA.key -in domain.csr -out domain.crt -days 365 -CAcreateserial -extfile domain.ext


# Step 2:
#
# View our certificate
#
openssl x509 -text -noout -in domain.crt

# Step 6: Convert from PEM to DER
#
#  Our certificate (domain.crt) is an X.509 certificate that's ASCII PEM-encoded. We can use OpenSSL to convert it to other formats for multi-purpose use.
#
#  1. Convert PEM to DER
#  The DER format is usually used with Java. Let's convert our PEM-encoded certificate to a DER-encoded certificate:
#
openssl x509 -in domain.crt -outform der -out domain.der

# Step 7: Convert from PEM to PKCS12
#
#
#  2. Convert PEM to PKCS12
#  PKCS12 files, also known as PFX files, are usually used for importing and exporting certificate chains in Microsoft IIS.
#
#  We'll use the following command to take our private key and certificate, and then combine them into a PKCS12 file:
#
openssl pkcs12 -inkey domain.key -in domain.crt -export -out domain.pfx


# Extras
#  Step 8 . Converting PEM to JKS Format
#
#  We'll now go through the steps to convert all certificates and private keys from PEM to JKS format.
#
#  For the purpose of example, we're going to create a self-signed certificate.
#
#  3.1. Creating the PEM File
#  We'll start by generating two files, key.pem and cert.pem, using openssl:
#
#  openssl req -newkey rsa:2048 -x509 -keyout key.pem -out cert.pem -days 365 
#
#  The tool will prompt us to enter a PEM passphrase and other information.
#
#  Once we've answered all the prompts, the openssl tool outputs two files:
#
#  key.pem (the private key)
#  cert.pem (a public certificate)
#  We'll use these files to generate our self-signed certificate.
#
#  3.2. Generating the PKCS12 Certificate
#  In most cases, the certificate is in Public Key Cryptography Standards #12 (PKCS12) format. Less frequently, we use a Java KeyStore (JKS) format.
#
#  Let's convert PEM into a PKCS12 format:
#
#  openssl pkcs12 -export -in cert.pem -inkey key.pem -out certificate.p12 -name "certificate"
#
#  While the command runs, we'll be prompted to enter the passphrase that we created previously for key.pem:
#
#  Enter pass phrase for key.pem:
#
#  And then we'll see the prompt asking for a new password for certificate.p12:
#
#  Enter Export Password:
#
#  After that, we'll have a certificate.p12 KeyStore stored in PCKS12 format.
#
#  3.3. PKCS#12 to JKS
#  The last step is to convert from PKCS12 to JKS format:
#
#  keytool -importkeystore -srckeystore certificate.p12 -srcstoretype pkcs12 -destkeystore cert.jks
#
#  As the command executes, it'll prompt for a new password for the cert.jks file:
#
#  Enter destination keystore password:
#
#  And it'll prompt us for the certificate.p12 password we created earlier:
#
#  Enter source keystore password:
#
#  Then, we should see the final output:
#
#  Entry for alias certificate successfully imported.
#  Import command completed: 1 entries successfully imported, 0 entries failed or cancelled
#
#  The result is a cert.jks KeyStore stored in JKS format.
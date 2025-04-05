
1)  #!/bin/bash
2)  #################################################################
3)  # Disclaimer of Warranties:                                     #
4)  # The following code is sample code created by IBM Corporation  #
5)  # and is provided to you solely for instructional purposes for  #
6)  # assisting you in the setup of certificates for secure         #
7)  # connection between multiple products and third party          #
8)  # components. The code is provided "AS IS" without warranty     #
9)  # of any kind. IBM shall not be liable for any damages arising  #
10) # out of your use of this sample code, even if advised of the   #
11) # possibility of such damages. This sample code does not        #
12) # contain entitlements to an IBM program; entitlements to an    #
13) # IBM program are provided to you under a separate written      #
14) # agreement between you and IBM.                                #
15) #################################################################
16) echo Generate a private RSA key - SERVER
17) openssl genrsa -out myPIservercert.key 2048
18) echo Create a x509 certificate - SERVER
19) echo common name must match hostname from server.xml
20) echo all other inputs are optional
21) openssl req -x509 -new -nodes -key myPIservercert.key \
         -sha256 -days 1024 -out myPIservercert.pem
22) echo Create a PKCS12 keystore from private key and public certificate. - SERVER
23) openssl pkcs12 -export -name server-cert \
         -in myPIservercert.pem -inkey myPIservercert.key \
         -out serverkeystore.p12
24) echo Convert PKCS12 keystore into a JKS keystore - SERVER
25) keytool -importkeystore -destkeystore server.keystore \
         -srckeystore serverkeystore.p12 -srcstoretype pkcs12 \
         -alias server-cert
26) echo Generate a private key - CLIENT
27) openssl genrsa -out myPIclientcert.key 2048
28) echo Create a x509 certificate - CLIENT
29) echo common name must match username from server.xml
30) echo all other inputs are optional
31) openssl req -x509 -new -nodes -key myPIclientcert.key \
         -sha256 -days 1024 -out myPIclientcert.pem
32) echo Create PKCS12 keystore from private key and public certificate. - CLIENT
33) openssl pkcs12 -export -name client-cert \
         -in myPIclientcert.pem -inkey myPIclientcert.key \
         -out clientkeystore.p12
34) echo Convert a PKCS12 keystore into a JKS keystore - CLIENT
35) keytool -importkeystore -destkeystore client.keystore \
         -srckeystore clientkeystore.p12 -srcstoretype pkcs12 \
         -alias client-cert
36) echo IMPORTING
37) echo Import a client certificate to the server trust store.
38) keytool -import -alias client-cert \
         -file myPIclientcert.pem -keystore server.truststore
39) echo Import a server certificate to the server trust store.
40) keytool -import -alias server-cert \
         -file myPIservercert.pem -keystore server.truststore
41) echo Import a server certificate to the client trust store.
42) keytool -import -alias server-cert -file myPIservercert.pem \
         -keystore client.truststore
43) echo Import a client certificate to the client trust store.
44) keytool -import -alias client-cert -file myPIclientcert.pem \
         -keystore client.truststore
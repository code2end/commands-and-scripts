# Generate asymmetric RSA keys for encryption via openssl

1. Generate private key :

     `openssl genrsa -out private.pem 2048`

2. Convert private key to pkcs8 encoding :

     `openssl pkcs8 -topk8 -inform PEM -outform PEM -in private.pem -out private-8.pem -nocrypt`

3. Generate public key :

     `openssl rsa -in private.pem -outform PEM -pubout -out public.pem`

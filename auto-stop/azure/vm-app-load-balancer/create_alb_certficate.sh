#!/bin/bash

# === Configurable ===
DOMAIN="yourdomain.com"
PFX_NAME="appgw-cert.pfx"
PFX_PASSWORD="abc123"

# === Generate private key ===
openssl genrsa -out appgw.key 2048

# === Create self-signed certificate ===
openssl req -new -x509 -key appgw.key -out appgw.crt -days 365 \
  -subj "/CN=$DOMAIN"

# === Convert to PFX ===
openssl pkcs12 -export \
  -out $PFX_NAME \
  -inkey appgw.key \
  -in appgw.crt \
  -passout pass:$PFX_PASSWORD

echo "PFX file created: $PFX_NAME"
echo "Use password: $PFX_PASSWORD when uploading to Azure"

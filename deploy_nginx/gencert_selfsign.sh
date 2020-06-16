#!/bin/sh
# @file
# @brief Generate a "self-signed" SSL/TLS Certificate
#
# For HTTPS, we can generate an OpenSSL Certificate to "sign" the
# encrypted channel/messages by using OpenSSL.
# 
# This approach is generally considered less trustworthy than
# registering with a Certificate Authority. This approach is
# provided only for reference/testing.
# 
# The "issue" there is that you've done nothing to verify
# the website which is presenting the certificate, you've
# simply stated that a valid certificate was created and is
# being presented, whether it has anything to do with this
# website's location or not.
# 
# Domain Structure: `subdomian.domainname.tld`
# 
# Note that due to the strictness of the verification, if
# you wanted to register both `test.mysite.org` and also
# `dev.mysite.org` with certificates, you'd need to do it
# twice, even though they're subdomains on the same domain.
# 
# Each subdomain "should" have its own certificate.
# 
# Also note that a certificate has a "lifetime", so it will
# expire at some point, and you'll need to re-run this
# process again, otherwise your site will be flagged as
# insecure due to hosting an expired certificate.
#
# References:
# - https://www.digitalocean.com/community/tutorials/a-comparison-of-let-s-encrypt-commercial-and-private-certificate-authorities-and-self-signed-ssl-certificates
# - https://stackoverflow.com/questions/10175812/how-to-create-a-self-signed-certificate-with-openssl
#
# @author tommy vegetables <leafyrabbet@gmail.com>
# @copyright 2020, TenonGarden Productions
 
# Prerequisites
sudo -E apt update
sudo -E apt install openssl

# In case of OpenSSL issues
touch ~/.rnd
set RANDFILE=.rnd

# Use OpenSSL to generate X.509 Certificate
# Edit these values as desired before running...
openssl req -x509 \
  -newkey rsa:4096 \
  -sha256 \
  -days 365 \
  -keyout example.key \
  -out example.crt \
  -extensions san \
  -config \
  <(echo "[req]"; 
    echo distinguished_name=req; 
    echo "[san]"; 
    echo subjectAltName=DNS:example.com,DNS:example.net,IP:10.0.0.1
    ) \
  -subj "/CN=example.com"

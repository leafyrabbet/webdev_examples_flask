#!/bin/sh
# @file
# @brief Generate a "Let's Encrypt" Free Certificate
#
# For HTTPS, we can generate an OpenSSL Certificate to "sign" the
# encrypted channel/messages by registering with "Let's Encrypt"
# for free.
# 
# This approach is generally considered more trustworthy than
# doing a "self-sign" certificate, which only generates the
# certification locally on the same server where you're hosting
# the website. The "issue" there is that you've done nothing
# to verify the website which is presenting the certificate,
# you've simply stated that a valid certificate was created
# and is being presented, whether it has anything to do with
# a website or not.
# 
# "Let's Encrypt" uses the ACMEv2 API for generating a new
# Domain-Verified TLS certificate through its `certbot`
# utility. The difference here is that you need to provide
# the exact domainname (including the TLD and any relevant
# subdomain, see below) when you generate the certificate.
# This provides "Domain Verification" by confirming that
# the server on which the certificate is being generated
# is also hosting that domain. And when you use the
# certificate it is now tied to that domain, by name, and
# any mismatch or misuse is generally flagged by a browser.
# 
# Domain Structure: `subdomian.domainname.tld`
# 
# Note that due to the strictness of the verification, if
# you wanted to register both `test.mysite.org` and also
# `dev.mysite.org` with certificates, you'd need to do it
# twice, even though they're subdomains on the same domain.
# 
# Also note that a certificate has a "lifetime", so it will
# expire at some point, and you'll need to re-run this
# process again, otherwise your site will be flagged as
# insecure due to hosting an expired certificate.
#
# References:
# - https://www.digitalocean.com/community/tutorials/a-comparison-of-let-s-encrypt-commercial-and-private-certificate-authorities-and-self-signed-ssl-certificates
# - https://letsencrypt.org/docs/client-options/
# - https://certbot.eff.org/
#
# @author tommy vegetables <leafyrabbet@gmail.com>
# @copyright 2020, TenonGarden Productions

# ---------------- WARNING -----------------------------------
# Make sure that you have a valid webserver (Nginx, etc.)
# that is already hosting the `http://` version of the
# site that you want to add `https://` to, otherwise the
# `certbot` utility cannot complete the "Domain Verification"
# and you won't be able to generate a valid certificate.
# ---------------- WARNING -----------------------------------

sudo -E apt-get update
sudo -E apt-get install software-properties-common
sudo -E add-apt-repository universe
sudo -E add-apt-repository ppa:certbot/certbot
sudo -E apt-get update

# For Nginx
sudo -E apt-get install certbot python3-certbot-nginx

# Get and Install Certs
# (follow interactive instructions after running this command)
sudo -E certbot --nginx

# Renewal Test
sudo -E certbot renew --dry-run

# Now you can modify your Nginx server configuration file
# by using the following example (also found in the provided
# `flasktest` server file in this directory):
# 
# # HTTPS Configuration (SSL)
# listen 443 ssl;
# listen [::]:443 ssl;
# ssl_certificate /etc/letsencrypt/live/DOMAINNAME/fullchain.pem;    # Change DOMAINNAME
# ssl_certificate_key /etc/letsencrypt/live/DOMAINNAME/privkey.pem;  # Change DOMAINNAME

# After the server file is updated with the above configuration
# options, inside the `server {...}` block, you just need to
# restart Nginx and you now have `https://` with a Domain
# Verified certificate.

# # Restart Nginx
# sudo -E systemctl restart nginx
# # or
# sudo -E nginx -s restart
# # or
# sudo -E /etc/init.d/nginx restart

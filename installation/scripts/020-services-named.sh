#!/bin/bash
set -euo pipefail

cp /etc/named.conf{,.default}
cp -pR ../named/etc/named.conf /etc/
cp -pR ../named/var/named/domain.db /var/named
systemctl restart named

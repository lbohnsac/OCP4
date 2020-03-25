#!/bin/bash
set -euo pipefail

firewall-cmd --add-service={dhcp,tftp,http,https,dns} --permanent
firewall-cmd --add-port={6443/tcp,22623/tcp,8080/tcp} --permanent
firewall-cmd --reload


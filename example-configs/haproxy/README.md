# haproxy configuration

Turn on the haproxy_connect_any boolean to allow haproxy to bind to any port
```
# setsebool -P haproxy_connect_any 1
```

Add net.ipv4.ip_nonlocal_bind=1 on /etc/sysctl.conf
```
# echo "net.ipv4.ip_nonlocal_bind=1">/etc/sysctl.conf
```

Check the value is set correctly
```
# sysctl -p|grep net.ipv4.ip_nonlocal_bind
```

Enable and start the haproxy service
```
# systemctl enable haproxy --now
```

Check if haproxy is started
```
# systemctl status haproxy
```

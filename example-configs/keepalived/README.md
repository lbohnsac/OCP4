# Keepalived configuration

Open the related firewall ports for keepalived vrrp (Virtual Router Redundancy Protocol) communication
```
# firewall-cmd --add-rich-rule=’rule protocol value=”vrrp” accept’
# firewall-cmd -a-dd-rich-rule=’rule protocol value=”vrrp” accept’ --permanent
```

Check if there's already keepalived on the network
```
# tcpdump -i <INTERFACE> | grep -i vrrp
```
If output looks like this
```
TCPDUMP OUTPUT
```
there is already keepalived running on a foreign host using the router_id 51!

Router_id 51 is mostly in use because this id is used in many examples and blog posts ...

So it's a good idea to choose anything but 51 as the router_id!

> The valid range to use fir the router_id is 1 - 255


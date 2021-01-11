# turris-vpnbypass
ByPass VPN for Streaming service (aka Netflix)

TurrisOS 5.1.X do not support `whois` command (fix on 5.2)

## Use host with `whois` command
`get_netflix_ips.sh` get Netflix IPs
 * Register maxmind.com geolite-AS file (free)

```
get_netflix_ips.sh /data/docker/nginx/html/bypassvpn.txt <maxmind_licence_key>
```

Define crontab to refresh IPs

 Publish output file on web server (nginx docker)



## On Turris
Copy `vpn-policy-routing.bypassvpn.user` to `/etc/vpn-policy-routing.bypassvpn.user`

Install `vpn-policy-routing`: https://github.com/openwrt/packages/blob/master/net/vpn-policy-routing/files/README.md#how-to-install

Setup your custom user file: https://github.com/openwrt/packages/blob/master/net/vpn-policy-routing/files/README.md#custom-user-files

Restart service and enjoy :)


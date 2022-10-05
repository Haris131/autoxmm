# autoxmm
 * script for auto change apn fibocom L860
 * edit list from script for add apn
 * fix reconnecting xl in fibocom L860
 * the script always runs until it finds the ip address
 * add ```0 2 * * * /root/autoxmm.sh >/dev/null 2>&1``` in schedule task for auto start script at 2 pm

# Install
```
wget -O /usr/bin/autoxmm https://raw.githubusercontent.com/Haris131/autoxmm/main/autoxmm.sh && chmod +x /usr/bin/autoxmm
```

# How to work
```
autoxmm
```

# Tested
 * fibocom L860 (xmm-modem)

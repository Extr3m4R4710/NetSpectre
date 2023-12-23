# NetSpectre
Net-spectre is an anonymization tool that enforces communication via Tor SOCKS across the entire network. It is composed of a shell script and operates instantly on almost all Linux systems. It does not require any additional code or new packages, and there is no need to modify or rewrite system files. However, Tor must be installed. If Python is not present on the system, please install it. Alternatively, you can replace the 'myip' section in the case statement of net-spectre with Perl or another command (i.e. jq).

# install
installation method is common with tor-router.

**Note: need bash. no sh**
```
git clone https://github.com/Extr3m4R4710/NetSpectre.git && cd ./net-spectre && sudo bash install.sh
```
# Stoping
The fundamental operation of NetSpectre adheres to Edu4rdSHL/tor-router. To halt NS, disable the service unit using systemctl disable net-spectre (if installed via install.sh). Subsequently, reboot your computer.

In simpler terms, as long as the service unit is active, NS consistently connects to Tor as a systemctl service, compelling all internet communication through Tor with each computer boot.

NS accepts command-line options for initiation and termination, it's crucial to recognize that this only permits non-Tor connections temporarily and partially. If systemctl is enabled, be sure to deactivate it. This scenario is specific to installations initiated from install.sh, and it does not apply when using the NS (net-spectre) script independently.

# options
Here is an example executed on Arch Linux.
```bash
Usage: /sbin/net-spectre {start|stop|restart|myip}
```
There is an additional option not present in the official tor-router, which allows you to check the status of the IP address using 'myip'. It is formatted using 'python -m json.tool'.
```
[ root@N2x3ec ~ ]:# net-spectre myip
{
    "status": "success",
    "country": "Poland",
    "countryCode": "PL",
    "region": "14",
    "regionName": "Mazovia",
    "city": "Warsaw",
    "zip": "00-510",
    "lat": 52.2296,
    "lon": 21.0067,
    "timezone": "Europe/Warsaw",
    "isp": "1337 Services GmbH",
    "org": "1337 Services GmbH",
    "as": "AS210558 1337 Services GmbH",
    "query": "45.141.215.21"
}
[ root@N2x3ec ~ ]:#

```

###  note: About main branch and dev branch
There are two versions of net-spectre. One is stable (main branch) and the next is dev (lab branch). The dev version allows you to use the latest features, but may cause unintended behavior. Therefore, only clone the lab branch if you need experimental release functionality (i.e. if the stable version has a defect). We are always accepting issues.

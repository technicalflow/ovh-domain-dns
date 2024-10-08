# OVH DNS Update
If you have a domain hosted at OVH you can using API update it's "A" record. <br>
I have prepared 3 methods to do so: <br>

## Bash
Simple script using Curl to read "A" record ID and send new one <br>
It is set to take new IP from current location using curl icanhazip.com <br>
It will save result in ip.list file and before the next run compare if there are changes to it. <br>
Please remember update get.sh file with data from creating a token<br>
Also running on Mac please update line 55 as it will not save output to the ip.list file <br>
Do so by installing gnu-sed and changing code to gsed <br>
There are also getip.service and getip.timer file in order to run the script in schedule <br>
Please remember to add the right path to getip script in getip.service file and next as root enter: <br>
<code>
mv getip.service /etc/systemd/system <br>
mv getip.timer /etc/systemd/system <br>
chown root:root /etc/systemd/system/getip.service <br>
chown root:root /etc/systemd/system/getip.timer <br>
chmod 755 /etc/systemd/system/getip.service <br>
chmod 755 /etc/systemd/system/getip.timer <br>
systemctl daemon-reload <br>
systemctl enable getip.timer <br>
</code>

## Python
Again very simple script using OVH library (remember to run pip install ovh). <br>
It also write the result to file and compare it before next run. <br>
Remember to fullfill ovh.conf file with data from creating a token. <br>
In order to read the myip.txt file remember to run code including it's directory. <br>
## Terraform
I managed also to create a terraform option. <br>
It has one caviot - if it is run for the first time (no tfstate file) <br>
the domain needs to be without "A" records, as terraform will create new one "A" record <br> and not update any existing ones on first run. Result would be two "A" records. <br>
Also remember to enter data from token creation into terraform.auto.tfvars file.<br>

## Token
In order to get your application key and secret please visit: https://www.ovh.com/auth/api/createToken <br>
Create token as on the picture below (change {zone} for your domain name) and enter <br>
"/domain/zone/{zone}/record/* " for all four methods (GET, PUT, POST, DELETE) and in order to refresh domain add POST for "/domain/zone/{zone}/refresh" <br><br>
In any issues with authorization, create a token with "/domain/zone/{zone}/* "<br>
<i>Also sometimes it takes a day before OVH API works correctly with generated keys</i> <br><br>
![Token image](token.jpg "Token")
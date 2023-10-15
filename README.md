# OVH DNS Update
If you have a domain hosted at OVH you can using API udate it's A record. <br>

I have prepared 3 methods to do so: <br>

## Bash
Simple script using Curl to read "A" record ID and send new one <br>
It is set to take new IP from current location using curl icanhazip.com <br>
It will save result in ip.list file and before the next run compare if there are changes to it. <br>
Please remember update get.sh file with data from creating a token<br>
Also running on Mac please update line 55 as it will not save output to the ip.list file <br>
Do so by installing gnu-sed and changing code to gsed <br>
There are also getip.service and getip.timer file in order to run the script in schedule <br>
## Python
Again very simple script using OVH library (remember to run pip install ovh) <br>
It also write the result to file and compare it before next run. <br>
Remember to fullfill ovh.conf file with data from creating a token <br>
In order to read the myip.txt file remember to run code including directory it is placed in <br>
## Terraform
I managed also to create a terraform option. <br>
It has one caviot - if it is run for the first time (no tfstate file) <br>
the domain need to be without "A" records, as it will create new one "A" record - not update any existing ones <br>
Also remember to enter data from token creation into terraform.auto.tfvars file.<br>

### Token
In order to get your application key and secret please visit: https://www.ovh.com/auth/api/createToken <br>
and create token as on the picture below (change {zone} for your domain name) and enter "/domain/zone/{zone}/record/*" <br>
for all four methods (GET, PUT, POST, DELETE) and in order to refresh domain add POST for "/domain/zone/{zone}/refresh" <br>
![Token image](token.jpg "Token")
# -*- encoding: utf-8 -*-

# import json
import ovh
import requests

# if requests.get(url=api_url) != 21: quit()

api_url = "http://icanhazip.com"
response = requests.get(url=api_url)
clearip=str((response.content),'utf-8').strip()

if response.status_code != 200: quit()

content = open("myip.txt", "r").readlines()[0].strip()
if content == clearip : quit()

# print(content)
# print(clearip)

client = ovh.Client()

domain="example.com"

# Get ID
resultget = client.get('/domain/zone/'+domain+'/record',
    fieldType='A',
#    subDomain=None,
)

# Get full url 
rg = ('/domain/zone/'+domain+'/record/'+(''.join(map(str, resultget))))
#print(rg)

# Delete
#resultdelete = client.delete(rg)

#print(resultdelete)

# Put
resultput = client.put((rg),
    target=clearip,
    ttl=0,
)

# print(resultput)

# Refresh
resultrefresh = client.post('/domain/zone/'+domain+'/refresh')

# print(resultrefresh)

# POST 
#resultpost = client.post('/domain/zone/'+domain+'/record',
#    fieldType="A",target="1.1.1.1",ttl=0,
#)

#print(resultpost)

with open('myip.txt', 'w', encoding='utf-8') as file: 
    file.writelines(str(clearip)+"\n")
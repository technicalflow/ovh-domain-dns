import requests
api_url = "http://icanhazip.com"

response = requests.get(url=api_url)

clear=str((response.content),'utf-8').strip()

print(clear)
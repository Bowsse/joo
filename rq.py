import requests
import json

def getToken( username, password ):
 headers = { "content-type":
        "application/x-www-form-urlencoded" }
 payload = "username" +"=" +username
 payload += "&password" +"=" +password
 payload += "&appcode=1234567890"
 url = "http://localhost:9000/login"
 response = requests.post(url, data = payload,
      headers = headers)		
 if response.status_code != 200:
   return None
 return response.json()["data"]["X-BB-SESSION"]

token = getToken("admin", "admin");
print token;

def addPlugin( name, code, active, lang, token ):
 headers = { "X-BB-SESSION": token,
     "content-type": "application/json",
      "User-Agent": "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:46.0) Gecko/20100101 Firefox/46.0",
      "Accept": "*/*",
      "Accept-Language": "en-US,en;q=0.5",
      "X-Requested-With": "XMLHttpRequest", 
      "Referer": "http://localhost:9000/console/" }
 url = "http://localhost:9000/admin/plugin"
 payload = '{ "name": "' +name +'", '
 payload += '"code": "' +code +'", '
 payload += '"active": "' +active +'", '
 payload += '"lang": "' +lang +'"  }'
 response = requests.post( url, data = payload,
   headers = headers )
 if response.status_code != 201:
   print "Error: posting plugin failed."
   print response.text;


#print plugincode;

plugincode = "http().get(function(request){  return {status: 200, content: 'Hello World!'};});";
pluginname = "instapp.asd";



file = open('instapp.enabled', 'r')
plugincode = file.read()

plugincode = json.stringify(plugincode)

print plugincode

addPlugin(pluginname , plugincode, "true",  "javascript", token);

def putPlugin( name, code, token ):
 headers = { "X-BB-SESSION": token,
     "content-type": "application/json" }
 url = "http://localhost:9000/admin/plugin/" +name
 payload = '{ "code": "' +code +'"}'
 response = requests.put( url, data = payload,
   headers = headers )
 if response.status_code != 201:
   print "Error: putting plugin failed."
   print response.text;

#putPlugin(pluginname , plugincode, token);


def addDocument( title, body, token ):
 headers = { "X-BB-SESSION": token,
     "content-type": "application/json" }
 url = "http://localhost:9000/document/Version"
 payload = '{ "title": "' +title +'", '
 payload += '"number": "' +body +'" }'
 response = requests.post( url, data = payload,
   headers = headers )
 if response.status_code != 200:
   print "Error: posting document failed."


# addDocument("mikstallaontitle", "6.6.6", token);




#{"name":"asd.asd","code":plugincode,"active":true,"lang":"javascript"}






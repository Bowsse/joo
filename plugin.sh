#!/bin/bash
BBsession=""
echo $BBsession
length=${#BBsession}
echo $length
url="localhost:9000"
echo $url

# Login loop
while test $length -eq 0
do
curl http://$url/login     -d "username=admin"    -d "password=admin"    -d "appcode=1234567890"  > output.txt
sed -i -n -e 's/.*X-BB-SESSION":"//p' output.txt
sed -it -n -e 's/ *".*//p' output.txt
BBsession=$(cat output.txt)
length=${#BBsession}
echo $BBsession
sleep 2
done

#"encoded": "BASE64",
fileName="$1"
url="localhost:9000"


#codeContent=$(cat $fileName)
codeContent=$( base64 $fileName)
#codeContent=$(while read line; do echo -n "$line "; done < $fileName)


codeName=${fileName}

echo $codeName
echo $codeContent

curl \
-X POST \
-H "X-BAASBOX-APPCODE:1234567890" \
-H "X-BB-SESSION:$BBsession" \
-H "Content-Type:application/json" \
--data '{ "lang": "javascript", "name": "'"$codeName"'", "encoded": "BASE64", "code": "'"$codeContent"'" }' \
"http://$url/admin/plugin"


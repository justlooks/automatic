
docker build -t="docker:5000/centos:centos65-withmysql-v1" .


docker run -d -p 3306:3306 -v /data:/data/db docker:5000/centos:centos65-withmysql-v1

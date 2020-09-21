FROM amazon/aws-cli:latest

RUN yum install cronie -y
ADD cronjob /cronjob
ADD s3sync.sh /s3sync.sh
RUN /usr/bin/crontab /cronjob

ENTRYPOINT crond -ns
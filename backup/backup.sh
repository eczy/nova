#!/bin/sh
set -e

# Redmine
PGPASSWORD=${REDMINE_PASSWORD} /usr/bin/pg_dump -U ${REDMINE_USERNAME} -h redmine_db -Fc --file=/backup/redmine/redmine.sqlc redmine
rsync -a /data/redmine/files /backup/redmine

# Jenkins
rsync -a /data/jenkins /backup/jenkins

# Overleaf
rsync -a /data/sharelatex/* /backup/sharelatex
mongodump --uri="mongodb://mongo:27017" --out=/backup/sharelatex/mongodump

cd /backup
tar -czvf /backup/archives/redmine_`date +%Y-%m-%d`.tar.gz redmine
tar -czvf /backup/archives/jenkins_`date +%Y-%m-%d`.tar.gz jenkins
tar -czvf /backup/archives/sharelatex_`date +%Y-%m-%d`.tar.gz sharelatex

# Delete backups older than 7 days
find $(pwd) -mtime +7 -type f -delete
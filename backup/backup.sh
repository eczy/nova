#!/bin/sh
set -e

# Redmine database
PGPASSWORD=${REDMINE_PASSWORD} /usr/bin/pg_dump -U ${REDMINE_USERNAME} -h redmine_db -Fc --file=/backup/redmine/redmine.sqlc redmine

# Redmine attachments
rsync -a /data/redmine/files /backup/redmine

rsync -a /data/jenkins /backup/jenkins

cd /backup
tar -czvf /backup/archives/redmine_`date +%Y-%m-%d`.tar.gz redmine
tar -czvf /backup/archives/jenkins_`date +%Y-%m-%d`.tar.gz jenkins
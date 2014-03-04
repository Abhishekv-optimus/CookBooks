#! /bin/bash

mkdir /opt/setup
mkdir /opt/setup/db_dump
cd /opt/setup/db_dump
wget https://s3.amazonaws.com/cfn-test-temps/dumps/latest_db.sql

#
# Cookbook Name:: smartenglish
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "/opt/setup/mysql_dump.sh" do
  source "mysql_dump.sh"
  mode 0755
end

execute "download mysqldump" do
  command "sh /opt/setup/mysql_dump.sh"
end

cookbook_file "/opt/setup/setup-system.sh" do
  source "setup-system.sh"
  mode 0755
end

execute "install setup-system.sh" do
  command "sh /opt/setup/setup-system.sh"
end

cookbook_file "/opt/setup/setup-cloudwatch.sh" do
  source "setup-cloudwatch.sh"
  mode 0755
end

execute "install setup-cloudwatch.sh" do
  command "sh /opt/setup/setup-cloudwatch.sh"
end

execute "import mysqldump" do
  command "/usr/bin/mysql -u #{node["db_username"]} -p #{node["db_password"]} -h #{node["db_host_name"]} #{node["db_name"]} < /opt/setup/db_dump/latest_db.sql"
end

#cookbook_file "#{node["smrt_document_root"]}/include/constants.php"
# source "constants.php"
# mode   "0644"
#end

template "#{node["smrt_document_root"]}/include/constants.php"
 source "constants.php.erb"
 mode   "0644"
end

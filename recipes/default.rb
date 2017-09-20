#
# Cookbook:: db
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# apt_repository 'mongodb' do
#   uri 'http://ppa.launchpad.net/juju/stable/ubuntu'
#   components ['main']
#   distribution 'trusty'
#   key 'C8068B11'
#   keyserver 'keyserver.ubuntu.com'
#   action :add
#   deb_src true
# end

# execute 'add key' do
#     command 'sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6'
#     action :nothing
#   end
#   execute 'add repo' do
#     command 'sudo echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list'
#     action :nothing
#   end
#   execute 'install mongodb' do
#     command 'sudo apt-get install -y mongodb-org'
#     action :nothing
#   end

apt_repository 'mongodb-org' do 
  uri "http://repo.mongodb.org/apt/ubuntu"
  distribution "xenial/mongodb-org/3.2"
  components ["multiverse"]
  keyserver "hkp://keyserver.ubuntu.com:80"
  key "EA312927"
end
  
  package 'mongodb'
  
template '/etc/mongod.conf' do 
  source 'mongod.conf.erb'
end 

template '/lib/systemd/system/mongod.service' do 
  source 'mongod.service.erb'
  action :create
end 


service 'mongod' do 
  supports status: true, restart: true
  action [:enable, :start]
end





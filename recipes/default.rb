#
# Cookbook:: db
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

package "mongodb"

service 'mongodb' do 
	supports status: true, restart: true, reload: true
	action [:enable, :start]
end

template '/etc/mongod.conf' do 
	source 'mongod.conf.erb'
	notifies :reload, "service[mongodb]"
end 

template '/lib/systemd/system/mongod.service' do 
	source 'mongod.service.erb'
	action :create
end 


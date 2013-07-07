
include_recipe "sensu::default"

client_attributes = node["monitor"]["additional_client_attributes"].to_hash

sensu_client node.name do
  address node.ipaddress
  subscriptions node.roles + ["all"]
  additional client_attributes
end

sensu_gem "sensu-plugin" do
  version node["monitor"]["sensu_plugin_version"]
end

[ 'check-procs.rb',
  'check-banner.rb',
  'check-http.rb',
  'check-log.rb',
  'check-mtime.rb',
  'check-tail.rb',
  'check-fs-writable.rb'
].each do |default_plugin|
  cookbook_file "/etc/sensu/plugins/#{default_plugin}" do
    source "plugins/#{default_plugin}"
    mode 0755
  end
end

include_recipe "sensu::client_service"

# This triggers an apt-get update which was not happening previously which
# was causing python to fail in the test kitchen.
include_recipe "apt" if platform_family?("debian")

include_recipe "python"

venv_folder = node['blogapp']['venv']
app_folder = node['blogapp']['app']
log_folder = node['blogapp']['log']

package "curl" do
  action :install
end

package "git" do
  action :install
end

# TODO need to figure out what the user and group should be
# TODO switch us using supervisord
# TODO need to restart service when code/config changes

directory log_folder do
  owner 'root'
  group 'root'
  mode "0775"
  recursive true
  action :create
end

directory venv_folder do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

python_virtualenv venv_folder do
  owner 'root'
  group 'root'
  action :create
end

git app_folder do
   repository "https://github.com/charliek/blogapp.git"
   revision "master"
   action :sync
end

execute "install_blog_app" do
    user "root"
    group "root"
    command "#{venv_folder}/bin/pip install -r #{app_folder}/requirements.txt"
end

template "/etc/init/blogapp.conf" do
    source "blogapp_upstart.erb"
    owner "root"
    group "root"
    mode "0644"
    action :create
end

service "blogapp" do
	provider Chef::Provider::Service::Upstart
    supports :restart => true, :start => true, :stop => true, :reload => false
    action [ :enable, :start]
end

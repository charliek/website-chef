include_recipe "sensu::default"

sensu_gem "sensu-plugin" do
  version node["monitor"]["sensu_plugin_version"]
end

handlers = node["monitor"]["default_handlers"] + node["monitor"]["metric_handlers"]
handlers.each do |handler_name|
  next if handler_name == "debug"
  include_recipe "monitor::_#{handler_name}_handler"
end

sensu_handler "default" do
  type "set"
  handlers node["monitor"]["default_handlers"]
end

sensu_handler "metrics" do
  type "set"
  handlers node["monitor"]["metric_handlers"]
end

check_definitions = Array.new

if Chef::Config[:solo]
  check_definitions = data_bag("sensu_checks").map do |item|
    data_bag_item("sensu_checks", item)
  end
else Chef::DataBag.list.has_key?("sensu_checks")
  check_definitions = search(:sensu_checks, "*:*")
end

check_definitions.each do |check|
  sensu_check check["id"] do
    type check["type"]
    command check["command"]
    subscribers check["subscribers"]
    interval check["interval"]
    handlers check["handlers"]
    additional check["additional"]
  end
end

include_recipe "sensu::server_service"

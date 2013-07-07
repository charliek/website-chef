include_recipe "sensu::rabbitmq"
include_recipe "sensu::redis"

include_recipe "monitor::_server_setup"

include_recipe "sensu::api_service"
include_recipe "sensu::dashboard_service"

include_recipe "monitor::client"

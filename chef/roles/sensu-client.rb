name "sensu-server"
description "Role use to setup a sensu server node"

run_list  ["recipe[monitor::client]"]
 

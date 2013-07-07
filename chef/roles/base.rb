default_attributes :sensu => {
    :use_ssl => false,  # TODO figure out what is broken around rabbit connectivity with ssl
    :use_embedded_ruby => true,
    :rabbitmq => {
    	:host => "192.168.70.10",
    	:port => 5671,
    	:vhost => "/sensu",
    	:user => "sensu",
    	:password => "password"
    },
    :redis => {
    	:host => "localhost",
    	:port => 6379
    }
  }

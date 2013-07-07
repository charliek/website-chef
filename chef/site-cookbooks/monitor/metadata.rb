name             "monitor"
maintainer       "Charlie Knudsen"
maintainer_email "charlie.knudsen@gmail.com"
license          "Apache 2.0"
description      "A cookbook for monitoring services using Sensu"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

['ubuntu'].each do |os|
  supports os
end

depends "sensu"
#depends "sudo"

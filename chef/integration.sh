#!/bin/bash
set -x

##
# This is a very hacky work around needed to get around an issue in test-kitchen where it does not
# propery sync over site cookbooks. A bug has been filed, but this is a hacky work around until
# then. Eventually I'll probably port the python over to bash, but this was faster for now.
#
# https://github.com/opscode/test-kitchen/issues/166
##

../util/append_test_cookbooks.py
bundle exec kitchen $1
../util/remove_test_cookbooks.py

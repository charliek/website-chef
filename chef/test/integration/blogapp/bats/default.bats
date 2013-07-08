#!/usr/bin/env bats

@test "application should be downloaded" {
  [ -f "/opt/blogapp/app/requirements.txt" ]
}

@test "blogapp service should be running" {
	run service blogapp status
	[[ "$output" == *"start/running"* ]]
}

@test "blogapp service responding" {
	run curl -I http://localhost:5000
	[ "$status" -eq 0 ]
	[[ "$output" == *"HTTP/1.1 200 OK"* ]]
}

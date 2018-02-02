##############################################################
#
# This is a script that creates a cookie and uses it to make subsequent calls via the Jira API
#
##############################################################


require 'net/http'
require 'uri'
require "json"

# Get the cookie by passing the credentials

uri = URI.parse("<jira_url>/rest/auth/1/session")
request = Net::HTTP::Post.new(uri)
request.content_type = "application/json"
request["Accept"] = "application/json"
request.body = {
      "username": "username_here",
      "password": "password_here"
    }.to_json
req_options = {
  use_ssl: uri.scheme == "https",
}
response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
  http.request(request)
end

value = JSON.parse(response.body)["session"]["value"]
name = JSON.parse(response.body)["session"]["name"]

# Use the cookie to make API calls

uri = URI.parse("<jira_url>/rest/api/2/issue")
request = Net::HTTP::Post.new(uri)
request.content_type = "application/json"
request['cookie'] = name + "=" + value
request["Accept"] = "application/json"
request.body = {
      "fields": {
        "project": {
          "key": "KEY"
        },
        "summary": "error created via script - rahul",
        "description": "some description",
        "issuetype": {
           "name": "Bug"
        },
         "labels": [
           "rahul"
           ]
      }
    }.to_json
req_options = {
  use_ssl: uri.scheme == "https",
}
response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
  http.request(request)
end
puts response.code
id = JSON.parse(response.body)["id"]
puts "Ticket #{id} is created"
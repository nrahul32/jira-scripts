##############################################################
#
# This is a script that creates a ticket in Jira using the Jira API
#
##############################################################


require 'net/http'
require 'uri'
require "json"

uri = URI.parse("https://<your.jira.url>/rest/api/2/issue")
request = Net::HTTP::Post.new(uri)
request.content_type = "application/json"
request["Authorization"] = "Basic <Base 64 encoded string of the form username:password>"
request["Accept"] = "application/json"
request.body = {
      "fields": {
        "project": {
          "key": "PROJECT_KEY"
        },
        "summary": "title of the ticket",
        "description": "description",
        "issuetype": {
           "name": "Bug"
        },
         "labels": [
           "name_of_label"
           ]
      }
    }.to_json
req_options = {
  use_ssl: uri.scheme == "https",
}

response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
  http.request(request)
end

# You can process the responce body as needed
# puts response.code
# puts response.body

id = JSON.parse(response.body)["id"]
puts "Ticket #{id} is created"

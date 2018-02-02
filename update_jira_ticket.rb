##############################################################
#
# This is a script that updates a ticket in Jira using the Jira API
#
##############################################################

require 'net/http'
require 'uri'
require "json"

uri = URI.parse("https://<your.jira.url>/rest/api/2/issue/#{id}")
request = Net::HTTP::Put.new(uri)
request.content_type = "application/json"
request["Authorization"] = "Basic <Base 64 encoded string of the form username:password>"
request.body = {
   "update": {
   "description": [
         {
            "set": "changing the description to this"
         }
      ],
      "comment": [
         {
            "add": {
               "body": "adding a new comment"
            }
         }
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

##############################################################
#
# This is a script that gets the list ticket in Jira matching the given criteria using the Jira API
#
##############################################################

require 'net/http'
require 'uri'
require "json"

uri = URI.parse("https://<your.jira.url>/rest/api/2/search")
request = Net::HTTP::Post.new(uri)
request["Authorization"] = "Basic <Base 64 encoded string of the form username:password>"
request.content_type = "application/json"
pattern = "pattern to look for in the description"
request.body = JSON.dump({
  "jql" => "project = TEST AND labels in ('rahul') AND description ~ \"#{pattern}\"",
  "startAt" => 0,
  "maxResults" => 10,
  "fields" => [
    "id",
    "key"
  ]
})

req_options = {
  use_ssl: uri.scheme == "https",
}

response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
  http.request(request)
end

!JSON.parse(response.body)['issues'].empty? ? id = JSON.parse(response.body)['issues'][0]['key'] : id = nil

puts "The first matching ticket is #{id}"

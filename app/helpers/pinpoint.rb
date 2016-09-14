require 'net/http'
require 'json'
def pinpoint_response
  # encode URI using the URI constant
  uri = URI("http://pinpointsecuretest.azurewebsites.net/api/request")
  # tell Net::HTTP to GET the URI
  response = Net::HTTP.get(uri) # => String
  x = JSON.parse(response)
end

puts x
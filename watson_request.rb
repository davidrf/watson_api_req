require "json"
require "faraday"

base_url = "https://gateway.watsonplatform.net"
version = "2015-12-15"
path = "/document-conversion/api/v1/convert_document?version=#{version}"
basic_auth_username = "6215eb69-4b15-4a95-857d-5e77cd610da9"
basic_auth_password = "nidHwTSGSM3j"

conn = Faraday.new(url: base_url) do |faraday|
  faraday.request :multipart
  faraday.request :url_encoded
  faraday.adapter :net_http
end

conn.basic_auth(basic_auth_username, basic_auth_password)

payload = {
  config: Faraday::UploadIO.new("config.json", "application/json"),
  file: Faraday::UploadIO.new("sample.pdf", "application/pdf")
}

response = conn.post(path, payload)
json_response_body = JSON.parse(response.body)

puts json_response_body


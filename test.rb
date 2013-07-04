require 'vcloud-rest/connection'

conn = VCloudClient::Connection.new(
  'https://172.31.8.71',
  'BuildAdmin',
  'password123',
  'ContnousBuild.org',
  '1.5'
)

#rsp = conn.packaged_query('vAppTemplates', 'filter=(name==bbandt)')

conn.login

params = {
  'method' => :get,
  'command' => '/org'
}

response, headers = conn.send_request(params)
puts response

puts "\n\n"

orgs = response.css('OrgList Org')
puts orgs

results = {}
orgs.each do |org|
  results[org['name']] = org['href'].gsub("#{@api_url}/org/", "")
end
puts results

rsp = conn.packaged_query('vAppTemplates', 'filter=(name==bbandt)')

formatted = rsp.css('QueryResultRecords VAppTemplateRecord')
results = {}
formatted.each do |tst|
  results[tst['name']] = tst['href']
  results[tst['vdcName']] = tst['vdc']
end

puts results

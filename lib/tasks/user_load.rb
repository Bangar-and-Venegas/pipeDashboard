require 'rest_client'
require 'json'
#api_url = 'http://api.pipedrive.com/v1/users:(id,name)?api_token=048262d3ede5a67c2d6db8c0602fabb7e11f3c54'

#my_raw_data =RestClient.get(api_url)

my_raw_data = '{"success":true,"data":[{"id":361107,"name":"Alan"},{"id":361103,"name":"Pooja Bangar"}],"additional_data":{"company_id":248912}}'

my_hash = JSON.parse (my_raw_data)

puts my_hash
unformatted_users= my_hash["data"]

unformatted_users.each do |user|
	User.create(name: user['name'], identifier: user['id'])
end
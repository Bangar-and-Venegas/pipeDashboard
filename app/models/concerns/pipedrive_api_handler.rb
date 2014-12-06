module PipedriveApiHandler

  def load_from_api(user_id=0)
    start = 0
    more_items_in_collection=true
    while more_items_in_collection
      input = arrange_params_for_api(start,user_id)
      hash_response = get_hash_from_api(input)
      load(hash_response)
      more_items_in_collection = false
      start = hash_response.try(:[],"additional_data").try(:[],"pagination").try(:[],"next_start")
      more_items_in_collection = hash_response.try(:[],"additional_data").try(:[],"pagination").try(:[], "more_items_in_collection")
    end
  end

  def get_hash_from_api(input)
    api_base_url = "https://api.pipedrive.com/v1/"
    api_token = Rails.application.secrets.pipedrive_api_key
    api_url = "#{api_base_url}#{input[:table]}#{input[:filters]}?#{input[:params]}api_token=#{api_token}"
    response_in_json_format =RestClient.get(api_url)
    JSON.parse(response_in_json_format)
  end

  def load(hash_response)
    unformatted_users= hash_response["data"]
    unformatted_users.each do |element|
      format_results(element)
      self.create(element)
    end
  end

  def format_results(unformatted_result)
    if self.name.eql?("Deal")
      unformatted_result[:user_id]=unformatted_result['user_id']['id']
      unformatted_result.delete('user_id')
    elsif self.name.eql?("Activity")
      unformatted_result[:activity_type]= unformatted_result['type']
      unformatted_result.delete('type')
    end
  end
end

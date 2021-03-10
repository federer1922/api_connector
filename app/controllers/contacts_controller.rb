class ContactsController < ApplicationController
  def index
    result = HTTP.post("https://arek.scoro.com/api/v2/contacts/list", json: { apiKey: "ScoroAPI_a4e5e6ad85ecdcc", company_account_id: "arek", per_page: 5, page: requested_page })
    
    result_json = MultiJson.load(result.body.to_s)
    data = result_json["data"]
   
    response = { data: data, next_page_token: next_page_token(data)}
    response_json = MultiJson.dump(response)
    render json: response_json

  end

  private

  def requested_page
    if params["page_token"]
      page = params["page_token"].to_i
    else
      page = 1
    end
  end

  def next_page_token(page_data)
    if page_data.size < 5
      next_page_token = nil
    else
      next_page_token = requested_page + 1   
    end 
  end
end
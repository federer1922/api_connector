class ContactsController < ApplicationController
  skip_forgery_protection
  
  def index
    scoro_response = HTTP.post("https://arek.scoro.com/api/v2/contacts/list", json: { apiKey: "ScoroAPI_a4e5e6ad85ecdcc", company_account_id: "arek", per_page: 5, page: requested_page })
    scoro_response_json = scoro_response.body.to_s
    scoro_result = MultiJson.load(scoro_response_json)
    data = scoro_result["data"]
   
    my_response = { data: data, next_page_token: next_page_token(data)}

    my_response_json = MultiJson.dump(my_response)
    render json: my_response_json

  end

  def create
    result = HTTP.post("https://arek.scoro.com/api/v2/contacts/modify", json:
{
    "apiKey": "ScoroAPI_a4e5e6ad85ecdcc",
    "company_account_id": "arek",
    "request": {
        "contact_type": params["type"],
        "name": params["name"],
        "lastname": params["lastname"],
        "means_of_contact": { "mobile"=>[params["mobile"]], "email"=>[params["email"]], "phone"=>[params["phone"]], "website"=>[params["website"]] },
        "birthday": "",
        "position": "",
        "comments": "",
        "sex": "",
    }
})
    render json: result.body.to_s
  end

  def delete
    result = HTTP.delete("https://arek.scoro.com/api/v2/contacts/delete/(#{params["id"]})", json: { apiKey: "ScoroAPI_a4e5e6ad85ecdcc", company_account_id: "arek", "request": { "contact_id": params["id"] } })

    render json: result.body.to_s
  end

  def requested_page
    if params["page_token"].present?
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
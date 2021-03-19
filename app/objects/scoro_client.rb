class ScoroClient
  def get_contacts_page(page)
    scoro_response = HTTP.post("https://arek.scoro.com/api/v2/contacts/list", json: { apiKey: ENV["SCORO_API_KEY"], company_account_id: "arek", per_page: 5, page: page })

    success = scoro_response.status == 200
    if success 
      scoro_response_json = scoro_response.body.to_s
      scoro_result = MultiJson.load(scoro_response_json)
      { success: true, contacts: scoro_result["data"] }
    else
      { success: false, http_status: scoro_response.status }
    end    
  end

  def create_contact(contact_data)
    scoro_response = HTTP.post("https://arek.scoro.com/api/v2/contacts/modify", json: { "apiKey": ENV["SCORO_API_KEY"], "company_account_id": "arek", "request": contact_data })
    
    success = scoro_response.status == 200
    
    if success 
      scoro_response_json = scoro_response.body.to_s
      scoro_result = MultiJson.load(scoro_response_json)
      { success: true, contact: scoro_result["data"] }
    else
      { success: false, http_status: scoro_response.status }
    end
  end

  def delete_contact(id)
    scoro_response = HTTP.post("https://arek.scoro.com/api/v2/contacts/delete/#{id}", json: { "apiKey": ENV["SCORO_API_KEY"], "company_account_id": "arek" })
    
    success = scoro_response.status == 200
    if success
      { success: true }
    else
      { success: false, http_status: scoro_response.status }
    end
  end

  def show_contact(id)
    scoro_response = HTTP.post("https://arek.scoro.com/api/v2/contacts/view/#{id}", json: { "apiKey": ENV["SCORO_API_KEY"], "company_account_id": "arek" })
    
    success = scoro_response.status == 200
    if success
      scoro_response_json = scoro_response.body.to_s
      scoro_result = MultiJson.load(scoro_response_json)
      { success: true, contact: scoro_result["data"] }   
    else
      { success: false, http_status: scoro_response.status }
    end
  end
end
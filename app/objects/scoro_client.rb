class ScoroClient
  def get_contacts_page(page)

    scoro_response = HTTP.post("https://arek.scoro.com/api/v2/contacts/list", json: { apiKey: ENV["SCORO_API_KEY"], company_account_id: "arek", per_page: 5, page: page })

    scoro_response_json = scoro_response.body.to_s
    scoro_result = MultiJson.load(scoro_response_json)
    scoro_result["data"]
  end

  def create_contact(contact)

    HTTP.post("https://arek.scoro.com/api/v2/contacts/modify", json: { "apiKey": ENV["SCORO_API_KEY"], "company_account_id": "arek", "request": contact })
  end
end
class ContactsController < ApplicationController
  def index
    result = HTTP.post("https://arek.scoro.com/api/v2/contacts/list", json: { apiKey: "ScoroAPI_a4e5e6ad85ecdcc", company_account_id: "arek", per_page: 10, page: 2 })
    #binding.pry
    render json: result.body.to_s

  end
end
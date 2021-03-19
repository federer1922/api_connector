class ContactsController < ApplicationController
  skip_forgery_protection
  http_basic_authenticate_with name: "arek", password: ENV["PASSWORD"]
  
  def index
    scoro_client = ScoroClient.new

    data = scoro_client.get_contacts_page(requested_page)[:contacts]

    my_response = { data: data, next_page_token: next_page_token(data)}
    
    my_response_json = MultiJson.dump(my_response)
    render json: my_response_json
  end

  def create
    scoro_client = ScoroClient.new

    contact_data = { "contact_type": params["type"], "name": params["name"], "lastname": params["lastname"], "means_of_contact": { "mobile"=>[params["mobile"]], "email"=>[params["email"]], "phone"=>[params["phone"]], "website"=>[params["website"]] } }
    data = scoro_client.create_contact(contact_data)[:contact]
   
    render json: data
  end

  def delete
    scoro_client = ScoroClient.new
    
    id = params["id"]
    data = scoro_client.delete_contact(id)

    render status: 200, json: { contact_id: id }
  end

  def show
    scoro_client = ScoroClient.new

    id = params["id"]
    data = scoro_client.show_contact(id)[:contact]

    render json: data
  end


  def requested_page
    if params["page_token"].present?
      page = Base64.urlsafe_decode64(params["page_token"]).to_i
    else
      page = 1
    end
  end

  def next_page_token(page_data)
    if page_data.size < 5
      next_page_token = nil
    else
      next_page_token = Base64.urlsafe_encode64((requested_page + 1).to_s)
    end 
  end
end
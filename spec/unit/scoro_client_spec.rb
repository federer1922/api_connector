require "rails_helper"

describe ScoroClient do
  it "gets contacts page" do        
    scoro_client = ScoroClient.new

    result = nil
    VCR.use_cassette("contact_list") do
      result = scoro_client.get_contacts_page(2)
    end

    expect(result.first["name"]).to eq "Toby"
    expect(result.size).to eq 5
  end

  it "creates contact" do        
    scoro_client = ScoroClient.new
    contact = { 
      "type": "person",
      "name": "Olaf",
      "lastname": "Kowal",
      "mobile": "+728555777",
      "email": "olaf@gmail.com",
      "phone": nil,
      "website": nil
     }

    VCR.use_cassette('create_contact') do
      scoro_client.create_contact(contact)
    end

    expect(WebMock).to have_requested(:post, "https://arek.scoro.com/api/v2/contacts/modify")
      .with(body: '{"apiKey":"ScoroAPI_a4e5e6ad85ecdcc","company_account_id":"arek","request":{"type":"person","name":"Olaf","lastname":"Kowal","mobile":"+728555777","email":"olaf@gmail.com","phone":null,"website":null}}')    
  end

#   it "deletes contact" do
#     scoro_client = ScoroClient.new
#     scoro_client.delete_client(1)
    
#     VCR.use_cassette('create_contact') do
#       scoro_client.delete_client(1)
#     end

#   end
  
end
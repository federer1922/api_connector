require "rails_helper"

describe ScoroClient do
  it "gets contacts page" do        
    scoro_client = ScoroClient.new

    result = nil
    VCR.use_cassette("contact_list", :match_requests_on => [:body]) do
      result = scoro_client.get_contacts_page(2)
    end

    expect(result[:success]).to be true
    expect(result[:contacts].first["name"]).to eq "Toby"
    expect(result[:contacts].size).to eq 5
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

    result = nil
    VCR.use_cassette('create_contact') do
      result = scoro_client.create_contact(contact)
    end

    expect(result[:success]).to be true
    expect(result[:contact]["name"]).to eq "Olaf"
    expect(WebMock).to have_requested(:post, "https://arek.scoro.com/api/v2/contacts/modify")
      .with(body: '{"apiKey":"ScoroAPI_a4e5e6ad85ecdcc","company_account_id":"arek","request":{"type":"person","name":"Olaf","lastname":"Kowal","mobile":"+728555777","email":"olaf@gmail.com","phone":null,"website":null}}')    
  end

  it "deletes contact" do
    scoro_client = ScoroClient.new
    id = 2
    
    result = nil
    VCR.use_cassette('delete_contact') do
      result = scoro_client.delete_contact(id)
    end

    expect(result[:success]).to be true
    expect(WebMock).to have_requested(:post, "https://arek.scoro.com/api/v2/contacts/delete/2") 
  end
  
  it "shows contact" do
    scoro_client = ScoroClient.new
    id = 11
    
    result = nil
    VCR.use_cassette('show_contact') do
      result = scoro_client.show_contact(id)
    end
    
    expect(result[:success]).to be true
    expect(result[:contact]["name"]).to eq "Toby"
    expect(WebMock).to have_requested(:post, "https://arek.scoro.com/api/v2/contacts/view/11") 
  end
  
end
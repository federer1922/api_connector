require "rails_helper"

describe ContactsController, type: :controller do

  it "contacts list" do
    get :index
    binding.pry

    #result = JSON.parse(response.body)
    #MultiJson.load(response.body)
  end
end
require "rails_helper"

describe ContactsController, type: :controller do

  it "contacts list" do
    get :index, params: { page_token: 2 }
    binding.pry

  end
end
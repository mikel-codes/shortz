require 'rails_helper'
require 'byebug'
RSpec.describe "Links", type: :request do
  before do
    2.times do
      FactoryBot.create(:link, url: 'https://google.com')
    end
  end
  describe "GET /index or return a list of Links" do

    it "returns http success" do

      get "/links"
      expect(response).to have_http_status(:success)
      expect(response.body).to include("All Links")
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get short_url(slug: Link.first.slug)
      expect(response).to have_http_status(302) #redirect
      expect(response).to redirect_to(Link.first.url)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/links/new"
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Lets Shorten You Url')
    end
  end

  describe "GET /create" do
    it "creates a new shortened link" do
      post "/links", params: {link: {url: "https://justice.com/who-dey-for-you", slug: "roman"}}
      expect(response).to have_http_status(302) #because it redirects on save
      expect(response).to redirect_to(links_path)
      expect(Link.count).to eql(3)
    end
  end

end

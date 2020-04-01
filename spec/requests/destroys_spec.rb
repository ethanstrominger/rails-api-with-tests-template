require 'rails_helper'

RSpec.describe "Destroys", type: :request do
  describe "GET /destroys" do
    it "works! (now write some real specs)" do
      get destroys_path
      expect(response).to have_http_status(200)
    end
  end
end

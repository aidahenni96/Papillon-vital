require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe "GET #index" do
    it "répond avec succès" do
      get :index
      expect(response).to be_successful
    end
  end
end

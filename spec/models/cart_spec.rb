require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe 'associations' do
    it { should belong_to(:user).optional } # si un utilisateur peut être nil
    it { should have_many(:cart_products).dependent(:destroy) }
    it { should have_many(:products).through(:cart_products) }
  end
end

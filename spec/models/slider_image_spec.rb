require 'rails_helper'

RSpec.describe SliderImage, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:subtitle) }
  end

  describe 'Active Storage attachment' do
    it 'can have an attached image' do
      slider = SliderImage.new(title: 'Test', subtitle: 'Subtitle')
      slider.image.attach(io: File.open(Rails.root.join('spec/fixtures/files/test.jpg')), filename: 'test.jpg', content_type: 'image/jpeg')
      expect(slider.image).to be_attached
    end
  end
end

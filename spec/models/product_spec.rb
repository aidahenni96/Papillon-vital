require 'rails_helper'

RSpec.describe Product, type: :model do
  it "est valide avec un nom, un prix, une description, un stock et une image" do
    product = Product.new(
      name: "Test produit",
      price: 10,
      description: "Une description de test",
      stock: 5
    )

    file_path = Rails.root.join("spec/fixtures/files/test_image.jpg")
    product.image.attach(io: File.open(file_path), filename: "test_image.jpg", content_type: "image/jpeg")

    expect(product).to be_valid
    expect(product.image).to be_attached
  end

  it "n'est pas valide sans nom" do
    product = Product.new(
      price: 10,
      description: "Une description de test",
      stock: 5
    )
    expect(product).not_to be_valid
  end

  it "n'est pas valide sans prix" do
    product = Product.new(
      name: "Test produit",
      description: "Une description de test",
      stock: 5
    )
    expect(product).not_to be_valid
  end
end

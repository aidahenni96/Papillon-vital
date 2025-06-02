class Order < ApplicationRecord
  has_many :order_products
  has_many :products, through: :order_products
  belongs_to :user

  
  def total_price
    products.sum(&:price)
    order_products.sum { |item| item.price_at_purchase * item.quantity }
  end
end

class Order < ApplicationRecord
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true


  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products
  belongs_to :user


  def total_price
    order_products.sum { |item| item.price_at_purchase * item.quantity }
  end

  def total_ttc
    (total_price * 1.2).round(2) # Si tu appliques une TVA de 20%
  end
end

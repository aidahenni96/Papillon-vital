class CartProduct < ApplicationRecord
  validates :quantity, numericality: { greater_than: 0 }

  belongs_to :cart
  belongs_to :product

  before_validation :set_default_quantity

  def set_default_quantity
    self.quantity ||= 1
  end
end

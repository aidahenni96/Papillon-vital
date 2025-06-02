class CartProduct < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :quantity, numericality: { greater_than: 0 }
  validates :product_id, uniqueness: { scope: :cart_id, message: "déjà dans le panier" }

  before_validation :set_default_quantity

  private

  def set_default_quantity
    self.quantity ||= 1
  end
end
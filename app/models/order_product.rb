class OrderProduct < ApplicationRecord
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  
  belongs_to :order
  belongs_to :product
end

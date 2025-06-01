class Product < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0}
  validates :stock, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :image_url, format: { with: URI::regexp(%w[http https]), message: "doit être une URL valide" }, allow_blank: true
  has_and_belongs_to_many :carts
end
def image_filename
  image_map = {
    "ashwagandha bio" => "Ashwagandha_bio.png",
    "curcuma bio" => "Curcuma_bio.png",
    "farine de coco bio" => "Farinedecoco_bio.png",
    "gingembre bio" => "Gingembre_bio.png",
    "graines de lin bio" => "Grainesdelin_bio.png",
    "maca bio" => "Maca_bio.png",
    "noix du brésil bio" => "NoixduBresil_Bio.png",
    "romarin bio" => "Romarin_Bio.png",
    "spiruline bio" => "Spiruline_Bio.png"
  }
  image_map[self.name.downcase.strip]
end
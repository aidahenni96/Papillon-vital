puts "Suppression des anciens produits..."
Product.destroy_all
User.destroy_all

puts "Création des produits..."

[
  ['Noix du Brésil bio',  35],
  ['Romarin bio',         15],
  ['Spiruline bio',       30],
  ['Curcuma bio',         35],
  ['Gingembre bio',       15],
  ['Ashwagandha bio',     30],
  ['Farine de coco bio',  15],
  ['Graines de lin bio',  15],
  ['Maca bio',            30]
].each do |name, price|
  Product.create!(
    name: name,
    description: "Sachet de 300 g – produit 100 % biologique.",
    price: price,
    stock: 50,
    image_url: "https://source.unsplash.com/400x300/?#{name.parameterize}"
  )
end

puts "✅ Produits ajoutés avec succès !"

require 'faker' 




User.create!(
  email: "aidahenni96@icloud.com",
  password: "123456",
  password_confirmation: "123456",
  admin: true
)

puts "Admin créé : aidahenni96@icloud.com/ 123456"




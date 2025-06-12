puts "Suppression des anciens produits..."
Product.destroy_all
User.destroy_all

puts "Création des produits..."

products = [
  [ 'Noix du Brésil bio', 35, "Noix riches en sélénium, essentielles pour le fonctionnement thyroïdien, elles aident à protéger les cellules contre le stress oxydatif." ],
  [ 'Romarin bio', 15, "Plante aromatique aux propriétés antioxydantes et stimulantes, elle favorise la digestion et la circulation sanguine." ],
  [ 'Spiruline bio', 30, "Algue riche en protéines, vitamines et minéraux, elle soutient le système immunitaire et aide à réduire la fatigue." ],
  [ 'Curcuma bio', 35, "Épice aux vertus anti-inflammatoires, elle contribue à la santé articulaire et au bien-être général." ],
  [ 'Gingembre bio', 15, "Racine stimulante qui aide à la digestion, soulage les nausées et possède des propriétés anti-inflammatoires." ],
  [ 'Ashwagandha bio', 30, "Plante adaptogène reconnue pour réduire le stress et améliorer la qualité du sommeil." ],
  [ 'Farine de coco bio', 15, "Farine riche en fibres, idéale pour les régimes sans gluten, elle aide à réguler la glycémie." ],
  [ 'Graines de lin bio', 15, "Graines riches en oméga-3 et fibres, elles favorisent la santé digestive et cardiovasculaire." ],
  [ 'Maca bio', 30, "Racine énergisante et adaptogène, elle améliore l'endurance et équilibre le système hormonal." ]
]

products.each do |name, price, long_desc|
  Product.create!(
    name: name,
    description: "Sachet de 300 g – produit 100 % biologique.",
    long_description: long_desc,
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

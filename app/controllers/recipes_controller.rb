class RecipesController < ApplicationController
  def index
    @recipes = [
      {
        title: "Smoothie Énergisant à la Spiruline",
        image_url: "carousel/spiruline.jpg",
        description: "Un smoothie vert riche en nutriments pour booster votre énergie quotidienne."
      },
      {
        title: "Salade Fraîche au Curcuma",
        image_url: "carousel/curcuma.jpg",
        description: "Une salade colorée pleine de saveurs avec une touche de curcuma anti-inflammatoire."
      },
      {
        title: "Tisane Digestive au Romarin",
        image_url: "carousel/romarin.jpg",
        description: "Une infusion relaxante idéale pour faciliter la digestion après les repas."
      },
      {
        title: "Gâteau Santé à la Farine de Coco",
        image_url: "carousel/coco.jpg",
        description: "Un dessert gourmand et sans gluten, parfait pour vos pauses sucrées."
      },
      {
        title: "Granola Maison à la Maca",
        image_url: "carousel/maca.jpg",
        description: "Un granola croustillant pour bien démarrer la journée avec énergie."
      },
      {
        title: "Smoothie Équilibrant à l’Ashwagandha",
        image_url: "carousel/ashwaganda.jpg",
        description: "Une boisson apaisante pour réduire le stress et favoriser la détente."
      }
    ]
  end
end

class AddRecipeToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :recipe, :text
  end
end

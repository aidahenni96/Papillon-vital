class CreateSliderImages < ActiveRecord::Migration[8.0]
  def change
    create_table :slider_images do |t|
      t.string :title

      t.timestamps
    end
  end
end

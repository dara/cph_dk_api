class CreateScrapes < ActiveRecord::Migration[5.0]
  def change
    create_table :scrapes do |t|
      t.string :date, index: true
      t.string :direction, index: true
      t.text :data

      t.timestamps
    end
  end
end

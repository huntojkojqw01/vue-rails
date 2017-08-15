class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name,          null: false
      t.integer :rate

      t.timestamps null: false
    end
  end
end

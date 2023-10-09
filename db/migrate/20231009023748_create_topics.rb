class CreateTopics < ActiveRecord::Migration[7.0]
  def change
    create_table :topics do |t|
      t.string :description
      t.references :author, polymorphic: true, null: false
      t.text :tags
      t.boolean :active

      t.timestamps
    end
  end
end

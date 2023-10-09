class ChangeAuthorInTopics < ActiveRecord::Migration[7.0]
  def change
    change_table :topics do |t|
      t.references :author, null: false, foreign_key: true
    end
  end
end

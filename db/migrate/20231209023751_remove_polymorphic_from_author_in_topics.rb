class RemovePolymorphicFromAuthorInTopics < ActiveRecord::Migration[7.0]
  def change
    change_table :topics do |t|
      t.remove_references :author, polymorphic: true
    end
  end
end

class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.references :topic, index: true, null: false, foreign_key: true
      t.string :vote_type

      t.timestamps
    end
  end
end

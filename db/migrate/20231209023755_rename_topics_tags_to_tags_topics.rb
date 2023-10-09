class RenameTopicsTagsToTagsTopics < ActiveRecord::Migration[7.0]
  def change
    rename_table :topics_tags, :tags_topics
  end
end

class AddAwesomeNestedSetColumnsToTweets < ActiveRecord::Migration[5.2]

  def change
    add_column :tweets, :parent_id, :integer
    add_column :tweets, :lft,       :integer
    add_column :tweets, :rgt,       :integer

    # optional fields
    add_column :tweets, :depth,          :integer
    add_column :tweets, :children_count, :integer

  end
end

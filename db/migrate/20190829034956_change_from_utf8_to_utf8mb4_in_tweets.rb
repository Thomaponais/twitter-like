class ChangeFromUtf8ToUtf8mb4InTweets < ActiveRecord::Migration[5.2]
  def change
    execute "ALTER TABLE tweets CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
    execute "ALTER TABLE tweets MODIFY tweet VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
  end
end

class ApplyDefault < ActiveRecord::Migration[6.0]
  def change
    change_column :posts, :total_comments_count, :integer, default: 0
    change_column :posts, :total_likes_count, :integer, default: 0
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end

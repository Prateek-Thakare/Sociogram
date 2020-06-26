class FixFollowersId < ActiveRecord::Migration[6.0]
  def change
    rename_column :followers, :followers_id, :follower_id
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end

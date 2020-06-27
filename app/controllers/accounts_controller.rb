class AccountsController < ApplicationController
    before_action :authenticate_account!
    before_action :set_account, only: [:profile]

    def index
        #show posts
        followers_ids = Follower.where(follower_id: current_account.id).map(&:following_id)
        # followers_ids << current_account.id
        @posts = Post.paginate(:page => params[:page], :per_page => 2).where(account_id: followers_ids).active
        respond_to do |format|
            format.html
            format.js
        end
        @comment = Comment.new
        following_ids = Follower.where(follower_id: current_account.id).map(&:following_id)
        following_ids << current_account.id
        @follower_suggestions = Account.where.not(id: following_ids)

    end

    def profile
        @posts = @account.posts.active
    end

    def show_followers
        @my_followers = Follower.where(following_id: current_account.id)
      end
    def show_following
        @my_following = Follower.where(follower_id: current_account.id)
      end

    def follow_account
        follower_id  = params[:follow_id]
        if Follower.create!(follower_id: current_account.id, following_id: follower_id )
            flash[:success]  = "Now Following user"
        else
            flash[:success] = "Unable to add Follower"
        end
        
        redirect_back(fallback_location: root_path)
    end

    def unfollow_account
        following_id = params[:follow_id]
        Follower.where(follower_id: current_account.id, following_id: following_id).destroy_all
        flash[:success] = "User unfollowed"
        redirect_back(fallback_location: root_path)
    end
    
    private
    def set_account
        @account = Account.find_by_username(params[:username])
        
    end





end

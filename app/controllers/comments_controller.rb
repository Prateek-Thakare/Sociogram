class CommentsController <  ApplicationController
    before_action :authenticate_account!


    def create
        @comment = Comment.new(comment_params)
        @comment.account_id = current_account.id if account_signed_in?
        if @comment.save
            return_url = params[:comment][:return_to].present? ? post_path(@comment.post_id) : dashboard_path
            
            redirect_to return_url, flash: {success:"Your comment was created successfully"}
        else
            redirect_to new_post_path, flash: {danger:"Your comment was not saved"}
        end
    end

    
    
    private
    def comment_params
        params.require(:comment).permit(:comment, :post_id, :return_to)
    end

end
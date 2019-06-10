class CommentsController < ApplicationController
  before_action :find_commentable
  # before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def new
    @comment = Comment.new
  end
    
  def create
    session[:return_to] ||= request.referer
    @comment = @commentable.comments.new(comment_params)
    @comment.user_id = current_user.id
    
    respond_to do |format|
      if @comment.save
        format.html { redirect_to session.delete(:return_to), notice: 'Your comment was successfully posted!' }
      else
        format.html { redirect_to session.delete(:return_to), danger: 'Enter at least 3 characters' }
      end
    end
      
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:body)
  end
  
  # def require_same_user
  #   if current_user != @comment.user
  #     flash[:warning] = "You can edit or delete your own Comments only"
  #     redirect_to root_path
  #   end
  # end
  
  def find_commentable
    @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    @commentable = Memory.find_by_id(params[:memory_id]) if params[:memory_id]
  end
  
end
class CommentsController < ApplicationController
  before_action :find_commentable
  
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
        format.html { render :new }
      end
    end
      
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:body)
  end
  
  def find_commentable
    @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    @commentable = Memory.find_by_id(params[:memory_id]) if params[:memory_id]
  end
  
end
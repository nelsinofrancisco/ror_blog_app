class UsersController < ApplicationController
  def index
    @logged_user = self.current_user
  end

  def show
    @logged_user = self.current_user
    @user = User.find(params[:id])
    @recent_posts = @user.recent_posts
  end

  def new
    @comment = Comment.new
    @like = Like.new
    @post = Post.new
  end

  def create
    begin
      params.require(:post)
    rescue => exception
    else
      handle_post_creation
    end

    begin
      params.require(:comment)
    rescue => exception
    else
      handle_comment_creation
    end

    begin
      params.require(:like)
    rescue => exception
    else
      handle_like_creation
    end
  end

  private 

  def handle_post_creation
    @post = Post.new(params.require(:post).permit(:author_id, :title, :text, :text, :comments_counter, :likes_counter))

    respond_to do |format|
      format.html do
        if @post.save
          flash[:success] = "Question saved successfully"
          redirect_to user_posts_path(@post.user.id)
        else
          flash.now[:error] = "Error: Question could not be saved"
        end
      end
    end
  end

  def handle_comment_creation
    @logged_user = self.current_user
    @comment = Comment.new(params.require(:comment).permit(:author_id, :post_id, :text))

    respond_to do |format|
      format.html do
        if @comment.save
          flash[:success] = "Question saved successfully"
          redirect_to request.referrer
        else
          flash.now[:error] = "Error: Question could not be saved"
        end
      end
    end
  end

  def handle_like_creation
    @like = Like.new(params.require(:like).permit(:author_id, :post_id))

    respond_to do |format|
      format.html do
        if @like.save
          flash[:success] = "Question saved successfully"
          redirect_to request.referrer
        else
          flash.now[:error] = "Error: Question could not be saved"
        end
      end
    end
  end
end

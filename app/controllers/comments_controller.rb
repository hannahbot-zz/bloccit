class CommentsController < ApplicationController
  respond_to :html, :js

  def create
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @comments = @post.comments

    @comment = current_user.comments.build(comment_params)
    @comment.post = @post

    authorize! :create, @comment, message: "You need to be signed up to do that."
    if @comment.save
      redirect_to [@topic, @post], notice: "Post was saved successfully."
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render 'posts/show'
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    authorize! :destroy, @comment, message: "You need to be own the comment to do that."

    if @comment.destroy
      flash[:notice] = "Comment was removed"
    else
      flash[:error] = "There was an error saving the post. Please try again."
    end  

    respond_with(@comment) do |f|
      f.html { redirect_to [@topic, @post]}
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body, :post)
    end
end

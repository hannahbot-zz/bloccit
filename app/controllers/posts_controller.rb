class PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
    @topic = Topic.find(params[:topic_id])
  end

  def create
    @post = current_user.posts.build(post_params)
    @topic = Topic.find(params[:topic_id])
    authorize! :create, @post, message: "You need to be signed up to do that."
  if @post.save
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def new
    @post = Post.new
    @topic = Topic.find(params[:topic_id])
    authorize! :create, Post, message: "You need to be a member to create a new post."
  end

  def edit
    @post = Post.find(params[:id])
    @topic = Topic.find(params[:topic_id])
    authorize! :edit, @post, message: "You need to own the post to edit it."
  end

  def update
    @post = Post.find(params[:id])
    @topic = Topic.find(params[:topic_id])
    authorize! :update, @post, message: "You need to own the post to edit it."
    if @post.update_attributes(post_params)
      flash[:notice] = "Post was updated."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :body)
    end
end

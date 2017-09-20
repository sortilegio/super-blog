class PostsController < ApplicationController
  def index
	  @posts = Post.order('created_at DESC')
	end

	def new
	 @post = Post.new
	end

  def create
    @post = Post.new(post_params)
    @post.user = current_user #relaciona usuario actual
      if @post.save
      	 redirect_to posts_path, notice:"El post fue públicado correctamente"
      else
         render :new
      end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
     	redirect_to posts_path, notice:"El post se ha modificado correctamente"
    else
     	render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path, notice: "El posta se ha eliminado correctamente"
  end

  private
    def post_params
      params.required(:post).permit(:title, :body)
    end
end

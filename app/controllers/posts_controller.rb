class PostsController < ApplicationController

	before_action :authenticate_user!
	before_action :find_group
	before_action :find_post, :only => [:edit, :update, :destroy]

	def new 
		@post = @group.posts.new
	end	

	def create
		@post = @group.posts.new(post_params)
		@post.author = current_user
		if @post.save
			redirect_to group_path(@group), :notice => 'New post success'
		else
			render :new
		end
	end

	def edit
	end

	def update
		if @post.update(post_params)
			redirect_to group_path(@group), :notice => 'Update post success'
		else
			render :edit
		end
	end

	def destroy		
		@post.destroy
		redirect_to group_path(@group), :alert => 'Post delleted'
	end

end

private
	def post_params
		params.require(:post).permit(:content)
	end

	def find_group
		@group = Group.find(params[:group_id])
	end

	def find_post		
		@post = current_user.posts.find(params[:id])
	end

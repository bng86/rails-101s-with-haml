class GroupsController < ApplicationController
	def index
		@groups = Group.all
	end

	def show		
		@group = Group.find(params[:id])
		@posts = @group.posts
	end

	def new		
		@group = Group.new
	end

	def edit		
		@group = Group.find(params[:id])
	end

	def create		
		@group = Group.new(group_params)
  
    if @group.save 
      redirect_to groups_path, :notice => 'New group success'
    else
      render :new
    end
	end

	def update		
		@group = Group.find(params[:id])

		if @group.update(group_params)
			redirect_to groups_path, :notice => 'Update group success'
		else
			render :edit
		end
	end

	def destroy		
		@group = Group.find(params[:id])

		@group.destroy
		redirect_to groups_path, :alert => 'Group deleted'		
	end

end

private
	def group_params
		params.require(:group).permit(:title, :description)
	end

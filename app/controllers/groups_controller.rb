class GroupsController < ApplicationController

	before_action :find_group, :only => [:show, :edit, :update, :destroy]

	def index
		@groups = Group.all
	end

	def show		
		@posts = @group.posts
	end

	def new		
		@group = Group.new
	end

	def edit		
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
		if @group.update(group_params)
			redirect_to groups_path, :notice => 'Update group success'
		else
			render :edit
		end
	end

	def destroy		
		@group.destroy
		redirect_to groups_path, :alert => 'Group deleted'		
	end

end

private
	def group_params
		params.require(:group).permit(:title, :description)
	end

	def find_group
		@group = Group.find(params[:id])
	end

class GroupsController < ApplicationController
	
	before_action :authenticate_user!, :only => [:new, :edit, :create, :update, :destroy] 
	before_action :find_group, :only => [:edit, :update, :destroy]

	def index
		@groups = Group.all
	end

	def join
    @group = Group.find(params[:id])

    if !current_user.is_member_of?(@group)
      current_user.join!(@group)
      flash[:notice] = "Join group success"
    else
      flash[:warning] = "Already join"
    end

    redirect_to group_path(@group)
  end

  def quit
    @group = Group.find(params[:id])

    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
      flash[:alert] = "Quit group"
    else
      flash[:warning] = "Quit group fail"
    end

    redirect_to group_path(@group)
  end

	def show
		@group = Group.find(params[:id])		
		@posts = @group.posts
	end

	def new		
		@group = Group.new
	end

	def edit		
	end

	def create		
		@group = current_user.groups.new(group_params)
  
    if @group.save 
    	current_user.join!(@group)
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
		@group = current_user.groups.find(params[:id])
	end

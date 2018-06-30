class GroupsController < ApplicationController
  def new
    if @group = current_user.group.nil?
      @group = current_user.build_group
    else
      redirect_to edit_group_path(current_user.group)
    end
  end
  
  def edit
    @group = current_user.group
  end
  
  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(group_params)
      redirect_to current_user
    else
      render 'edit'
    end
  end
  
  def show
    @group = Group.find(params[:id])
  end
  
  def create
    @group = current_user.build_group(group_params)
    if @group.save
      redirect_to current_user
    else
      render 'new'
    end
  end
  
  private
    def group_params
      params.require(:group).permit(:user_id, :info)
    end
  
end

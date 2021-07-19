class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    @prototypes = current_user.prototypes
    @prototypes = user.prototypes
  end
end

  def create
    @user = User.new(user_params)
    if @user.save
     redirect_to users_path
    else
      render action: :new
  end
end

class PrototypesController < ApplicationController
  #before_action :set_prototype, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index, :show]
  #before_action :contributor_confirmation, only: [:edit, :update, :destroy]
  
  def index
    @users = User.all 
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    #Prototype.create (prototype_params)
    #@prototype = Prototype.create
    @prototype = Prototype.new(prototype_params)
  if @prototype.save
      redirect_to root_path 
    else
      render :new
    end
  end

  def show
   @prototype = Prototype.find(params[:id])
   @comment = Comment.new
   @comments = @prototype.comments.includes(:user)
   #@comments = Comment.find_by(id:params[:id], prototype_id: params[:prototype_id])     
  end

  def edit
    @prototype = Prototype.find(params[:id])
  #  if @prototype.user_id == current_user.id
  #     render :edit
  #   else
  #     redirect_to root_path 
  #   end 
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path
    else
      render :edit
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    if @prototype.destroy
      redirect_to root_path
    end    
  end

  private  # private以下の記述はすべてプライベートメソッドになる
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id:current_user.id)
  end

  def contributor_confirmation
    redirect_to root_path unless current_user == @prototype.user
  end
end

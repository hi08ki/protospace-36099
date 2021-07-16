class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
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
   @comments = @prototype.comments
   #@comments = Comment.find_by(id:params[:id], prototype_id: params[:prototype_id])     
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    prototype = Prototype.find(params[:id])
    if prototype.update(prototype_params)
      redirect_to prototype_path
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    if prototype.destroy
      redirect_to root_path
    end    
  end

  private  # private以下の記述はすべてプライベートメソッドになる
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id:current_user.id)
  end

end

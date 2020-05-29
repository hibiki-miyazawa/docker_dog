class DogsController < ApplicationController
  before_action :logged_in_user, only:[:new]
  before_action :correct_user, only:[:destroy]
  
  def new
    @dog = current_user.dogs.new
  end

  def create
    @dog = current_user.dogs.new(dog_params)
    if @dog.save
      flash[:success] = "Done"
      redirect_to @dog
    else
      render 'new'
    end
  end

  def show
    @dog = Dog.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
    @dog.destroy
    flash[:success] = "Dog deleted."
    redirect_to root_path
  end

  private

    def dog_params
      params.require(:dog).permit(:name, :gender, :birthday, :breed, :hospital, :salon, :image_name)
    end

    def correct_user
      @dog = current_user.dogs.find_by(id:params[:id])
      redirect_to root_url if @dog.nil?
    end
end

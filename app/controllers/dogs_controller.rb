class DogsController < ApplicationController
  before_action :logged_in_user, only:[:new]
  
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
    def show
      @dog = Dog.find(params[:id])
    end
  end

  private

    def dog_params
      params.require(:dog).permit(:name, :gender, :birthday, :breed, :hospital, :salon, :image_name)
    end
end

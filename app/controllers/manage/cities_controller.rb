class Manage::CitiesController < Manage::ApplicationController
  def index
    @cities = City.all
  end

  def edit
    @city = City.find(params[:id])
  end

  def update
    @city = City.find(params[:id])
    if @city.update_attributes(params[:city])
      redirect_to [:manage, :cities]
    else
      render :action => :edit
    end
  end

  def new
    @city = City.new
  end

  def create
    @city = City.new(params[:city])
    if @city.save
      redirect_to [:manage, :cities]
    else
      render :action => :new
    end
  end

  def destroy
    City.find(params[:id]).destroy
    redirect_to [:manage, :cities] and return
  end
end

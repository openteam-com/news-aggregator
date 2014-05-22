# encoding: utf-8
class Manage::SourcesController < Manage::ApplicationController
  def index
    @sources = Source.order('source, title')
  end

  def new
    @source = Source.new
  end

  def create
    @source = Source.new(params[:source])
    if @source.save
      #flash[:notice] = "Источник добавлен"
      redirect_to [:manage, :sources]
    else
      #flash[:alert] = "Источник не может быть добавлен"
      render :action => :new
    end
  end

  def edit
    @source = Source.find(params[:id])
  end

  def update
    @source = Source.find(params[:id])
    if @source.update_attributes(params[:source])
      #flash[:notice] = "Источник добавлен"
      redirect_to [:manage, :sources]
    else
      #flash[:alert] = "Источник не может быть сохранен"
      render :action => :edit
    end
  end

  def destroy
    @source = Source.find(params[:id])
    @source.destroy
    redirect_to [:manage, :sources]
  end

end

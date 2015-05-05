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
      redirect_to [:manage, :sources]
    else
      render :action => :new
    end
  end

  def edit
    @source = Source.find(params[:id])
  end

  def update
    @source = Source.find(params[:id])
    if @source.update_attributes(params[:source])
      redirect_to [:manage, :sources]
    else
      render :action => :edit
    end
  end

  def destroy
    @source = Source.find(params[:id])
    @source.destroy
    redirect_to [:manage, :sources]
  end

end

class ItemsController < ApplicationController
  before_filter :create_lists, :only=>[:new, :edit]
  
  def new
    @item = Item.new
    render :action=>"action"
  end
  
  def create
    @item = Item.new params[:item]
    begin
      @item.save!
      flash[:notice] = "#{@item.name} has been saved"
      redirect_to items_path
    rescue ActiveRecord::RecordInvalid
      render :action=> "action"
    end
  end
  
  def edit
    @item = Item.find params[:id]
    render :action=> "action"
  end
  
  def update
    @item = Item.find params[:id]
    begin
      @item.update_attributes params[:item]
      flash[:notice] = "#{@item.name} has been saved"
      redirect_to items_path
    rescue ActiveRecord::RecordInvalid
      render :action=> "action"
    end
  end
  
  def index
    @items = Item.all
  end
  
  def destroy
    item = Item.find(params[:id])
    @item = item.destroy
    flash[:notice] = "#{@item.name} has been deleted"
    redirect_to items_path
  end

  
  private
  
  def create_lists
    @item_types = item_types_list
    @creator_types = creator_types_list
    @key_types = key_types_list
  end
end

class ItemTypesController < ApplicationController
  
  def new
    @item_type = ItemType.new
    render :action=>"action"
  end
  
  def create
    @item_type = ItemType.new params[:item_type]
    begin
      @item_type.save!
      flash[:notice] = "#{@item_type.name} has been saved"
      redirect_to item_types_path
    rescue ActiveRecord::RecordInvalid
      render :action=> "action"
    end
  end
  
  def edit
    @item_type = ItemType.find params[:id]
    render :action=> "action"
  end
  
  def update
    @item_type = ItemType.find params[:id]
    begin
      @item_type.update_attributes params[:item_type]
      flash[:notice] = "#{@item_type.name} has been saved"
      redirect_to item_types_path
    rescue ActiveRecord::RecordInvalid
      render :action=> "action"
    end
  end
  
  def index
    @item_types = ItemType.all
  end
  
  def destroy
    item_type = ItemType.find(params[:id])
    @item_type = item_type.destroy
    flash[:notice] = "#{@item_type.name} has been deleted"
    redirect_to item_types_path
  end
end

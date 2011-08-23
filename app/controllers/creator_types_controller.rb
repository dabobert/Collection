class CreatorTypesController < ApplicationController
  
  def new
    @creator_type = CreatorType.new
    @item_types   = ItemType.all
    render :action=>"action"
  end
  
  def create
    @creator_type = CreatorType.new params[:creator_type]
    begin
      @creator_type.save!
      flash[:notice] = "#{@creator_type.name} has been saved"
      redirect_to creator_types_path
    rescue ActiveRecord::RecordInvalid
      render :action=> "action"
    end
  end
  
  def edit
    @creator_type = CreatorType.find params[:id]
    @item_types   = ItemType.all
    render :action=> "action"
  end
  
  def update
    @creator_type = CreatorType.find params[:id]
    begin
      @creator_type.update_attributes! params[:creator_type]
      flash[:notice] = "#{@creator_type.name} has been saved"
      redirect_to creator_types_path
    rescue ActiveRecord::RecordInvalid
      render :action=> "action"
    end
  end
  
  def index
    @creator_types = CreatorType.all
  end
  
  def destroy
    creator_type = CreatorType.find(params[:id])
    @creator_type = creator_type.destroy
    flash[:notice] = "#{@creator_type.name} has been deleted"
    redirect_to creator_types_path
  end

end

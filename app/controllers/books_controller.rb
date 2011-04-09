class BooksController < ApplicationController
  before_filter :set_category
  
  
  def index
  end
  
  def new
    @item = Item.new
    @type = "isbn"
    render :template=>"shared/action"
  end
  
  
  def create
    @type   = params[:type]
    @value  = params[:value]
    @item = Item.lookup @type, @value
    begin
      @item.save!
      @item.user_id = 1
      flash[:notice] = render_to_string :partial=>"item", :object=>@item
      redirect_to :action=>:new
    rescue ActiveRecord::RecordInvalid
      respond_to do |format|
        response = render_to_string :text=>"text" #{}"error setting the address for the resume"
        format.html { render(:text=>response, :status=>409)}
        format.json { render(:json => {:html=>response}, :status => "409") }
      end
      
    end
  end
  
  
  def show
  end
  
  private
  
  def set_category
    @category = "books"
  end

end

class BooksController < ApplicationController
  before_filter :set_category
  
  
  def index
    if params[:creator_id]
      @creator = Creator.find(params[:creator_id])
      items = @creator.items.where(:itemable_type=>"Book")
      @books = items.collect do |item|
        item.itemable
      end
      @books = @books.uniq.sort do |a,b| a.item.name <=> b.item.name end
    elsif params[:metadatum_id]
      @metadatum = Metadatum.find(params[:metadatum_id])
      items = @metadatum.items.find(:all, :conditions=>"itemable_type='Book'")
      @books = items.collect do |item|
        item.itemable
      end
      @books.uniq.sort do |a,b| a.item.name <=> b.item.name end unless @books.blank?
    else
      @books = Book.all.sort do |a,b| a.item.name <=> b.item.name end
    end
  end
  
  def new
    @item = Item.new
    @type = "isbn"
    render :template=>"shared/action"
  end
  
  
  def create
    @value  = params[:value]
    @item = Item.lookup @value
    begin
      @item.save!
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
    @book = Book.find(params[:id])
  end
  
  def destroy
    book = Book.find(params[:id])
    @name = book.item.name
    book.destroy
    flash[:notice] = "#{@name} has been deleted"
    redirect_to books_path
  end
  
  private
  
  def set_category
    @category = "books"
  end

end

class BooksController < ApplicationController

  def new
    @book =Book.new
  end
    
  def create
    @book = Book.new(book_params)
    @book.user_id = Current.user.id
    if @book.save
      redirect_to book_path(@book)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @books = Book.all
    @book = Book.new
    @users = User.all
    @user = Current.user
  end

  def show
    @book_params = Book.find(params[:id])
    @book = Book.new
    @users = User.all
    @user = Current.user
  end

  def edit
    @book = Book.find(params[:id]) 
  end

  def update
    book = Book.find(params[:id])
    book.update(book_params)
    redirect_to book_path(book.id)  
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy  
    redirect_to '/books'  
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end

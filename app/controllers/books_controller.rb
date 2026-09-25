class BooksController < ApplicationController

  def new
    @book =Book.new
  end
    
  def create
    @book = Book.new(book_params)
    @book.user_id = Current.user.id
    if @book.save
      redirect_to book_path(@book), notice:"You have created book successfully."
    else
      @books = Book.all
      @user = Current.user
      render :index, status: :unprocessable_entity
    end
  end

  def index
    @books = Book.all
    @book = Book.new
    @users = User.all
    @user = Current.user
    @book_comment = BookComment.new 
  end

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    @current_user = Current.user
    @book_comment = BookComment.new 
  end

  def edit
    is_matching_login_user
    @book = Book.find(params[:id]) 
  end

  def update
    is_matching_login_user
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render :edit, status: :unprocessable_entity
    end
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

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == Current.user.id
      redirect_to books_path
    end
  end

end

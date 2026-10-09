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
    if params[:latest]
      @books = Book.latest
    elsif params[:star_count]
      @books = Book.star_count
    elsif params[:favorite_count] 
      @books = Book.sort_by_favorites_last_week
    else
      @books = Book.all
    end
    @book = Book.new
    @users = User.all
    @user = Current.user
    @book_comment = BookComment.new 
  end

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @book.increment!(:view_counts)
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
    params.require(:book).permit(:title, :body, :score, :category)
  end

  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user.id == Current.user.id 
      redirect_to books_path
    end
  end

end

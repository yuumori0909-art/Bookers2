class SearchesController < ApplicationController

  def search
    @target = params[:target]
    @word = params[:word]
    @search = params[:search]

    if @target == "User"
      @users = User.looks(@search, @word)
      elsif @target == "Books"
      @books = Book.looks(@search, @word)
      elsif @target == 'Tag'
      @books = Book.where("category LIKE ?", "%#{@word}%")
    end

  end
end

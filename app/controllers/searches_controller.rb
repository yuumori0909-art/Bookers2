class SearchesController < ApplicationController

  def search
    @target = params[:target]
    @word = params[:word]
    @search = params[:search]

    if @target == "User"
      @users = User.looks(@search, @word)
      else
      @books = Book.looks(@search, @word)
    end

  end
end

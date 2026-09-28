class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @comment = Current.user.book_comments.new(book_comment_params)
    @comment.book_id = @book.id
    if @comment.save
      @book_comment = BookComment.new 

      respond_to do |format|
        format.turbo_stream 
      end
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    BookComment.find(params[:id]).destroy

    @book_comment = BookComment.new 
    
    respond_to do |format|
      format.turbo_stream 
    end
  end

  private
  
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
